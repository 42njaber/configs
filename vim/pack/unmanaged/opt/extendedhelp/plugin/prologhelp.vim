
function! PrologExtendedHelp(search)
	let l:bufname= "/tmp/prolog-help.man"
	let l:command = ["swipl","-g","help('".a:search."') ; apropos('".a:search."')","-t","halt"]
	call ExtendedHelp(l:bufname,l:command)
endfunction

command -nargs=1 Plhelp call PrologExtendedHelp(<f-args>)
