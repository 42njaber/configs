
syn sync fromstart

syn keyword plKeyword true false fail exit call redo repeat
syn keyword plKeyword meta_predicate multifile dynamic det
syn keyword plKeyword module use_module
syn keyword plKeyword current_prolog_flag set_prolog_flag
syn keyword plKeyword trap abolish spy

syn match plAtom   	 /\<[a-z]\w*/                         	 contained
syn match plNumber 	 /\d\+/                               	 contained
syn match plNumber 	 /\d\+\.\d\+/                         	 contained
syn match plNumber 	 /\<0'\(\\\)\?./                      	 contained
syn match plSymbol 	 /[&.><*$:?=#@\/;+-]\+/               	 contained extend
syn match plVar    	 /\<[A-Z_]\w*\>/                       	 contained
syn match plVar    	 /\<_\w*\>/                           	 contained
syn match plModule 	 /\<[a-z]\w*:[[:space:][:ident:]]\@=/ 	 contained

syn region plString start=/"/ skip=/\\\\\|\\"/ end=/"/ contained extend
syn region plQuoted start=/'/ skip=/\\\\\|\\'/ end=/'/ contained extend

syn region plParen start=/(/ end=/)/ contained contains=@plTerm
" syn region plCompound matchgroup=plCompound start=/\<[a-z]\w*(/ end=/)/ contains=@plTerm

syn cluster plTerm add=plSymbol,plVar,plAtom,plNumber
syn cluster plTerm add=plQuoted,plString,plComment,plKeyword,plModule
syn cluster plTerm add=plParen

syn match plDirective /:-\|?-/ contained nextgroup=plBody

syn match plNeck /\<[a-z]\w*\>\(:\w\|(\)\@!/ contained
syn region plNeck matchgroup=plNeck start=/\<[a-z]\w*\>(/ end=/)/ contained contains=@plTerm

syn region plHead start=/[^%[:space:]]/ matchgroup=plClauseOp end=/\(\.\_s\|:-\|=>\|-->\|==>\|::>\)\@=/ contained contains=plNeck,@plTerm nextgroup=plBody
syn region plBody matchgroup=plClauseOp start=/:-\|?-\|=>\|-->\|==>\|::>/ end=/\(\.\_s\)\@=/ contained contains=@plTerm

"syn region plTerm start

syn region plClause keepend start=/[^%[:space:]]/rs=s matchgroup=plClauseOp end=/\.\S\@!/ contains=plHead,plBody

syn region plComment oneline start=/%/ end=/$/ extend
syn region plComment start='/\*' end='\*/' extend

" syn region plHead start=/\S/ matchgroup=plClauseOp end=/:-/ contains=@plTerm nextgroup=plBody

hi plQuoted ctermfg=180

" hi link plCompound 	 Type
hi link plClause     	 Normal
hi link plHead       	 Normal
hi link plBody       	 Normal
hi link plAtom       	 Normal

hi link plModule     	 Identifier
hi link plNeck       	 Constant
hi link plSymbol     	 Define
hi link plString     	 String
hi link plClauseOp   	 Identifier
hi link plVar        	 Statement
hi link plNumber     	 Number
hi link plKeyword    	 String
hi link plComment    	 Comment

" syn region prologClause matchgroup=prologClauseHead start=/^'[^']*'/ matchgroup=Normal end=/\.\s\|\.$/  contains=ALLBUT,prologClause
" 
" syn region prologClause matchgroup=prologClauseHead start=/^'[^']*'/ matchgroup=Normal end=/\.\s\|\.$/  contains=ALLBUT,prologClause
" syn region prologClause matchgroup=prologClauseHead start=/[a-z]\w*/ matchgroup=Normal end=/\.\s\|\.$/  contains=ALLBUT,prologClause
" syn region prologClause matchgroup=prologClauseHead start=/[a-z]\w*:[a-z]\w*/ matchgroup=Normal end=/\.\s\|\.$/  contains=ALLBUT,prologClause
