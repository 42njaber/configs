
function! ExtendedMan(section,manpage,search = "")
	if a:section == 0
		let l:bufname= "[Manual] "..a:manpage
		let l:command = ["man",a:manpage]
	else
		let l:bufname= "[Manual."..a:section.."] : "..a:manpage
		let l:command = ["man",a:section,a:manpage]
	endif
	call ExtendedHelp(l:bufname,l:command,a:search)
endfunction

if ! has('nvim')
	command -count=0 -nargs=+ Man call ExtendedMan(<count>, <f-args>)
endif
