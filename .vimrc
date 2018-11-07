
set all&
set nocompatible

set langmenu=en_US.UTF-8
language message C

colorscheme slate
syntax on

" Misc
set belloff=all
set fileencodings=ucs-bom,utf-8,default,latin1
set ttyfast
set nohidden
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
hi SpecialKey ctermfg=236
call matchadd('SpecialKey', '\s') " To prevent CursorLine override

" Format
set textwidth=300
set wrap
set linebreak
set backspace=indent,eol,start
set scrolloff=10
set formatoptions=tcrqv1j

" Regex
set gdefault
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

"
" Commands
"

" Completion
set wildmenu
set wildchar=<TAB>
set wildmode=list:full

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
	au BufCreate,BufNewFile * call timer_start(100, function('DetectModeSwitch'), {'repeat' : -1})
aug END

" Visual cues
set showmatch
set cursorline
hi CursorLine cterm=NONE ctermbg=233
hi Visual cterm=NONE ctermbg=238

" Windows
set splitbelow
set splitright
set title

" Status line
hi User1 ctermfg=darkred ctermbg=white cterm=bold
hi User2 ctermfg=white ctermbg=232

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
nnoremap	<LEADER>h		:silent nohls<CR>

nnoremap	<LEADER>(		:cprevious<CR>
nnoremap	<LEADER>)		:cnext<CR>

nnoremap	<LEADER><LEFT>	:tabprevious<CR>
nnoremap	<LEADER><RIGHT>	:tabnext<CR>
nnoremap	<LEADER>j		:tabprevious<CR>
nnoremap	<LEADER>m		:tabnext<CR>
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

" Reload ftplugins
set filetype&
filetype on
filetype off
filetype detect
filetype plugin indent on
