
function! ReloadScripts()
	let l:scripts = getscriptinfo({"name":$HOME."/configs/vim/"})
	let l:scripts = filter(l:scripts, "v:val.name =~ '/\\(plugin\\|autoload\\)/'")
	let l:scripts = filter(l:scripts, "v:val.name !~ '/reload-config.vim'")
	for script in scripts
		exec "source "..script.name
	endfor
endfunction

function! ReloadBuffs()
	let l:buf=bufnr()
	bufdo se ei= | filetype detect
	exec buf.."b"
endfunction

augroup reload
	au!

	autocmd User ConfigReloadPre source <sfile> | call ReloadScripts()
	autocmd User ConfigPost call ReloadBuffs()
augroup END
