
silent eval system('mkdir -p ~/.vimstore/sessions/')
let s:reload_me=1

set t_te& t_ti&
if !has('gui') && (&term =~ "^screen" || &term =~ "^tmux")
	if &term != "tmux-256color"
		set term=tmux-256color
	endif
	set <xUp>=[1;*A
	set <xDown>=[1;*B
	set <xRight>=[1;*C
	set <xLeft>=[1;*D
	set <PasteStart>=[200~
	set <PasteEnd>=[201~
endif
set sessionoptions=curdir,globals,buffers,tabpages,help,winpos,winsize

function! LoadSession(session)
	let g:session_name = a:session
	let g:SessionFrozen = 0
	echom "Loading session: "..a:session
	if filereadable(expand("~/.vimstore/sessions/" . a:session . ".vim"))
		exec "source ~/.vimstore/sessions/" . a:session . ".vim"
	endif
	autocmd BufWrite * if !g:SessionFrozen | call SaveSession() | endif
endfunction

function! FreezeSession()
	let g:SessionFrozen = 1
	call SaveSession()
endfunction

function! UnfreezeSession()
	unlet g:SessionFrozen = 0
	call SaveSession()
endfunction

function! SaveSession()
	if exists("g:session_name")
		exec "mksession! ~/.vimstore/sessions/" . g:session_name . ".vim"
	endif
endfunction

function! SetupSession()
	if exists("v:servername") && v:servername != ""
		cnoreabbrev <expr> q getcmdtype() == ":" && getcmdline() == "q" ? "close" : "q"
		cnoreabbrev <expr> x getcmdtype() == ":" && getcmdline() == "x" ? "w \| close" : "x"
		nnoremap <silent> ZZ :b#\|bw#<CR>

		if !exists("g:session_name") | call LoadSession(v:servername) | endif
	endif
endfunction

augroup tmux-session
	au!
	autocmd VimEnter * ++once ++nested call SetupSession()
	autocmd SessionLoadPost * ++nested doauto BufRead
augroup END
