
set all&
set nocompatible

source ~/configs/.vim/plugins/42header.vim

set langmenu=en_US.UTF-8
language message C

colorscheme slate
syntax on
syntax sync fromstart

" Misc
set belloff=all
set fileencodings=ucs-bom,utf-8,default,latin1
set ttyfast
set hidden
set lazyredraw
set autoread

" No backup
set nobackup
set nowritebackup
set noswapfile

" Indent/Syntax
set cindent
set shiftwidth=4
set tabstop=4
set noexpandtab
set list
set lcs=tab:>-,space:.
call matchadd('SpecialKey', '\s') " To prevent CursorLine override
aug SpecialKey
	au! BufEnter,BufCreate,BufNewFile * call matchadd('SpecialKey', '\s')
aug END

" Format
set textwidth=300
set wrap
set linebreak
set backspace=indent,eol,start
set scrolloff=10
set formatoptions=tcrqv1j

" Regex
set magic
set hlsearch
set incsearch
set ignorecase smartcase

" Timeouts
set timeoutlen=500
set ttimeoutlen=100

" History
set history=200
set undolevels=500

" Norme
set efm+=%+PNorme:\ %f,%WWarning:\ %m,%EError:\ %m,%EError\ (line\ %l):\ %m,%EError\ (line\ %l\\,\ col\ %v):\ %m

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
set diffopt=vertical,hiddenoff,filler
command! Gitdiff execute 'silent !git diff -R % > /tmp/%:t.patch' | execute 'redraw!' | execute 'diffp /tmp/%:t.patch'

" Completion
set wildmenu
set wildchar=<TAB>
set wildmode=longest:full

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
if has('timer')
	function! SwitchNu(m)
		if (&modifiable && a:m == 'i')
			set relativenumber
		else
			set norelativenumber
		endif
	endfunction
	function! DetectModeSwitch(id)
		let b:mode = mode()
		call SwitchNu(b:mode)
	endfunction
	aug mode_switch
		au! BufCreate,BufNewFile * call timer_start(100, function('DetectModeSwitch'), {'repeat' : -1})
	aug END
endif

" Visual cues
set showmatch
set cursorline

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
" Shortcuts
"

mapclear
let mapleader=' '

inoremap	<LEADER><TAB>	<ESC>
vnoremap	<LEADER><TAB>	<ESC>
nmap		Q				A
nnoremap	,				:
if has('mac')
	vnoremap	<LEADER>c		:w !pbcopy<CR>
	nnoremap	<LEADER>C		mmggVG:w !pbcopy<CR>'m
elseif has('unix')
	vnoremap	<LEADER>c		:w !xclip -sel clip<CR><CR>
	nnoremap	<LEADER>C		mmggVG:w !xclip -sel clip<CR><CR>'m
endif

nnoremap	<LEADER>t		:silent set list!<CR>
nnoremap	<LEADER>g		:silent nohls<CR>

nnoremap	<LEADER>(		:cprevious<CR>
nnoremap	<LEADER>)		:cnext<CR>

nnoremap	<LEADER><LEFT>	:tabprevious<CR>
nnoremap	<LEADER><RIGHT>	:tabnext<CR>
nnoremap	<LEADER>l		:tabprevious<CR>
nnoremap	<LEADER>h		:tabnext<CR>
nnoremap	<LEADER>n		:silent tabnew .<CR>
nnoremap	<LEADER>[		:cprevious<CR>
nnoremap	<LEADER>]		:cnext<CR>
nnoremap	<LEADER>w		:w<CR>
nnoremap	<UP>			<C-w>k
nnoremap	<DOWN>			<C-w>j
nnoremap	<LEFT>			<C-w>h
nnoremap	<RIGHT>			<C-w>l

noremap		j				gj
noremap		k				gk

nnoremap	<C-e>			3<C-e>
nnoremap	<C-y>			3<C-y>

map			ZZ				<Nop>

" Reload configs
map			<LEADER>R			:source ~/.vimrc<CR>

"
"
"
"

if filereadable(expand("~/configs/.mod.vim"))
	source ~/configs/.mod.vim
endif


" Status line
hi User1 ctermfg=darkred ctermbg=white cterm=bold
hi User2 ctermfg=white ctermbg=232

hi CursorLine cterm=NONE ctermbg=233 ctermfg=NONE
hi Visual cterm=NONE ctermbg=238 ctermfg=NONE

hi SpecialKey ctermfg=236
hi CustomTypes cterm=NONE ctermbg=NONE ctermfg=166
hi GroupChars cterm=NONE ctermbg=NONE ctermfg=243

hi Search cterm=NONE ctermfg=black ctermbg=grey
hi IncSearch cterm=NONE ctermfg=black ctermbg=cyan

hi DiffAdd cterm=NONE ctermbg=022
hi DiffDelete cterm=NONE ctermbg=052
hi DiffChange cterm=NONE ctermbg=018
hi DiffText cterm=NONE ctermbg=130

hi ColorColumn ctermfg=202 ctermbg=235

" Reload ftplugins
set filetype&
filetype on
filetype off
filetype detect
filetype plugin indent on
