
if exists("b:current_syntax")
	finish
endif

let s:cpo_save = &cpo
set cpo&vim

syn match makeLineContinuation /\\$/ contained conceal cchar=>

syn match makePreCondit	"^\s*\(ifeq\>\|else\>\|endif\>\|ifneq\>\|ifdef\>\|ifndef\>\)"
syn match makeInclude	"^\s*[-s]\=include"
syn match makeStatement	"^\s*vpath"
syn match makeExport    "^\s*\(export\|unexport\)\>"
syn match makeOverride	"^\s*override"

syn region  makeDString start=+\(\\\)\@<!"+  skip=+\\.+  end=+"+  contains=makeIdent,makeFunction containedin=makeGroup,makeFunction
syn region  makeSString start=+\(\\\)\@<!'+  skip=+\\.+  end=+'+  contains=makeIdent,makeFunction containedin=makeGroup,makeFunction
syn region  makeBString start=+\(\\\)\@<!`+  skip=+\\.+  end=+`+  contains=makeIdent,makeSString,makeDString,makeLineContinuation,makeGroup,makeFunction containedin=makeGroup,makeFunction

syn region makeIdent matchgroup=makeStatement contains=makeFunction,makeGroup,makeIdent,makeLineContinuation start=/\$(/ skip=/\\)\|\\\\/ end=/)/ oneline
syn region makeIdent matchgroup=makeStatement contains=makeFunction,makeGroup,makeIdent,makeLineContinuation start=/\${/ skip=/\\}\|\\\\/ end=/}/ oneline

syn match makeIdent /\$[^({]/

syn region makeGroup matchgroup=makeStatement contains=makeFunction,makeGroup,makeIdent,makeLineContinuation start=/(/ skip=/\\)\|\\\\/ end=/)/ oneline
syn region makeGroup matchgroup=makeStatement contains=makeFunction,makeGroup,makeIdent,makeLineContinuation start=/{/ skip=/\\}\|\\\\/ end=/}/ oneline

