
function! PythonExtendedHelp(search)
	let l:bufname= "/tmp/python-help.man"
	let l:command = ["sh","-c","! python -c 'help(\"".a:search."\")' | head -n1 | grep -q 'No Python documentation found' && python -c 'help(\"".a:search."\")'"
				\ ]
	call ExtendedHelp(l:bufname,l:command)
endfunction

command -nargs=1 Pyhelp call PythonExtendedHelp(<f-args>)

" Pydoc is too slow
" function! PythonExtendedHelpSearch(search)
" 	let l:bufname= "/tmp/python-help-search.man"
" 	echo a:search
" 	let l:pages = systemlist("python -m pydoc -k '"..a:search.."' | cut -f1 -d' '")
" 	echo pages
" 	let l:command = ["python","-c",l:pages->map({p -> "help(".p.")"})->join(";")]
" 	call ExtendedHelp(l:bufname,l:command,a:search)
" endfunction
"command -nargs=1 Pyhgrep call PythonExtendedHelpSearch(<f-args>)
