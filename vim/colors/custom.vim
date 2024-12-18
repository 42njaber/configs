set background=dark
highlight clear

if version > 580
	hi clear
	if exists("syntax_on")
		syntax reset
	endif
endif

let colors_name = "custom"
set guifont=Monospace\ 13

" Cterm only for now

" Defaults based on the "slate" colorscheme
set t_Co=256

hi Normal				ctermfg=white		ctermbg=black		cterm=None
hi Normal				  guifg=white		  guibg=black		  gui=None

hi SpecialKey			ctermfg=236
hi SpecialKey			  guifg=#303030
hi Statement			ctermfg=69
hi Statement			  guifg=#5f87ff							  gui=None
hi NonText				ctermfg=blue							cterm=bold
hi NonText				  guifg=blue							  gui=None
hi Question				ctermfg=green
hi Question				  guifg=green
hi Title				ctermfg=yellow							cterm=bold
hi Title				  guifg=#808000							  gui=None
hi String				ctermfg=77
hi String				  guifg=#5fd75f
hi Comment				ctermfg=darkgrey
hi Comment				  guifg=darkgrey
hi Constant				ctermfg=130
hi Constant				  guifg=#af5f00
hi Number				ctermfg=130
hi Number				  guifg=#af5f00
hi Special				ctermfg=130
hi Special				  guifg=#af5f00
hi Identifier			ctermfg=red
hi Identifier			  guifg=red
hi Include				ctermfg=red
hi Include				  guifg=red
hi PreProc				ctermfg=red
hi PreProc				  guifg=red
hi Operator				ctermfg=red
hi Operator				  guifg=red
hi Define				ctermfg=yellow
hi Define				  guifg=yellow
hi Type					ctermfg=darkgreen
hi Type					  guifg=darkgreen
hi Function				ctermfg=130
hi Function				  guifg=#af5f00
hi Structure			ctermfg=green
hi Structure			  guifg=green
hi CustomTypes			ctermfg=166			ctermbg=NONE		cterm=NONE
hi CustomTypes			  guifg=NONE		  guibg=NONE		  gui=NONE
hi GroupChars			ctermfg=243			ctermbg=NONE		cterm=NONE
hi GroupChars			  guifg=NONE		  guibg=NONE		  gui=NONE

hi CursorLine			ctermfg=NONE		ctermbg=233			cterm=NONE
hi CursorLine			  guifg=NONE		  guibg=NONE		  gui=NONE
hi! def link CustomCursorLine CursorLine
hi ColorColumn			ctermfg=202			ctermbg=235
hi ColorColumn			  guifg=NONE		  guibg=NONE

hi Visual				ctermfg=NONE		ctermbg=238			cterm=NONE
hi Visual				  guifg=NONE		  guibg=NONE		  gui=NONE
hi VisualNOS			ctermfg=NONE		ctermbg=238			cterm=NONE
hi VisualNOS			  guifg=NONE		  guibg=NONE		  gui=NONE

hi MatchParen			ctermfg=None		ctermbg=235			cterm=NONE
hi MatchParen			  guifg=gray		  guibg=NONE		  gui=NONE

hi Search				ctermfg=NONE		ctermbg=NONE		cterm=underline
hi Search				  guifg=NONE		  guibg=NONE		  gui=underline
hi IncSearch			ctermfg=NONE		ctermbg=cyan		cterm=NONE
hi IncSearch			  guifg=NONE		  guibg=cyan		  gui=NONE

hi Folded				ctermfg=yellow		ctermbg=235
hi Folded				  guifg=yellow		  guibg=darkgrey
hi FoldColumn			ctermfg=lightgray	ctermbg=black
hi FoldColumn			  guifg=lightgray	  guibg=black

hi StatusLine													cterm=bold,reverse
hi StatusLine													  gui=bold,reverse
hi StatusLineNC													cterm=reverse
hi StatusLineNC													  gui=reverse

hi LineNr				ctermfg=yellow
hi LineNr				  guifg=yellow

hi WildMenu				ctermfg=black		ctermbg=yellow
hi WildMenu				  guifg=black		  guibg=yellow

hi VertSplit													cterm=reverse
hi VertSplit													  gui=reverse

hi User1				ctermfg=darkred		ctermbg=white		cterm=bold
hi User1				  guifg=darkred		  guibg=white		  gui=bold
hi User2				ctermfg=white		ctermbg=232
hi User2				  guifg=white		  guibg=NONE

hi ErrorMsg				ctermfg=white		ctermbg=red			cterm=bold
hi ErrorMsg				  guifg=white		  guibg=red			  gui=bold
hi WarningMsg			ctermfg=red
hi WarningMsg			  guifg=red
hi ModeMsg				ctermfg=130								cterm=none
hi ModeMsg				  guifg=#af5f00							  gui=none
hi MoreMsg				ctermfg=darkgreen
hi MoreMsg				  guifg=darkgreen

hi Ignore				ctermfg=white							cterm=bold
hi Ignore				  guifg=white							  gui=bold
hi Directory			ctermfg=darkcyan
hi Directory			  guifg=darkcyan

hi DiffAdd									ctermbg=022
hi DiffAdd									  guibg=NONE
hi DiffDelete								ctermbg=052
hi DiffDelete								  guibg=NONE
hi DiffChange								ctermbg=018
hi DiffChange								  guibg=NONE
hi DiffText									ctermbg=130
hi DiffText									  guibg=NONE

hi Underlined			ctermfg=magenta							cterm=underline
hi Underlined			  guifg=magenta							  gui=underline

hi Error				ctermfg=white		ctermbg=red			cterm=bold
hi Error				  guifg=white		  guibg=red			  gui=bold
hi SpellErrors			ctermfg=white		ctermbg=red			cterm=bold
hi SpellErrors			  guifg=white		  guibg=red			  gui=bold

" Make colorscheme

hi makeTarget			ctermfg=12								cterm=bold
hi makeTarget			  guifg=NONE							  gui=bold
hi makeIdent			ctermfg=yellow							cterm=bold
hi makeIdent			  guifg=yellow							  gui=bold
hi makeIdentAssign		ctermfg=yellow							cterm=NONE
hi makeIdentAssign		  guifg=yellow							  gui=NONE
hi makeStatement		ctermfg=red								cterm=bold
hi makeStatement		  guifg=red								  gui=bold
hi makeRulePattern		ctermfg=green
hi makeRulePattern		  guifg=green

