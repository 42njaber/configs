
colorscheme custom
setg synmaxcol=400

setg cindent
setg shiftwidth=4
setg tabstop=4
setg noexpandtab
setg list
setg lcs=tab:>-,space:_
setg conceallevel=2

setg laststatus=2
setg showcmd
setg showmode
setg report=2

setg numberwidth=4
setg relativenumber

setg more
setg cursorline

setg statusline=
setg statusline+=\ %1*%{&readonly?'[RO]':&modifiable?'':'[UN]'}%0*
setg statusline+=%f
setg statusline+=\ %0*[%.20(%{&ft}%)]%0*
setg statusline+=%5(%2*%-3.3{&modified?'\ +\ ':''}%0*%)
setg statusline+=\ \ %S%=
setg statusline+=C:%c%V\ L:%l/%L(%p%%)
