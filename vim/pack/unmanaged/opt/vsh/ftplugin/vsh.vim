
nnoremap <buffer><silent>   	<CR>      	<Cmd>call vsh#Run()<CR>
vnoremap <buffer><silent>   	<CR>      	<Cmd>call vsh#Run()<CR>

nnoremap <buffer>           	!         	<Cmd>call vsh#TmuxRun()<CR>
vnoremap <buffer>           	!         	<Cmd>call vsh#TmuxRun()<CR>

nnoremap <buffer>           	§         	<Cmd>call vsh#VimBufRun()<CR>
vnoremap <buffer>           	§         	<Cmd>call vsh#VimBufRun()<CR>


nnoremap <buffer><silent>   	<leader>e 	<Cmd>call setline('.',vsh#Expand(getline('.')))<CR>
" vnoremap <buffer><silent> 	<Tab>     	<Cmd>call setline('.',vsh#Expand(getline('.')))<CR>

nnoremap <buffer>			<leader>d	<Cmd>let b:vsh_dynamic=1<CR>
nnoremap <buffer>			<leader>D	<Cmd>let b:vsh_dynamic=1 \| let b:vsh_cwd=1<CR>

call vsh#Load()

setl foldmethod=marker
setl foldmarker=#<,#>
setl nocindent
setl foldcolumn=3
setl buftype=
setl relativenumber
setl comments-=n:>

function! s:VshStatus()
	return ' $> %<' .. getline('.')
endfunction

let b:StatusExtra = function('s:VshStatus')
