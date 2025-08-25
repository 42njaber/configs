vim9s

if has('nvim')
	finish
endif

silent eval system('mkdir -p ~/.vimstore/sessions/')

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

def LoadSession(session: string)
	g:session_name = session
	g:SessionFrozen = 0
	echom "Loading session: " .. session
	if filereadable(expand("~/.vimstore/sessions/" .. session .. ".vim"))
		exec "source ~/.vimstore/sessions/" .. session .. ".vim"
	endif
	autocmd BufWrite * if !g:SessionFrozen | call SaveSession() | endif
enddef

def FreezeSession()
	g:SessionFrozen = 1
	call SaveSession()
enddef

def UnfreezeSession()
	g:SessionFrozen = 0
	call SaveSession()
enddef

def SaveSession()
	if exists("g:session_name")
		exec "mksession! ~/.vimstore/sessions/" .. g:session_name .. ".vim"
	endif
enddef

def SetupSession()
	if !has("nvim") && exists("v:servername") && v:servername != ""
		&viminfofile = "~/.vimstore/info/" .. v:servername
		cnoreabbrev <expr> q getcmdtype() == ":" && getcmdline() == "q" ? "close" : "q"
		cnoreabbrev <expr> x getcmdtype() == ":" && getcmdline() == "x" ? "w \| close" : "x"
		nnoremap <silent> ZZ <Cmd>b#\|bw#<CR>

		if !exists("g:session_name") | call LoadSession(v:servername) | endif
	endif
enddef

augroup tmux-session
	au!
	autocmd VimEnter * ++once ++nested call SetupSession()
	autocmd User ReloadPost ++once ++nested call SetupSession()
	autocmd SessionLoadPost * ++nested doauto BufRead
augroup END
