
nnoremap <buffer><silent>	<CR>	:call vsh#run#Run()<CR>
vnoremap <buffer><silent>	<CR>	:call vsh#run#Run()<CR>

nnoremap <buffer>	!		:call vsh#run#TmuxRun()<CR><CR>
vnoremap <buffer>	!		:call vsh#run#TmuxRun()<CR><CR>

nnoremap <buffer>	<Tab>	:call vsh#run#Expand()<CR><CR>
vnoremap <buffer>	<Tab>	:call vsh#run#Expand()<CR><CR>

nnoremap <buffer>	<leader>d	:let b:vsh_dynamic=1<CR>
nnoremap <buffer>	<leader>D	:let b:vsh_dynamic=1 \| let b:vsh_cwd=1<CR>

call vsh#run#Load()

set nocindent
setlocal foldcolumn=3
