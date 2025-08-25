
if v:vim_did_enter
	finish
endif

" Open up to 10 arg files in tabs
augroup vimrc
	au VimEnter * sil tab sall 10
augroup END
