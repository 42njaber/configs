
" TODO: make it better
command Gitdiff execute 'silent !git diff -R % > /tmp/%:t.patch' | execute 'redraw!' | execute 'diffp /tmp/%:t.patch'
command -complete=file -nargs=1 -bang Rename if (bufnr("<args>") == -1) |
			\ file <args> | w<bang> | call delete(undofile(bufname('#'))) | call delete(bufname('#')) | bw# |
			\ endif

setg magic
setg incsearch
setg noignorecase
setg regexpengine=0

setg wildmenu
setg wildchar=<TAB>
setg wildcharm=<C-n>
setg wildmode=longest:full,list:full
setg wildoptions=fuzzy,pum

nnoremap	<C-j>	:
cnoremap	<C-l>	<C-n>
cnoremap	<C-h>	<C-p>

cnoreabbrev <expr>	del getcmdtype() == ":" && getcmdline() == 'b del' ? 'bw' : 'del'
cnoremap	<C-C>	<C-e><C-u><Backspace>

nnoremap	;					:<C-F>
vnoremap	;					:<C-F>

nnoremap	<LEADER>z			:b <C-n>

augroup vimrc
	au BufWriteCmd :,:w* echoe "Stop typing :w:w !"
augroup END
