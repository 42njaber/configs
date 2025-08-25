
if !exists('g:tabular_loaded')
	packadd tabular
endif

function! ElasTab()
	let line=getline('.')
	if ( col('.') <= 1 || line[col('.') - 2] == '	' )
		return "	"
	else
		return " 	"
	endif
endfunc
inoremap <expr> <Tab> ElasTab()

AddTabularPipeline! elastab / \t/ 
			\ map(a:lines, "substitute(v:val, ' \t', '&:', 'g')")
			\ | tabular#TabularizeStrings(a:lines, ' \t', 'l0')
			\ | map(a:lines, "substitute(v:val, ' \t:', ' \t', 'g')")

nnoremap 	<leader><TAB> 	<Cmd>Tabularize elastab<CR>
vnoremap 	<TAB>         	:Tabularize elastab<CR>gv

augroup elastab
	au!
	au Syntax * match ColorColumn / \@<=	/
augroup END

" 	f1
" 	f2       	test3
" 	f3testez 		test4
" 	f3       	test5

" 	abcdefg 	f2    	test3
" 	abcdefg 	f3tes 	test4
" 	abcdefg 	f3    	test5
