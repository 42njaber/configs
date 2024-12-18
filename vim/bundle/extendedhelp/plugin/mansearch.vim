
function! ExtendedMan(section,manpage,search = "")
	let l:bufname= "/tmp/"..a:manpage.."."..a:section..".man"
	if a:section == 0
		let l:command = ["man",a:manpage]
	else
		let l:command = ["man",a:section,a:manpage]
	endif
	call ExtendedHelp(l:bufname,l:command,a:search)
endfunction

command -count=0 -nargs=+ Man call ExtendedMan(<count>, <f-args>)
