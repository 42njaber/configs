
nnoremap <buffer><silent>	<CR>		:call vsh#Run()<CR>
vnoremap <buffer><silent>	<CR>		:call vsh#Run()<CR>

nnoremap <buffer>			!			:call vsh#TmuxRun()<CR><CR>
vnoremap <buffer>			!			:call vsh#TmuxRun()<CR><CR>

nnoremap <buffer><silent>	<leader>e	:call setline('.',vsh#Expand(getline('.')))<CR><CR>
" vnoremap <buffer><silent>	<Tab>		:call setline('.',vsh#Expand(getline('.')))<CR><CR>

nnoremap <buffer>			<leader>d	:let b:vsh_dynamic=1<CR>
nnoremap <buffer>			<leader>D	:let b:vsh_dynamic=1 \| let b:vsh_cwd=1<CR>

call vsh#Load()

setl foldmethod=marker
setl foldmarker=#<,#>
setl nocindent
setl foldcolumn=3
setl buftype=
setl relativenumber

function! s:VshStatus()
	return ' $> %<' .. getline('.')
endfunction

let b:StatusExtra = function('s:VshStatus')
