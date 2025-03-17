
mapclear <buffer>

nnoremap <buffer><silent>	<CR>		:call vsh#run#Run()<CR>
vnoremap <buffer><silent>	<CR>		:call vsh#run#Run()<CR>

nnoremap <buffer>			!			:call vsh#run#TmuxRun()<CR><CR>
vnoremap <buffer>			!			:call vsh#run#TmuxRun()<CR><CR>

nnoremap <buffer><silent>	<C-x>		:call setline('.',vsh#run#Expand(getline('.')))<CR><CR>
" vnoremap <buffer><silent>	<Tab>		:call setline('.',vsh#run#Expand(getline('.')))<CR><CR>

nnoremap <buffer>			<leader>d	:let b:vsh_dynamic=1<CR>
nnoremap <buffer>			<leader>D	:let b:vsh_dynamic=1 \| let b:vsh_cwd=1<CR>

call vsh#run#Load()

setlocal foldmethod=expr
setlocal foldexpr=vsh#run#FoldLevel(v:lnum)
setlocal nocindent
setlocal foldcolumn=3
setlocal buftype=
setlocal relativenumber

setlocal statusline=%#StatusLineTerm#
setlocal statusline+=\ %1*%{&readonly?'[Read-Only]':&modifiable?'':'[Unmodifiable]'}%#StatusLineTerm#
setlocal statusline+=\ [VSH:%f]
setlocal statusline+=\ %{getcwd()}\ $>
setlocal statusline+=%5(%2*%-3.3{&modified?'\ +\ ':''}%#StatusLineTerm#%)
setlocal statusline+=%=
setlocal statusline+=\ \ L%l/%L(%p%%)
