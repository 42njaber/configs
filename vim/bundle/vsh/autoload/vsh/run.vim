
function! s:reload_env()
	if exists('v:servername')
		let l:fmfile="/tmp/vsh/fm/"..v:servername..".vim"
		if filereadable(l:fmfile)
			exec "source "..l:fmfile
		endif
	endif
endfunc

function! Fm(macro,escape=1)
	if exists('g:fm_macros')
		let l:ret = copy(g:fm_macros[a:macro])
		if a:escape
			return (type(l:ret) == type([])) ? join(map(l:ret,'shellescape(v:val)')," ") : shellescape(l:ret)
		else
			return (type(l:ret) == type([])) ? join(l:ret," ") : l:ret
		endif
	else
		return ""
	endif
endfunc

function! s:foldLine(line,end=0)
	if foldlevel(a:line) == 0
		let l:ret = a:line
	else
		let l:closed = foldclosed(a:line)
		exec a:line."g/^/normal zC"
		let l:ret = a:end ? foldclosedend(a:line) : foldclosed(a:line)
		if l:closed != foldclosed(a:line)
			exec a:line."g/^/normal zo"
		endif
	endif
	return l:ret
endfunction

function! vsh#run#Load()
	if !exists('g:fm_macros')
		g:fm_macros = {}
	endif
endfunc

function! vsh#run#VshMacro(match)
	return a:match == "%" ? "%" : Fm(a:match)
endfunction

function! vsh#run#Expand() range
	let [l:firstline,l:lastline]=[s:foldLine(a:firstline),s:foldLine(a:lastline,1)]
	let l:expand_pat = "%\\([fpsctd%]\\)"
	exec l:firstline.",".l:lastline "s/"..l:expand_pat.."/\\=vsh#run#VshMacro(submatch(1))/eg"
endfunction

function! vsh#run#Run() range
	let [l:firstline,l:lastline]=[s:foldLine(a:firstline),s:foldLine(a:lastline,1)]
	let l:lastchange=changenr()
	exec l:firstline.",".l:lastline "call vsh#run#Expand()"
	if getline(l:firstline)[0] == ":"
		exec l:firstline.",".l:lastline "call vsh#run#RunVim()"
	else
		eval system("mkdir -p /tmp/vsh")
		let l:tempfile=systemlist("mktemp /tmp/vsh/run.XXXXXXXXXX")[0]
		silent exec l:firstline..','..l:lastline..'w! '..l:tempfile
		exec '!clear;cd '..shellescape(getenv('PWD'))..';source '..l:tempfile..';env -u SHLVL -u OLDPWD -u _ >'..l:tempfile
		redraw
		if exists('b:vsh_dynamic') && b:vsh_dynamic
			let l:vars=readfile(l:tempfile)
			let l:vars=map(l:vars,'[strpart(v:val,0,stridx(v:val,"=")),strpart(v:val,stridx(v:val,"=") + 1)]')
			let l:vars=filter(l:vars,'getenv(v:val[0]) != (v:val[1] == "" ? v:null : v:val[1])')
			echoh Label
			for v in vars 
				call setenv(v[0],v[1])
				echom "let "..v[0].."="..v[1]
				if v[0] == "PWD" && exists('b:vsh_cwd') && b:vsh_cwd
					exec "cd "..v[1]
					echom "cd "..v[1]
				endif
			endfor
			echoh None
		endif
		eval system("rm "..l:tempfile)
	endif
	silent exec "undo "..l:lastchange
endfunction

function! vsh#run#RunVim() range
	let [l:firstline,l:lastline]=[a:firstline,a:lastline]
	exec l:firstline.",".l:lastline "g/^/ exec getline(\".\")"
endfunction

function! vsh#run#TmuxRun() range
	let [l:firstline,l:lastline]=[s:foldLine(a:firstline),s:foldLine(a:lastline,1)]
	let l:name=getline(l:firstline)
	eval system("mkdir -p /tmp/vsh")
	let l:tempfile=systemlist("mktemp /tmp/vsh/tmuxrun.XXXXXXXXXX")[0]
	let l:envfile=l:tempfile..".env"
	let l:env = map(items(environ()),'"export "..v:val[0].."="..shellescape(v:val[1])')
	call writefile(["tmux set-option -p remain-on-exit on"] + l:env,l:envfile)
	silent exec l:firstline..','..l:lastline..'w! '..l:tempfile..''
	eval job_start([ 'tmux', 'new-window',
				\	'-n', l:name,
				\	'env - BASH_ENV='..l:envfile..' bash -e '..l:tempfile
				\ ])
endfunction

augroup vsh
	au!
	autocmd FocusGained * call <SID>reload_env()
augroup END

call s:reload_env()
