
function! ReloadScripts()
	let l:more=&more
	set nomore
	let l:scripts = getscriptinfo({"name":"/configs/vim/"})
	let l:scripts = filter(l:scripts, "v:val.name =~ '/\\(plugin\\|autoload\\)/'")
	let l:scripts = filter(l:scripts, "v:val.name !~ '/reload-config.vim$'")
	for script in scripts
		echo "Resourcing "..script.name
		exec "source "..script.name
	endfor
	sleep 1m
	exec "set "..(l:more?"":"no").." more"
	call feedkeys(" ")
endfunction

function! ReloadBuffs()
	let l:more=&more
	set nomore
	let l:buf=bufnr()
	bufdo se ei= | if bufname('%') != '' | e | endif | filetype detect
	sleep 1m
	call feedkeys(" ")
	exec buf.."b"
	exec "set "..(l:more?"":"no").." more"
	call feedkeys(" ")
endfunction

augroup reload
	au!

	autocmd User ConfigReloadPre source <sfile> | call ReloadScripts()
	autocmd User ReloadFull call ReloadBuffs()
augroup END
