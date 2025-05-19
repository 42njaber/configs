

if v:vim_did_enter
	finish
endif

" Open up to 10 arg files in tabs
augroup vimrc
	au VimEnter * setg tabpagemax=10|sil tab ball|setg tabpagemax&vim
augroup END
