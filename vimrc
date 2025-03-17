"
" TODO
" - Fold management in vsh
" - Better ranger interation?
"

if has("nvim")
	setg runtimepath^=~/.vim runtimepath+=~/.vim/after
	let &packpath=&runtimepath
else
	setg nocompatible
endif

augroup vimrc
	au! vimrc
	au User ConfigReloadPre eval 0
	au User ConfigPost eval 0
	au User ReloadFull eval 0
augroup END

if exists("g:configload")
	do User ConfigReloadPre
endif
let g:configload=1

setg langmenu=en_US.UTF-8
language message C

function! ReloadSyntax()
	let l:buf=bufnr('%')
	syntax on \| syntax sync fromstart
	exec 'b' l:buf
endfunc
call ReloadSyntax()

colorscheme custom
setg synmaxcol=400

" Plugins
call pathogen#infect()
call pathogen#helptags()

" Misc
setg virtualedit=onemore,block
setg belloff=all
setg fileencodings=ucs-bom,utf-8,default,latin1
setg ttyfast
setg hidden
setg lazyredraw
setg autoread
setg mouse =
setg ttymouse =

let g:tex_flavor='latex'
let g:hdr42mail='njaber@student.42.fr'
let g:hdr42user='njaber'

" No backup
set bdir=.,/home/neyl/.vimstore/backup
set nobackup
set nowritebackup
set noswapfile

" Indent/Syntax
setg cindent
setg shiftwidth=4
setg tabstop=4
setg noexpandtab
setg list
setg lcs=tab:>-,space:_
setg conceallevel=2

" Format
setg textwidth=0
setg wrap
setg breakindent
setg showbreak=>---
setg linebreak
setg backspace=indent,eol,start
setg scrolloff=5
setg formatoptions=clrqv1j

" Regex
setg magic
setg hlsearch
setg incsearch
setg noignorecase
setg regexpengine=0

" Timeouts
" setg timeoutlen=500
setg notimeout
setg ttimeout
setg ttimeoutlen=500

" History
setg history=200
setg undolevels=1000

" Undo
setg undofile
setg undodir=~/.vimstore/undo

" 

" Where to find includes

if isdirectory('inc/')
	setg path+=inc/
endif

" Norme
setg efm&
setg efm+=%+PNorme:\ %f,%WWarning:\ %m,%EError:\ %m,%EError\ (line\ %l):\ %m,%EError\ (line\ %l\\,\ col\ %v):\ %m

" Error format ignore notes and warnings
setg efm^=%-G%f:%l:%c\ warning:\ %m,%-G%f:%l:%c\ note:\ %m

" Cscope
if has('cscope')
	setg cscopequickfix=s-,c-,d-,i-,t-,e-,a-
	setg cst
	setg nocsverb
	if filereadable('cscope.out')
		cscope add cscope.out
	endif
	setg csverb
endif

"
" Commands
"

" Diff
setg diffopt=vertical,hiddenoff,filler
command! Gitdiff execute 'silent !git diff -R % > /tmp/%:t.patch' | execute 'redraw!' | execute 'diffp /tmp/%:t.patch'

" Completion
setg wildmenu
setg wildchar=<TAB>
setg wildmode=longest:full,list,full

setg omnifunc=syntaxcomplete#Complete
setg completeopt=menu,menuone,longest

" Paste
nnoremap <F2> :setg invpaste paste?<CR>
" imap <F2> <C-O>:setg invpaste paste?<CR>
setg pastetoggle=<F2>

" Fold
setg foldmethod=manual
setg foldnestmax=3
setg foldcolumn=0
"setg nofoldenable

" Modelines
setg modeline
setg modelines=5

" Netrw

let g:netrw_preview   = 2
let g:netrw_alto      = 0
let g:netrw_liststyle = 3

"
" Visual
"

" Info
setg laststatus=2
setg showcmd
setg showmode
setg ruler
setg report=2

" Numbers
setg number
setg numberwidth=4
setg relativenumber

" Visual cues
setg more
setg cursorline

" Windows
setg splitbelow
setg splitright
"setg title

setg statusline=
setg statusline+=\ %1*%{&readonly?'[Read-Only]':&modifiable?'':'[Unmodifiable]'}%0*
setg statusline+=%f
setg statusline+=%5(%2*%-3.3{&modified?'\ +\ ':''}%0*%)
setg statusline+=%=
setg statusline+=%20.20(ft=%{&ft}%)
setg statusline+=\ \ L%l/%L(%p%%)

" Open up to 10 arg files in tabs
augroup vimrc
	au VimEnter * setg tabpagemax=10|sil tab ball|setg tabpagemax&vim
augroup END

" Go to previous tab on close
augroup vimrc
	let g:tablist = [1, 1]
	au TabLeave * let g:tablist[0] = g:tablist[1]
	au TabLeave * let g:tablist[1] = tabpagenr()
	au TabClosed * exe "normal " . g:tablist[0] . "gt"
augroup END

"
" Templates
"

