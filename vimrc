
if !has("nvim")
	set nocompatible
else
	set runtimepath^=~/.vim runtimepath+=~/.vim/after
	let &packpath = &runtimepath
endif

set langmenu=en_US.UTF-8
language message C

colorscheme custom
syntax on
syntax sync fromstart

" Plugins
call pathogen#infect()
call pathogen#helptags()

" Misc
set belloff=all
set fileencodings=ucs-bom,utf-8,default,latin1
set ttyfast
set hidden
set lazyredraw
set autoread
set mouse =
if !has("nvim")
	set ttymouse =
endif
let g:tex_flavor='latex'
let g:hdr42mail='njaber@student.42.fr'
let g:hdr42user='njaber'

" No backup
set bdir=.,/home/neyl/.vimstore/backup
set nobackup
set nowritebackup
set noswapfile

" Sessions
set sessionoptions=curdir,folds,globals,help,localoptions,options,resize,tabpages,winpos,winsize
set viewdir=~/.vimstore/view
set viminfofile=~/.vimstore/info/.viminfo
set viminfo=\"10,'100,<50,s2,h

" Indent/Syntax
set cindent
set shiftwidth=4
set softtabstop=4
set tabstop=4
set noexpandtab
set list
set lcs=tab:>-,space:_
set conceallevel=2
call matchadd('SpecialKey', '\s', 100) " To prevent CursorLine override
aug SpecialKey
	au! BufEnter,BufCreate,BufNewFile * call matchadd('SpecialKey', '\s', 100)
aug END

" Format
set textwidth=300
set nowrap
set breakindent
set showbreak=>---
set linebreak
set backspace=indent,eol,start
set scrolloff=10
set formatoptions=tcrqv1j

" Regex
set magic
set hlsearch
set incsearch
set noignorecase
set regexpengine=0

" Timeouts
" set timeoutlen=500
" set ttimeoutlen=100
set notimeout
set nottimeout

" History
set history=200
set undolevels=100

" Undo
set undofile
set undodir=~/.vimstore/undo

" 

" Where to find includes

if isdirectory('inc/')
	set path+=inc/
endif

" Norme
set efm+=%+PNorme:\ %f,%WWarning:\ %m,%EError:\ %m,%EError\ (line\ %l):\ %m,%EError\ (line\ %l\\,\ col\ %v):\ %m

" Error format ignore notes and warnings
set efm^=%-G%f:%l:%c\ warning:\ %m,%-G%f:%l:%c\ note:\ %m

" Cscope
if has('cscope')
	set cscopequickfix=s-,c-,d-,i-,t-,e-,a-
	set cst
	set nocsverb
	if filereadable('cscope.out')
		cscope add cscope.out
	endif
	set csverb
endif

"
" Commands
"

" Diff
if !has("nvim")
	set diffopt=vertical,hiddenoff,filler
endif
command! Gitdiff execute 'silent !git diff -R % > /tmp/%:t.patch' | execute 'redraw!' | execute 'diffp /tmp/%:t.patch'

" Completion
set wildmenu
set wildchar=<TAB>
set wildmode=longest:full

set omnifunc=syntaxcomplete#Complete
set completeopt=menu,menuone,longest

" Paste
nnoremap <F2> :set invpaste paste?<CR>
imap <F2> <C-O>:set invpaste paste?<CR>
set pastetoggle=<F2>

" Fold
set foldmethod=manual
set foldnestmax=3
set nofoldenable

" Modelines
set modeline
set modelines=5

" Netrw

let g:netrw_preview   = 2
let g:netrw_alto      = 0
let g:netrw_liststyle = 3

"
" Visual
"

" Info
set laststatus=2
set showcmd
set showmode
set ruler
set report=2

" Numbers
set number
set numberwidth=4
set relativenumber

" if has('timer')
" 	function! SwitchNu(m)
" 		if (&modifiable && a:m == 'i')
" 			set relativenumber
" 		else
" 			set norelativenumber
" 		endif
" 	endfunction
" 	function! DetectModeSwitch(id)
" 		let b:mode = mode()
" 		call SwitchNu(b:mode)
" 	endfunction
" 	aug mode_switch
" 		au! BufCreate,BufNewFile * call timer_start(100, function('DetectModeSwitch'), {'repeat' : -1})
" 	aug END
" endif

" Visual cues
set cursorline

" Not working D:
" function! UpdateCursorLine()
" 	if exists(b:prev_line)
" 		call matchdelete(b:prev_line)
" 	endif
" 	let b:prev_line = matchaddpos("CustomCursorLine", [getpos(".")[1]], 1)
" endfunction

