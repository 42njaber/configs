
nnoremap <buffer><silent>	<CR>	:call vsh#run#Run()<CR>
vnoremap <buffer><silent>	<CR>	:call vsh#run#Run()<CR>

nnoremap <buffer>	!		:call vsh#run#TmuxRun()<CR><CR>
vnoremap <buffer>	!		:call vsh#run#TmuxRun()<CR><CR>

nnoremap <buffer>	<Tab>	:call vsh#run#Expand()<CR><CR>
vnoremap <buffer>	<Tab>	:call vsh#run#Expand()<CR><CR>

call vsh#run#Load()

set nocindent
setlocal foldcolumn=3
