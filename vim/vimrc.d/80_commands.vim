vim9s

# TODO: make it better
command Gitdiff execute 'silent !git diff -R % > /tmp/%:t.patch' | execute 'redraw!' | execute 'diffp /tmp/%:t.patch'
command -complete=file -nargs=1 -bang Rename if (bufnr("<args>") == -1) |
			\ file <args> | w<bang> | call delete(undofile(bufname('#'))) | call delete(bufname('#')) | bw \# |
			\ endif

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

augroup vimrc
	au BufWriteCmd :,:w* echoe "Stop typing :w:w !"
augroup END
