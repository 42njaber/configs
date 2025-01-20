
command! Suw silent exec "w !sudo tee % >/dev/null" | e!
command! Sudo call SudoMode()
function! SudoMode()
	if &modifiable && ! filewritable(expand("%")) && system("sudo echo 1 || echo 0")
		cnoreabbrev <buffer> <expr> w getcmdtype() == ":" && getcmdline() == 'w' ? 'Suw' : 'w'
		setlocal noreadonly
		setlocal autoread
		augroup vimrc
			au BufReadPost <buffer> set noreadonly
		augroup END
	endif
endfunction
