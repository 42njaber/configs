
function! s:reload_env()
	if exists('v:servername')
		let l:fmfile="/tmp/vsh/fm/"..v:servername..".vim"
		if filereadable(l:fmfile)
			exec "source "..fmfile
			echoh Label
			echo 'Updated ranger macros'
			echoh None
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

function! s:synstackDepth(lnum)
	let stack = synstack(a:lnum,getline(a:lnum)->len())
	let groups = [hlID('shExpr'),hlID('shHereDoc'),hlID('shParen'),hlID('shDo')]

	let counter = 0
	for synID in stack
		if index(groups,synID) >= 0
			let counter += 1
		endif
	endfor
	return counter
endfunction

function! vsh#run#FoldLevel(lnum)
	let l:prev_lvl = a:lnum == 0 ? 0 : s:synstackDepth(a:lnum - 1)
	let l:next_lvl = s:synstackDepth(a:lnum)

	return max([prev_lvl,next_lvl])
endfunc

function! vsh#run#Load()
	if !exists('g:fm_macros')
		let g:fm_macros = {}
	endif
	if !exists('g:vsh_default_pwd')
		let g:vsh_default_pwd = 1
		let $PWD = getcwd()
	endif
	let b:vsh_lvl = 0
	call FirstModeLine()
endfunc

function! vsh#run#VshMacro(match)
	return a:match[1] == "%" ? "%" : Fm(a:match[1])
endfunction

function! vsh#run#Expand(lines)
	let l:expand_pat = "%\\([fpsctd%]\\)"
	return substitute(a:lines,l:expand_pat,function('vsh#run#VshMacro'),'g')"
endfunction

function! vsh#run#RunVim(lines)
	for l in a:lines
		exec l
	endfor
endfunction

function! vsh#run#Run() range
	let [l:firstline,l:lastline]=[s:foldLine(a:firstline),s:foldLine(a:lastline,1)]
	let l:lines=map(getline(l:firstline,l:lastline),'vsh#run#Expand(v:val)')
	if getline(l:firstline)[0] == ":"
		call vsh#run#RunVim(lines)
	else
		eval system("mkdir -p /tmp/vsh")
		let l:tempfile=systemlist("mktemp /tmp/vsh/run.XXXXXXXXXX")[0]
		call writefile(lines, l:tempfile, 'DS')
		exec '!clear;cd '..shellescape(getenv('PWD'))..';source '..l:tempfile..';env -u SHLVL -u OLDPWD -u _ >'..l:tempfile
		redraw
		if b:vsh_lvl >= 1
			let l:vars=readfile(l:tempfile)
			let l:vars=map(l:vars,'[strpart(v:val,0,stridx(v:val,"=")),strpart(v:val,stridx(v:val,"=") + 1)]')
			let l:vars=filter(l:vars,'getenv(v:val[0]) != (v:val[1] == "" ? v:null : v:val[1])')
			echoh Label
			for v in vars 
				call setenv(v[0],v[1])
				echom "let "..v[0].."="..v[1]
				if v[0] == "PWD" && b:vsh_lvl >= 2
					exec "cd "..v[1]
					echom "cd "..v[1]
				endif
			endfor
			echoh None
		endif
	endif
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
