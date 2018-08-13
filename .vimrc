
set all&

set belloff=all
set fileencodings=ucs-bom,utf-8,default,latin1
set ttyfast
set nohidden

set nu
set laststatus=2
set showcmd
set showmode

set cindent
set shiftwidth=4
set tabstop=4
set noexpandtab

set wrap
set linebreak
set backspace=indent,eol,start
set scrolloff=10
set formatoptions=tcroqv1jwa

set list
set lcs=tab:>-,space:.
hi SpecialKey ctermfg=239

nnoremap <F2> :set invpaste paste?<CR>
imap <F2> <C-O>:set invpaste paste?<CR>
set pastetoggle=<F2>

imap <SPACE><TAB>	<ESC>

map Q				A

map <C-h>			:nohls<CR>

map <SPACE><LEFT>	:tabprevious<CR>
map <SPACE><RIGHT>	:tabnext<CR>
map <UP>			<C-w>k
map <DOWN>			<C-w>j
map <LEFT>			<C-w>h
map <RIGHT>			<C-w>l

map ZZ				<Nop>

map <C-\>			:source ~/.vimrc<CR>

set textwidth=300
filetype off
syntax on
filetype plugin indent on
