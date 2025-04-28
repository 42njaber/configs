
nnoremap <buffer><silent>	<CR>		:call vsh#Run()<CR>
vnoremap <buffer><silent>	<CR>		:call vsh#Run()<CR>

nnoremap <buffer>			!			:call vsh#TmuxRun()<CR><CR>
vnoremap <buffer>			!			:call vsh#TmuxRun()<CR><CR>

nnoremap <buffer><silent>	<C-x>		:call setline('.',vsh#Expand(getline('.')))<CR><CR>
" vnoremap <buffer><silent>	<Tab>		:call setline('.',vsh#Expand(getline('.')))<CR><CR>

nnoremap <buffer>			<leader>d	:let b:vsh_dynamic=1<CR>
nnoremap <buffer>			<leader>D	:let b:vsh_dynamic=1 \| let b:vsh_cwd=1<CR>

call vsh#Load()

setl foldmethod=expr
setl foldexpr=vsh#FoldLevel(v:lnum)
setl nocindent
setl foldcolumn=3
setl buftype=
setl relativenumber

setl statusline=%#StatusLineTerm#
setl statusline+=\ %1*%{&readonly?'[Read-Only]':&modifiable?'':'[Unmodifiable]'}%#StatusLineTerm#
setl statusline+=\ [VSH:%f]
setl statusline+=\ %{getcwd()}\ $>
setl statusline+=%5(%2*%-3.3{&modified?'\ +\ ':''}%#StatusLineTerm#%)
setl statusline+=%=
setl statusline+=\ \ L%l/%L(%p%%)
