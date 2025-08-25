
command! Sudo call SudoMode()
function! SudoMode()
	if &modifiable && system("sudo echo 1 || echo 0")
		echo "Sudo!"
		setlocal noreadonly
		setlocal autoread
		augroup sudo
			au!
			au BufReadPost <buffer> set noreadonly
			au BufWriteCmd <buffer> call SudoWrite()
		augroup END
	endif
endfunction

function! SudoWrite()
	if &modified && system("( sudo tee "..expand("%").." >/dev/null && echo 1 ) || echo 0",bufnr())
		setl nomodified
	endif
endfunction

let s:reload_me=1
