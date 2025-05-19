
setg splitbelow
setg splitright

" Go to previous tab on close

augroup vimrc
	let g:tablist = [1, 1]
	au TabLeave * let g:tablist[0] = g:tablist[1]
	au TabLeave * let g:tablist[1] = tabpagenr()
	au TabClosed * exe "normal " . g:tablist[0] . "gt"
augroup END