" Windows
set splitbelow
set splitright
set title

set statusline=
set statusline+=\ %1*%{&readonly?'[Read-Only]':&modifiable?'':'[Unmodifiable]'}%0*
set statusline+=%f
set statusline+=%5(%2*%-3.3{&modified?'\ +\ ':''}%0*%)
set statusline+=%=
set statusline+=%10.10(ft=%{&ft}%)
set statusline+=\ \ L%l/%L(%p%%)

"
" Templates
"

if has("autocmd")
	augroup templates
		au!
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
endif

"
" Shortcuts
"

mapclear
imapclear
vmapclear
nmapclear
cmapclear
let mapleader=' '

nnoremap	<LEADER>			<NOP>
nnoremap	<LEADER><LEADER>	<NOP>

cnoremap	<C-C>				<ESC>
inoremap	<C-C>				<ESC>
vnoremap	<C-C>				<ESC>

if has('mac')
	vnoremap	<LEADER>y		:w !pbcopy<CR>
	nnoremap	<LEADER>y		m*ggVG:w !pbcopy<CR>'*
elseif has('unix')
	nnoremap	<LEADER>y		mmggVG:w !wl-copy<CR>'m
	vnoremap	<LEADER>y		""y:call system('wl-copy', getreg('"'))<CR>
endif

nnoremap	<LEADER>t			:silent set list!<CR>
nnoremap	<LEADER>g			:silent nohls<CR>
nohls

nnoremap	<LEADER>z			:silent set list!<CR>
nnoremap	<LEADER><LEFT>		:tabprevious<CR>
nnoremap	<LEADER><RIGHT>		:tabnext<CR>
nnoremap	<LEADER>h			:tabprevious<CR>
nnoremap	<LEADER>l			:tabnext<CR>
nnoremap	<LEADER>H			:tabm -1<CR>
nnoremap	<LEADER>L			:tabm +1<CR>
nnoremap	<LEADER>n			:silent tabnew .<CR>

nnoremap	<LEADER>&			1gt<CR>
nnoremap	<LEADER>é			2gt<CR>
nnoremap	<LEADER>"			3gt<CR>
nnoremap	<LEADER>'			4gt<CR>
nnoremap	<LEADER>(			5gt<CR>
nnoremap	<LEADER>-			6gt<CR>
nnoremap	<LEADER>è			7gt<CR>
nnoremap	<LEADER>_			8gt<CR>
nnoremap	<LEADER>ç			9gt<CR>
nnoremap	<LEADER>à			10gt<CR>

nnoremap	<LEADER>1			:tabm 1<CR>
nnoremap	<LEADER>2			:tabm 2<CR>
nnoremap	<LEADER>3			:tabm 3<CR>
nnoremap	<LEADER>4			:tabm 4<CR>
nnoremap	<LEADER>5			:tabm 5<CR>
nnoremap	<LEADER>6			:tabm 6<CR>
nnoremap	<LEADER>7			:tabm 7<CR>
nnoremap	<LEADER>8			:tabm 8<CR>
nnoremap	<LEADER>9			:tabm 9<CR>
nnoremap	<LEADER>0			:tabm 10<CR>

" nnoremap	<LEADER>(			:cprevious<CR>
" nnoremap	<LEADER>)			:cnext<CR>

nnoremap	<UP>				<C-w>k
nnoremap	<DOWN>				<C-w>j
nnoremap	<LEFT>				<C-w>h
nnoremap	<RIGHT>				<C-w>l

noremap		H					0
noremap		L					$
noremap		j					gj
noremap		k					gk

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

nnoremap <LEADER><TAB>			:set et<CR>:.retab<CR>hv0r :set noet<CR>:.retab!<CR>w

cnoreabbrev <expr> t getcmdtype() == ":" && getcmdline() == 't' ? 'tabnew' : 't'

" Configs
map			<LEADER>r			:tabnew ~/.vimrc<CR>
if has("nvim")
	map			<LEADER>R			:source ~/.config/nvim/init.vim<CR>
else
	map			<LEADER>R			:source ~/.vimrc<CR>
endif

" "
"
"

if filereadable(expand("~/configs/.mod.vim"))
	source ~/configs/.mod.vim
endif

" Reload ftplugins
filetype plugin indent off
filetype detect
filetype plugin indent on

if (&ft == "tpt2")
	set noautoindent
	set nocindent
endif
