set background=dark
highlight clear

if version > 580
 hi clear
 if exists("syntax_on")
 syntax reset
 endif
endif

let colors_name = "custom"

" Cterm only for now

" Defaults based on the "slate" colorscheme

hi SpecialKey									ctermfg=236
hi Statement									ctermfg=lightblue
hi NonText										ctermfg=166
hi NonText				cterm=bold				ctermfg=blue
hi Question										ctermfg=green
hi Title				cterm=bold				ctermfg=yellow
hi String										ctermfg=darkcyan
hi Comment										ctermfg=darkgrey
hi Constant										ctermfg=brown
hi Number										ctermfg=brown
hi Special										ctermfg=brown
hi Identifier									ctermfg=red
hi Include										ctermfg=red
hi PreProc										ctermfg=red
hi Operator										ctermfg=Red
hi Define										ctermfg=yellow
hi Type											ctermfg=2
hi Function										ctermfg=brown
hi Structure									ctermfg=green
hi CustomTypes			cterm=NONE				ctermfg=166			ctermbg=NONE
hi GroupChars			cterm=NONE				ctermfg=243			ctermbg=NONE

hi CursorLine			cterm=NONE				ctermfg=NONE		ctermbg=233
hi! def link CustomCursorLine CursorLine
hi ColorColumn									ctermfg=202			ctermbg=235

hi Visual				cterm=NONE				ctermfg=NONE		ctermbg=238

hi Search				cterm=underline			ctermfg=NONE		ctermbg=NONE
hi IncSearch			cterm=NONE				ctermfg=NONE		ctermbg=cyan

hi Folded										ctermfg=grey		ctermbg=darkgrey
hi FoldColumn									ctermfg=4			ctermbg=7

hi StatusLine			cterm=bold,reverse
hi StatusLineNC			cterm=reverse

hi LineNr										ctermfg=3

hi WildMenu										ctermfg=0			ctermbg=3

hi VertSplit			cterm=reverse

hi User1				cterm=bold				ctermfg=darkred		ctermbg=white
hi User2										ctermfg=white		ctermbg=232

hi ErrorMsg				cterm=bold				ctermfg=7			ctermbg=1
hi WarningMsg									ctermfg=1
hi ModeMsg				cterm=none				ctermfg=brown
hi MoreMsg										ctermfg=darkgreen
hi VisualNOS			cterm=bold,underline

hi Ignore				cterm=bold				ctermfg=7
hi Directory									ctermfg=darkcyan

hi DiffAdd															ctermbg=022
hi DiffDelete														ctermbg=052
hi DiffChange														ctermbg=018
hi DiffText															ctermbg=130

hi Underlined			cterm=underline			ctermfg=5

hi Error				cterm=bold				ctermfg=7			ctermbg=1
hi SpellErrors			cterm=bold				ctermfg=7			ctermbg=1

" Make colorscheme

hi makeTarget			cterm=bold				ctermfg=12
hi makeIdent			cterm=bold				ctermfg=yellow
hi makeIdentAssign		cterm=NONE				ctermfg=yellow
hi makeStatement		cterm=bold				ctermfg=red
hi makeRulePattern								ctermfg=green

" TpT2 colorscheme

hi tpt2Local			cterm=NONE				ctermfg=lightblue
hi tpt2Global			cterm=NONE				ctermfg=5
hi tpt2Label			cterm=reverse			ctermfg=lightblue	ctermbg=black
hi tpt2Double			cterm=NONE				ctermfg=brown
hi tpt2Int				cterm=NONE				ctermfg=yellow
hi tpt2String			cterm=NONE				ctermfg=darkgreen
hi tpt2FlowFunction		cterm=reverse			ctermfg=brown		ctermbg=black
" hi! def link tpt2String String

hi! def link tpt2Todo			Todo
hi! def link tpt2Comment		Comment

hi! def link tpt2LocalVariable	tpt2Local
hi! def link tpt2GlobalVariable	tpt2Global
hi! def link tpt2LocalPrefix	tpt2Local
hi! def link tpt2GlobalPrefix	tpt2Global

hi! def link tpt2StringType		tpt2String
hi! def link tpt2DoubleType		tpt2Double
hi! def link tpt2IntType		tpt2Int
hi! def link tpt2StringPrefix	tpt2StringType
hi! def link tpt2DoublePrefix	tpt2DoubleType
hi! def link tpt2IntPrefix		tpt2IntType
hi! def link tpt2StringFunction	tpt2String
hi! def link tpt2DoubleFunction	tpt2Double
hi! def link tpt2IntFunction	tpt2Int

hi! def link tpt2Impulse		PreCondit

