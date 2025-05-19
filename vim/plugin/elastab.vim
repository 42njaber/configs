
let s:reload_me=1

if !exists('g:tabular_loaded')
	packadd tabular
endif

function! ElasTab()
	if ( col('.') == 1 || getline('.')[:col('.') - 2] =~ '^\t*$' )
		return "	"
	else
		return " 	"
	endif
endfunc
inoremap <expr> <Tab> ElasTab()

AddTabularPattern! elastab / \t/l0

nnoremap 	<leader><TAB> 	<Cmd>Tabularize elastab<CR>
vnoremap 	<TAB>         	:Tabularize elastab<CR>gv

" 	f1
" 	f2    	test3
" 	f3tes 	test4
" 	f3    	test5

" 	abcdefg 	f2    	test3
" 	abcdefg 	f3tes 	test4
" 	abcdefg 	f3    	test5
