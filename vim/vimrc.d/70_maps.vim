let mapleader=' '

cnoremap	<C-C>				<C-u><Backspace>
inoremap	<C-C>				<ESC>
vnoremap	<C-C>				<ESC>
nnoremap	<C-C>				<NOP>

nnoremap	;					:<C-F>
vnoremap	;					:<C-F>

nnoremap	,					/
vnoremap	,					/
vnoremap	<LEADER>			<Esc>
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
" vnoremap	<LEADER>m			mkymj
" vnoremap	<expr> <LEADER>s	'p`k' .. mode() .. '`jp'

" vnoremap	!					:w !bash<CR>

cnoremap <C-k>					<UP>
cnoremap <C-j>					<DOWN>
cnoremap <C-h>					<LEFT>
cnoremap <C-l>					<RIGHT>

function! ShowSynStack()
	let l:stack = synstack(line('.'),col('.'))
	for id in l:stack
		echon "<" . synIDattr(id,"name") . "|" . synIDattr(synIDtrans(id),"name") . "> "
	endfor
	echo
endfunc
nmap <silent>	<F10>			:call ShowSynStack()<CR>

imap <C-t>t ⊤
imap <C-t>f ⊥
imap <C-t>! ¬
imap <C-t>& ∧
imap <C-t>\| ∨
imap <C-t>x ⊕
imap <C-t>> ⇒
imap <C-t>= ⇔
