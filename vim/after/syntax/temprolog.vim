
syn region tplUnion matchgroup=tplUnionDelimiter start=/(/ end=/)/ contains=@tplTerm
syn region tplInter matchgroup=tplInterDelimiter start=/{/ end=/}/ contains=@tplTerm
syn region tplArglist matchgroup=tplArglistDelimiter start=/\[/ end=/\]/ contains=@tplTerm

syn match tplVariable /\<[A-Z]\i*\>/
syn match tplAtom /\<[a-z]\i*\>/
syn match tplNumber /\<\d\+\>/
syn region tplString start='"' end='"'

syn match tplMember /\.\i*/ contains=tplVariable
syn region tplMember matchgroup=tplMember start=/\.(/ end=/)/ contains=@tplTerm

syn match tplType /\w\@<!\.\?\<[a-z]\i\+\.\@=/

syn match tplSymbol /[/\\:*&=<>$%?;!#@+-]\+/
syn match tplSymbol /,/

syn region tplComment oneline start=+%/+ end=+$+

syn cluster tplTerm add=tplVariable,tplAtom,tplNumber,tplSymbol,tplString
syn cluster tplTerm add=tplType,tplMember
syn cluster tplTerm add=tplUnion,tplInter,tplArglist
syn cluster tplTerm add=tplComment


hi link tplVariable Conditional
hi link tplMember Conditional
hi link tplAtom Constant
hi link tplNumber Constant
hi link tplType Constant
hi link tplSymbol Identifier
hi link tplString String
hi link tplComment Comment

hi link tplArglistDelimiter Changed
hi link tplUnionDelimiter Constant
hi link tplInterDelimiter Define