augroup vimrc
	autocmd BufNewFile *.sh 0r ~/.vim/templates/sh/default.sh | normal G
	autocmd BufNewFile *.cpp
				\ if(@% =~ ".*\.class\.cpp") |
				\	0r ~/.vim/templates/cpp/class.cpp | exe 'normal 9G' |
				\ else |
				\	0r ~/.vim/templates/cpp/default.cpp | exe 'normal G' |
				\ endif
	autocmd BufNewFile *.hpp
				\ if(@% =~ ".*\.class\.hpp") |
				\	0r ~/.vim/templates/cpp/class.hpp | exe 'normal 9G' |
				\ else |
				\	0r ~/.vim/templates/cpp/default.hpp | exe 'normal G' |
				\ endif
	autocmd! BufNewFile * %s#\[:VIM_EVAL:\]\(.\{-\}\)\[:END_EVAL:\]#\=eval(submatch(1))#ge|''
augroup END

augroup vimrc
	function! IndentPastedText()
		if !v:option_old && v:option_new
			mark [
		elseif v:option_old && !v:option_new
			let pos = getpos('.')
			normal ='[
			call setpos('.', pos)
		endif
	endfunction
	au OptionSet paste call IndentPastedText()
augroup END

"
" Shortcuts
"

mapclear
imapclear
vmapclear
nmapclear
cmapclear
let mapleader=' '

nnoremap	,					/
vnoremap	,					/
vnoremap	<LEADER>			<Esc>
inoremap	<F1>				<NOP>
nnoremap	<F1>				<NOP>
nnoremap	/					:messages<CR>
nnoremap	Q					<NOP>

nnoremap	+					g+
nnoremap	-					g-
nmap		gf					:e <cfile><CR>

nnoremap	<LEADER>			<NOP>
nnoremap	<LEADER><LEADER>	<NOP>

nnoremap	<LEADER>			<NOP>
nnoremap	<LEADER><LEADER>	<NOP>

cnoremap	<C-C>				<C-u><Backspace>
inoremap	<C-C>				<ESC>
vnoremap	<C-C>				<ESC>

if has('mac')
	vnoremap	<LEADER>y		:w !pbcopy<CR>
	nnoremap	<LEADER>y		m*ggVG:w !pbcopy<CR>'*
elseif has('unix')
	nnoremap	<LEADER>y		mmggVG:w !wl-copy<CR>'m
	vnoremap	<LEADER>y		""y:call system('wl-copy', getreg('"'))<CR>
endif

nnoremap	<LEADER>t			:silent setl list!<CR>
nnoremap	<LEADER>g			:silent nohls<CR>
nohls

nnoremap	<LEADER><LEFT>		:tabprev<CR>
nnoremap	<LEADER><RIGHT>		:tabnext<CR>
nnoremap	<LEADER>h			:tabprev<CR>
nnoremap	<LEADER>l			:tabnext<CR>
nnoremap	<LEADER>H			:tabm -1<CR>
nnoremap	<LEADER>L			:tabm +1<CR>
nnoremap	<LEADER>n			:silent tabnew .<CR>
nnoremap	<LEADER>z			:ls<CR>:b 
cnoreabbrev <expr> del getcmdtype() == ":" && getcmdline() == 'b del' ? 'bw' : 'del'

nnoremap	(					<C-[>
nnoremap	)					<C-]>

noremap		H					0
noremap		L					$
noremap		j					gj
noremap		k					gk

nnoremap	<A-h>				<C-w>h
nnoremap	<A-j>				<C-w>j
nnoremap	<A-k>				<C-w>k
nnoremap	<A-l>				<C-w>l

nnoremap	<Esc>h				<C-w>h
nnoremap	<Esc>j				<C-w>j
nnoremap	<Esc>k				<C-w>k
nnoremap	<Esc>l				<C-w>l

nnoremap	<C-e>				3<C-e>
nnoremap	<C-y>				3<C-y>

" Swap position of 2 selections
"  select first block, <LEADER>m, select second block, <LEADER>s
"  if both selections are on the same line, make sure
"  to select to select the earlier one first
vnoremap	<LEADER>m			mkymj
vnoremap	<expr> <LEADER>s	'p`k' .. mode() .. '`jp'

vnoremap	!					:w !bash<CR>

cnoremap <C-k>					<UP>
cnoremap <C-j>					<DOWN>
cnoremap <C-h>					<LEFT>
cnoremap <C-l>					<RIGHT>

nmap <silent>	<F10>			:echo "hi<" . synIDattr(synID(line("."),col("."),1),"name")
								\ . '> trans<' . synIDattr(synID(line("."),col("."),0),"name")
								\ . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name")
								\ . ">"<CR>

imap <C-t>t ⊤
imap <C-t>f ⊥
imap <C-t>! ¬
imap <C-t>& ∧
imap <C-t>\| ∨
imap <C-t>x ⊕
imap <C-t>> ⇒
imap <C-t>= ⇔

map			<LEADER>R			:source ~/.vimrc \| do User ReloadFull<CR>
map			<LEADER>r			:source ~/.vimrc \| e<CR>
map			<LEADER>f			:exec "tabnew ~/.vim/after/ftplugin/"..&ft..".vim"<CR>
map			<LEADER>s			:exec "tabnew ~/.vim/after/syntax/"..&ft..".vim"<CR>
map			<LEADER>i			:exec "tabnew ~/.vim/after/indent/"..&ft..".vim"<CR>

" Reload ftplugins
filetype plugin indent off
filetype plugin indent on

set t_te& t_ti&
do User ConfigPost

syntax on
