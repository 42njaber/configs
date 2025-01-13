"
" TODO
" - Better session management, put temp files in ./.vim
" - Better vsh
"

if has("nvim")
	set runtimepath^=~/.vim runtimepath+=~/.vim/after
	let &packpath=&runtimepath
else
	set nocompatible
endif

set langmenu=en_US.UTF-8
language message C

function! ReloadSyntax()
	let l:buf=bufnr('%')
	syntax on \| syntax sync fromstart
	exec 'b' l:buf
endfunc
call ReloadSyntax()

colorscheme custom
set synmaxcol=400

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
set viewdir=~/.vimstore/view
set viminfofile=~/.vimstore/info/.viminfo
set viminfo=\"10,'100,<50,s2,h

" Indent/Syntax
set cindent
set shiftwidth=4
set tabstop=4
set noexpandtab
set list
set lcs=tab:>-,space:_
set conceallevel=2

" Format
set textwidth&
set nowrap
set breakindent
set showbreak=>---
set linebreak
set backspace=indent,eol,start
set scrolloff=5
set formatoptions=tcrqv1j

" Regex
set magic
set hlsearch
set incsearch
set noignorecase
set regexpengine=0

" Timeouts
" set timeoutlen=500
set notimeout
set ttimeout
set ttimeoutlen=500

" History
set history=200
set undolevels=1000

" Undo
set undofile
set undodir=~/.vimstore/undo

" 

" Where to find includes

if isdirectory('inc/')
	set path+=inc/
endif

" Norme
set efm&
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
set wildmode=longest:full,list,full

set omnifunc=syntaxcomplete#Complete
set completeopt=menu,menuone,longest

" Paste
nnoremap <F2> :set invpaste paste?<CR>
" imap <F2> <C-O>:set invpaste paste?<CR>
set pastetoggle=<F2>

" Fold
set foldmethod=manual
set foldnestmax=3
set foldcolumn=0
"set nofoldenable

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
set more
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
"set title

set statusline=
set statusline+=\ %1*%{&readonly?'[Read-Only]':&modifiable?'':'[Unmodifiable]'}%0*
set statusline+=%f
set statusline+=%5(%2*%-3.3{&modified?'\ +\ ':''}%0*%)
set statusline+=%=
set statusline+=%10.10(ft=%{&ft}%)
set statusline+=\ \ L%l/%L(%p%%)

" Open up to 10 arg files in tabs
au VimEnter * set tabpagemax=10|sil tab ball|set tabpagemax&vim

" Go to previous tab on close
augroup tabing
	au!
	let g:tablist = [1, 1]
	au TabLeave * let g:tablist[0] = g:tablist[1]
	au TabLeave * let g:tablist[1] = tabpagenr()
	au TabClosed * exe "normal " . g:tablist[0] . "gt"
augroup END

"
" Templates
"

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

set term&
if !has('gui') && (&term =~ "^screen" || &term =~ "^tmux")
	set term=tmux-256color
	set <xUp>=[1;*A
	set <xDown>=[1;*B
	set <xRight>=[1;*C
	set <xLeft>=[1;*D
	set <PasteStart>=[200~
	set <PasteEnd>=[201~
endif

augroup smartpaste
	au!
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
inoremap	<F1>				<NOP>
nnoremap	<F1>				<NOP>
nnoremap	/					:30messages<CR>
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

nnoremap	<LEADER>t			:silent set list!<CR>
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

imap <C-t>t ⊤
imap <C-t>f ⊥
imap <C-t>! ¬
imap <C-t>& ∧
imap <C-t>\| ∨
imap <C-t>x ⊕
imap <C-t>> ⇒
imap <C-t>= ⇔

" cnoreabbrev <expr> t getcmdtype() == ":" && getcmdline() == 't' ? 'tabnew' : 't'

" Configs
if has("nvim")
	map			<LEADER>R			:source ~/.config/nvim/init.vim<CR>
else
	map			<LEADER>R			:source ~/.vimrc<CR>
	map			<LEADER>r			:tabnew ~/.vimrc<CR>
	map			<LEADER>f			:exec "tabnew ~/.vim/ftplugin/"..&ft..".vim"<CR>
	map			<LEADER>s			:exec "tabnew ~/.vim/after/syntax/"..&ft..".vim"<CR>
	map			<LEADER>i			:exec "tabnew ~/.vim/indent/"..&ft..".vim"<CR>
endif

command Suw silent exec "w !sudo tee % >/dev/null" | e!
command Sudo call SudoMode()
function! SudoMode()
	if &modifiable && ! filewritable(expand("%")) && system("sudo echo 1 || echo 0")
		cnoreabbrev <buffer> <expr> w getcmdtype() == ":" && getcmdline() == 'w' ? 'Suw' : 'w'
		setlocal noreadonly
		setlocal autoread
		augroup sudo
			au!
			au BufReadPost <buffer> set noreadonly
		augroup END
	endif
endfunction

set sessionoptions=curdir,folds,options,buffers,tabpages,help,winpos,winsize
function! LoadSession(session)
	let g:session_name = a:session
	if filereadable(expand("~/.vimstore/sessions/" . a:session . ".vim"))
		exec "source ~/.vimstore/sessions/" . a:session . ".vim"
	endif
endfunction

function! SaveSession()
	exec "mksession! ~/.vimstore/sessions/" . g:session_name . ".vim"
endfunction

augroup session
	autocmd!
	autocmd BufWrite * if exists("g:session_name") | call SaveSession() | endif
augroup END

function! SetupServer()
	if exists("v:servername") && v:servername != ""
		cnoreabbrev <expr> q getcmdtype() == ":" && getcmdline() == "q" ? "close" : "q"
		cnoreabbrev <expr> x getcmdtype() == ":" && getcmdline() == "x" ? "w \| close" : "x"
		nnoremap <silent> ZZ :b#\|bw#<CR>

		if !exists("g:session_name") | call LoadSession(v:servername) | endif
	endif
endfunction

autocmd SourcePost,VimEnter * call SetupServer()

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

do BufRead
