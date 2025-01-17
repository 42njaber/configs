
nnoremap <buffer><silent>	<CR>	:call vsh#run#Run()<CR>
vnoremap <buffer><silent>	<CR>	:call vsh#run#Run()<CR>

nnoremap <buffer>	!		:call vsh#run#TmuxRun()<CR><CR>
vnoremap <buffer>	!		:call vsh#run#TmuxRun()<CR><CR>

set nocindent
setlocal foldcolumn=3
