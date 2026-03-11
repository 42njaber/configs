
" TODO: make it better
command Gitdiff execute 'silent !git diff -R % > /tmp/%:t.patch' | execute 'redraw!' | execute 'diffp /tmp/%:t.patch'
command -complete=file -nargs=1 -bang Rename call <SID>Rename("<bang>", "<args>")

function! s:Rename(bang, name)
	if bufloaded(a:name) == 0
		let old_name = bufname()
		exec "file"..a:bang.." "..a:name
		exec "w"..a:bang
		call delete(undofile(old_name))
		call delete(bufname(old_name))
	else
		echoerr "Buffer already exists!"
	endif
endfunction

setg magic
setg incsearch
setg noignorecase
setg regexpengine=0

setg wildmenu
setg wildcharm=<C-n>
setg wildmode=longest,full
setg wildoptions=fuzzy,pum

nnoremap    	<C-j>            	:
cnoremap    	<TAB>            	<Cmd>let [&wim,&wop]=["full","fuzzy,pum"]<CR><C-n>
cnoremap    	<C-l>            	<Cmd>let [&wim,&wop]=["longest:full:lastused,full","pum"]<CR><C-n>
cnoremap    	<C-h>            	<C-p>

cnoreabbrev 	<expr>           	del getcmdtype() == ":" && getcmdline() == 'b del' ? 'bw' : 'del'
cnoremap    	<C-C>            	<C-e><C-u><Backspace>

nnoremap    	;                	:<C-F>
vnoremap    	;                	:<C-F>

augroup vimrc_80
	au!

	au BufWriteCmd :,:w* echoe "Stop typing :w:w !"
augroup END