syn match makeIdentAssign /^\([^({= \t]\|([^({)]*)\)\+\s*[:+?!*]\?=/ contains=makeGroup,makeFunction,makeIdent 

syn match makeParameter /\(\$\((\|{\)foreach\s\)\@<=\(\([^,]\|\\\n\)*,\)\{2}/ contains=makeFunction,makeGroup,makeIdent,makeSString,makeDString,makeLineContinuation

syn region makeFunction matchgroup=makeStatement contains=makeParameter,makeFunction,makeFunctionName,makeGroup,makeIdent,makeIdentAssign,makeLineContinuation start=/\(\(\$\$\)\@<=\|\$\)(\(\(subst\|abspath\|addprefix\|addsuffix\|and\|basename\|call\|dir\|error\|eval\|filter-out\|filter\|findstring\|firstword\|flavor\|foreach\|if\|info\|join\|lastword\|notdir\|or\|origin\|patsubst\|realpath\|shell\|sort\|strip\|suffix\|value\|warning\|wildcard\|word\|wordlist\|words\)\s\)\@=/ skip=/\\)\|\\\\\|:/ end=/)\|$/ oneline

syn region makeFunction matchgroup=makeStatement contains=makeParameter,makeFunction,makeFunctionName,makeGroup,makeIdent,makeIdentAssign,makeLineContinuation start=/\(\(\$\$\)\@<=\|\$\){\(\(subst\|abspath\|addprefix\|addsuffix\|and\|basename\|call\|dir\|error\|eval\|filter-out\|filter\|findstring\|firstword\|flavor\|foreach\|if\|info\|join\|lastword\|notdir\|or\|origin\|patsubst\|realpath\|shell\|sort\|strip\|suffix\|value\|warning\|wildcard\|word\|wordlist\|words\)\s\)\@=/ skip=/\\}\|\\\\/ end=/}/ oneline

syn match makeFunctionName "\((\|{\)\(subst\|abspath\|addprefix\|addsuffix\|and\|basename\|call\|dir\|error\|eval\|filter-out\|filter\|findstring\|firstword\|flavor\|foreach\|if\|info\|join\|lastword\|notdir\|or\|origin\|patsubst\|realpath\|shell\|sort\|strip\|suffix\|value\|warning\|wildcard\|word\|wordlist\|words\)\s\@=\>"lc=1

syn region makePrereq		start=// end=/$/ contains=makeIdent,makeGroup,makeFunction,makeLineContinuation,makeComment contained oneline nextgroup=makeRecipe
syn match makeStPat			/[^({:]\+:/ contains=makeIdent,makeGroup,makeFunction,makeLineContinuation contained nextgroup=makePrereq
syn match makeTarget		/^\([^({):]\|(\([^({)]\|(\([^({)]\|(\([^({)]\|()\)*)\)*)\)*)\)\+:=\@!/ contains=makeIdent,makeGroup,makeFunction,makeLineContinuation nextgroup=makeStPat,makePrereq

syn region makeRecipe		start=/$/ end=/^[^\t]/ contained contains=makeIdent,makeFunction

syn match makeRulePattern /%/ containedin=makeTarget,makeStPat,makePrereq contained

syn region makeSpecTarget	transparent matchgroup=makeSpecTarget start="^\s*\.\(SUFFIXES\|PHONY\|DEFAULT\|PRECIOUS\|IGNORE\|SILENT\|EXPORT_ALL_VARIABLES\|KEEP_STATE\|LIBPATTERNS\|NOTPARALLEL\|DELETE_ON_ERROR\|INTERMEDIATE\|POSIX\|SECONDEXPANSION\|SECONDARY\)\>\s*:\{1,2}[^:=]"rs=e-1 end="[^\\]$" keepend contains=makeGroup,makeIdent,makeFunction,makeSpecTarget,makeNextLine,makeComment skipnl nextGroup=makeCommands
syn match makeSpecTarget	"^\s*\.\(SUFFIXES\|PHONY\|DEFAULT\|PRECIOUS\|IGNORE\|SILENT\|EXPORT_ALL_VARIABLES\|KEEP_STATE\|LIBPATTERNS\|NOTPARALLEL\|DELETE_ON_ERROR\|INTERMEDIATE\|POSIX\|SECONDEXPANSION\|SECONDARY\)\>\s*::\=\s*$" contains=makeGroup,makeIdent,makeFunction,makeComment skipnl nextgroup=makeCommands,makeCommandError

if !exists("make_no_comments")
   syn region  makeComment	start="#" end="^$" end="[^\\]$" keepend contains=@Spell,makeTodo
   syn match   makeComment	"#$" contains=@Spell
endif
syn keyword makeTodo TODO FIXME XXX contained

syn region makeDefine matchgroup=makeStatement start="^\s*define\s" end="^\s*endef\s*\(#.*\)\?$" contains=ALLBUT,makeStPat,makePrereq,makeRecipe

" syn region makeCommands start=// end=/^[^\t]/ contained

hi def link makeFunction		Normal
hi def link makeFunctionName	Statement
hi def link makeParameter		Special
hi def link makeRecipe			Normal
hi def link makeRule			Normal
hi def link makeRuleTarget		Normal
hi def link makeTarget			Function
hi def link makeStPat			makeParameter
hi def link makeSpecTarget		Statement
hi def link makeInclude			Include
hi def link makePreCondit		PreCondit
hi def link makeStatement		Statement
hi def link makeGroup			Normal
hi def link makeIdent			Identifier
hi def link makeIdentAssign		Statement
hi def link makeStatement		Identifier
hi def link makeRulePattern		Special
hi def link makeSpecial			Special
hi def link makeComment			Comment
hi def link makeDString			String
hi def link makeSString			String
hi def link makeBString			Function
hi def link makeError			Error
hi def link makeTodo			Todo
hi def link makeDefine			Normal
hi def link makeCommandError	Error
hi def link makeConfig			PreCondit

if !exists("make_no_commands")
hi def link makeCommands		Number
endif

let b:current_syntax="make"

let &cpo = s:cpo_save
unlet s:cpo_save
