
if exists("b:current_syntax")
	finish
endif
let s:keepcpo= &cpo
set cpo&vim

exec "runtime! syntax/" .. fnamemodify(&shell, ":t") .. ".vim"
unlet! b:current_syntax

syn iskeyword clear
" syn match	vimSyntax	"\<sy\%[ntax]\>"	contains=vimCommand skipwhite nextgroup=vimSynType,vimComment,vim9Comment
" syn keyword	vimHighligh	hi[ghlight]skipwhite nextgroup=vimHiBang,@vimHighlightCluster
" syn cluster vshFuncBodyList add=vimHighlight

syntax include syntax/vim.vim
syntax region vshVimCommand oneline keepend matchgroup=Comment contains=@vimFuncBodyList start=/^:/ end=/$/

let b:current_syntax="vsh"
let &cpo = s:keepcpo
unlet s:keepcpo
