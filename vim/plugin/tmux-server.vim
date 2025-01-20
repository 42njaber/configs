
" set term&
if !has('gui') && (&term =~ "^screen" || &term =~ "^tmux")
	set t_ti&
	set t_te&
	set term=tmux-256color
	set <xUp>=[1;*A
	set <xDown>=[1;*B
	set <xRight>=[1;*C
	set <xLeft>=[1;*D
	set <PasteStart>=[200~
	set <PasteEnd>=[201~
endif

set sessionoptions=curdir,folds,options,buffers,tabpages,help,winpos,winsize
function! LoadSession(session)
	let g:session_name = a:session
	if filereadable(expand("~/.vimstore/sessions/" . a:session . ".vim"))
		exec "source ~/.vimstore/sessions/" . a:session . ".vim"
	endif
endfunction

function! SaveSession()
	silent eval system('mkdir -p ~/.vimstore/sessions/')
	exec "mksession! ~/.vimstore/sessions/" . g:session_name . ".vim"
endfunction

function! SetupSession()
	if exists("v:servername") && v:servername != ""
		cnoreabbrev <expr> q getcmdtype() == ":" && getcmdline() == "q" ? "close" : "q"
		cnoreabbrev <expr> x getcmdtype() == ":" && getcmdline() == "x" ? "w \| close" : "x"
		nnoremap <silent> ZZ :b#\|bw#<CR>

		if !exists("g:session_name") | call LoadSession(v:servername) | endif
	endif
endfunction

augroup session
	au!
	autocmd BufWrite * if exists("g:session_name") | call SaveSession() | endif
	autocmd VimEnter * call SetupSession()
	autocmd User ConfigPost call SetupSession()
augroup END
