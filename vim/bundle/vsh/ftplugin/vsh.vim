
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

function! Run() range
	let [l:firstline,l:lastline]=[s:foldLine(a:firstline),s:foldLine(a:lastline,1)]
	if getline(l:firstline)[0] == ":"
		exec l:firstline.",".l:lastline "call RunVim()"
	else
		eval system("mkdir -p /tmp/vsh")
		let l:tempfile=systemlist("mktemp /tmp/vsh/run.XXXXXXXXXX")[0]
		silent exec l:firstline..','..l:lastline..'w! '..l:tempfile
		exec '!clear;bash -e '..l:tempfile
		eval system("rm "..l:tempfile)
	endif
endfunction

function! RunVim() range
	let [l:firstline,l:lastline]=[a:firstline,a:lastline]
	exec l:firstline.",".l:lastline "g/^/ exec getline(\".\")"
endfunction

function! TmuxRun() range
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

nnoremap <buffer><silent>	<CR>	:call Run()<CR>
vnoremap <buffer><silent>	<CR>	:call Run()<CR>

nnoremap <buffer>	!		:call TmuxRun()<CR><CR>
vnoremap <buffer>	!		:call TmuxRun()<CR><CR>

augroup vsh
	autocmd!
augroup END

set nocindent
setlocal foldcolumn=3
