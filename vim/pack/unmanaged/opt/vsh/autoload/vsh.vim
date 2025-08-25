
function! s:reload_env()
	if exists('v:servername')
		let l:fmfile="/tmp/vsh-"..$USER.."/fm/"..v:servername..".vim"
		if filereadable(l:fmfile)
			exec "source "..fmfile
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
		exec a:line."normal zC"
		let l:ret = a:end ? foldclosedend(a:line) : foldclosed(a:line)
		if l:closed != foldclosed(a:line)
			exec a:line."normal zo"
		endif
	endif
	return l:ret
endfunction

function! vsh#Load()
	if !exists('g:fm_macros')
		let g:fm_macros = {}
	endif
	if !exists('g:vsh_default_pwd')
		let g:vsh_default_pwd = 1
		let $PWD = getcwd()
	endif
	if ! exists('b:vsh_lvl')
		let b:vsh_lvl = 0
	endif
	call FirstModeLine()
endfunc

function! vsh#VshMacro(match)
	return a:match[1] == "%" ? "%" : Fm(a:match[1])
endfunction

function! vsh#Expand(lines)
	let l:expand_pat = "%\\([fpsctd%]\\)"
	return substitute(a:lines,l:expand_pat,function('vsh#VshMacro'),'g')"
endfunction

function! vsh#RunVim(lines)
	for l in a:lines
		exec l
	endfor
endfunction

function! vsh#Run() range
	let [l:firstline,l:lastline]=[s:foldLine(a:firstline),s:foldLine(a:lastline,1)]
	let l:lines=map(getline(l:firstline,l:lastline),'vsh#Expand(v:val)')
	if getline(l:firstline)[0] == ":"
		call vsh#RunVim(lines)
	else
		let l:vsh_dir = "/tmp/vsh-"..$USER
		eval system("mkdir -p '"..vsh_dir.."'")
		let l:tempfile=systemlist("mktemp '"..vsh_dir.."/run.XXXXXXXXXX'")[0]
		let l:envfile=l:tempfile..".env"
		defer delete(l:tempfile)
		defer delete(l:envfile)
		call writefile(lines, l:tempfile, 'S')
		exec '!clear;'
		\ .. 'cd '..shellescape(getcwd())..';'
		\ .. 'echo -n >'..l:envfile..';'
		\ .. 'source '..l:tempfile..';'
		\ .. 'env -0 -u SHLVL -u OLDPWD -u _ >'..l:envfile
		redraw
		if b:vsh_lvl >= 1
			let l:vars=readfile(l:envfile)->join("\uABCD")->split("\n")
			let l:vars=l:vars->map('v:val->substitute("\uABCD","\n","g")')
			let l:vars=l:vars->map('[strpart(v:val,0,stridx(v:val,"=")),strpart(v:val,stridx(v:val,"=") + 1)]')
			for v in vars
				if v[0] == 'PWD'
					continue
				elseif getenv(v[0]) != (v[1] == "" ? v:null : v[1])
					call setenv(v[0],v[1])
					if b:vsh_lvl >= 2
						call setenv(v[0],v[1])
						eval job_start([ 'tmux', 'set-env', v[0], v[1] ])
						echoh Constant | echom "let "..v[0].."="..v[1] | echoh None
					else
						echoh Label | echom "let "..v[0].."="..v[1] | echoh None
					endif
				endif
			endfor
		endif
	endif
endfunction

function! vsh#TmuxRun() range
	let [l:firstline,l:lastline]=[s:foldLine(a:firstline),s:foldLine(a:lastline,1)]
	let l:name=getline(l:firstline)
	let l:lines=["tmux set-option -p remain-on-exit on","echo"]
	let l:lines+=getline(l:firstline,l:lastline)
	eval job_start([ 'tmux', 'new-window',
				\	'-n', l:name,
				\	l:lines->join("\n")
				\ ])
endfunction

augroup vsh
	au!
	au FocusGained * call <SID>reload_env()
	au InsertLeave *.vsh normal zx
augroup END

call s:reload_env()

let s:reload_me = 1
