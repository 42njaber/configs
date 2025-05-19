
function! s:reload_env()
	if exists('v:servername')
		let l:fmfile="/tmp/vsh/fm/"..v:servername..".vim"
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

" function! s:synstackDepth(lnum)
" 	let end = getline(a:lnum)->len()
" 	let stack = synstack(a:lnum,l:end + 1)
" 	let groups = ["shExpr","shHereDoc","shParen","shDo","shIf","shSingleQuote","shDoubleQuote"]->map('hlID(v:val)')
" 
" 	let counter = 0
" 	for synID in stack
" 		if index(groups,synID) >= 0
" 			let counter += 1
" 		endif
" 	endfor
" 	return counter
" endfunction

" function! vsh#FoldLevel(lnum)
" 	let l:prev_lvl = a:lnum == 0 ? 0 : s:synstackDepth(a:lnum - 1)
" 	let l:next_lvl = s:synstackDepth(a:lnum)
" 
" 	if prev_lvl == next_lvl
" 		return -1
" 	elseif prev_lvl < next_lvl
" 		return '>'..next_lvl
" 	elseif prev_lvl > next_lvl
" 		return '<'..prev_lvl
" 	endif
" endfunc

function! vsh#Load()
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
		eval system("mkdir -p /tmp/vsh")
		let l:tempfile=systemlist("mktemp /tmp/vsh/run.XXXXXXXXXX")[0]
		let l:envfile=l:tempfile..".env"
		call writefile(lines, l:tempfile, 'DS')
		exec '!clear;cd '..shellescape(getcwd())..';source '..l:tempfile..';env -0 -u SHLVL -u OLDPWD -u _ >'..l:tempfile
		redraw
		if b:vsh_lvl >= 1
			let l:vars=readfile(l:tempfile)->join("\uABCD")->split("\n")
			let l:vars=l:vars->map('v:val->substitute("\uABCD","\n","g")')
			let l:vars=l:vars->map('[strpart(v:val,0,stridx(v:val,"=")),strpart(v:val,stridx(v:val,"=") + 1)]')
			let l:vars=l:vars->filter('v:val[0] != "PWD" && getenv(v:val[0]) != (v:val[1] == "" ? v:null : v:val[1])')
			echoh Label
			for v in vars
				call setenv(v[0],v[1])
				echom "let "..v[0].."="..v[1]
			endfor
			echoh None
		endif
	endif
endfunction

function! vsh#TmuxRun() range
	let [l:firstline,l:lastline]=[s:foldLine(a:firstline),s:foldLine(a:lastline,1)]
	let l:name=getline(l:firstline)
	eval system("mkdir -p /tmp/vsh")
	let l:tempfile=systemlist("mktemp /tmp/vsh/tmuxrun.XXXXXXXXXX")[0]
	let l:envfile=l:tempfile..".env"
	let l:env = map(items(environ()),'"export "..v:val[0].."="..shellescape(v:val[1])')
	call writefile(["tmux set-option -p remain-on-exit on","echo"] + l:env,l:envfile)
	silent exec l:firstline..','..l:lastline..'w! '..l:tempfile..''
	eval job_start([ 'tmux', 'new-window',
				\	'-n', l:name,
				\	'env - BASH_ENV='..l:envfile..' bash -e '..l:tempfile
				\ ])
endfunction

augroup vsh
	au!
	au FocusGained * call <SID>reload_env()
	au InsertLeave *.vsh normal zx
augroup END

call s:reload_env()

let s:reload_me = 1
