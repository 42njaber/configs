
setg mouse=
setg ttymouse=
setg virtualedit=onemore,block

setg timeout&
setg ttimeout
setg ttimeoutlen=500

setg omnifunc=syntaxcomplete#Complete
setg completeopt=menu,menuone,longest

let mapleader=' '

inoremap	 <C-C>	 <ESC>
vnoremap	 <C-C>	 <ESC>
nnoremap	 <C-C>	 <NOP>

nnoremap	 ,	    /
vnoremap	 ,	    /
inoremap	 <F1>	 <NOP>
nnoremap	 <F1>	 <NOP>
nnoremap	 /	    :30messages<CR>
nnoremap	 Q	    <NOP>

nnoremap	 +	  g+
nnoremap	 -	  g-
nmap	     gf	 :e <cfile><CR>

nnoremap    <LEADER>            <NOP>
nnoremap    <LEADER><LEADER>    <NOP>

nnoremap    <LEADER>y           mmggVG:w !wl-copy<CR>'m
vnoremap    <LEADER>y           ""y:call system('wl-copy', getreg('"'))<CR>

nnoremap    <LEADER>t           :silent setl list!<CR>
nnoremap    <LEADER>g           :silent nohls<CR>
nohls

nnoremap    <LEADER>h           :tabprev<CR>
nnoremap    <LEADER>l           :tabnext<CR>
nnoremap    <LEADER>H           :tabm -1<CR>
nnoremap    <LEADER>L           :tabm +1<CR>

nnoremap    (                   <C-[>
nnoremap    )                   <C-]>

noremap     H                    0
noremap     L                    $
noremap     j                    gj
noremap     k                    gk

nnoremap    <A-h>                <C-w>h
nnoremap    <A-j>                <C-w>j
nnoremap    <A-k>                <C-w>k
nnoremap    <A-l>                <C-w>l

nnoremap    <Esc>h               <C-w>h
nnoremap    <Esc>j               <C-w>j
nnoremap    <Esc>k               <C-w>k
nnoremap    <Esc>l               <C-w>l

nnoremap    <C-e>                3<C-e>
nnoremap    <C-y>                3<C-y>

" Swap position of 2 selections
"  select first block, <LEADER>m, select second block, <LEADER>s
"  if both selections are on the same line, make sure
"  to select to select the earlier one first
" vnoremap    <LEADER>m            mkymj
" vnoremap    <expr> <LEADER>s    'p`k' .. mode() .. '`jp'

" vnoremap    !                    :w !bash<CR>

inoremap    <C-l>                <C-k>
digraphs ?! 172
digraphs ?T 8868
digraphs ?F 8869
digraphs ?A 8743
digraphs ?O 8744
digraphs ?X 8853

nmap <silent>    <F10>            :call ShowSynStack()<CR>
function! ShowSynStack()
	let l:stack = synstack(line('.'),col('.'))
	for id in l:stack
		echon "<" . synIDattr(id,"name") . "|" . synIDattr(synIDtrans(id),"name") . "> "
	endfor
	echo
endfunc

setg pastetoggle=<F2>
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
