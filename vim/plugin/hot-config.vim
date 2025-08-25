
if ! exists('s:reload_pre')
	function! s:ReloadPre()
		echo "[PRELOAD] "..expand('<script>').." "
		let s:reload_pre=0
		source <script>
		unlet s:reload_pre
	endfunc
endif

function! s:SaveTimestamps()
	for script in getscriptinfo()
		let s:timestamps[script.name] = getftime(script.name)
	endfor
endfunction

if ! exists("s:timestamps")
	let s:timestamps = {}
	call s:SaveTimestamps()
endif

function! s:Reload()
	let l:scripts = getscriptinfo()
	let l:scripts = filter(l:scripts, {_,val -> 
				\ 	(val.autoload == v:false) &&
				\ 	(val.name =~ 'vimrc\|/plugin/\|/autoload/\|ftdetect') &&
				\ 	(val.name !~ '^\(/etc\|/usr\)') &&
				\ 	(val.name !~ 'hot-config.vim')
				\ })
	for script in scripts
		if (s:timestamps->get(script.name,0) != getftime(script.name))
			echo "[RELOAD] "..script.name
			exec "source "..script.name
			let s:timestamps[script.name] = getftime(script.name)
		endif
	endfor
	call s:ReloadFiletypes()
endfunction

if ! exists('s:reload_post')
	function! s:ReloadPost()
		echo "[POSTLOAD] "..expand('<script>')..""
		let s:reload_post=0
		source <script>
		unlet s:reload_post
	endfunction
endif

function! s:ReloadFiletypes()
	echo "Reloading filetypedetect"
	augroup filetypedetect
		au!
		if exists('g:did_load_filetypes')
			unlet g:did_load_filetypes
		endif
		runtime! filetype.vim
	augroup END
endfunction

function! s:ReloadLocals()
	mapclear <buffer>
	imapclear <buffer>
	cmapclear <buffer>

	au! * <buffer>

	setf FALLBACK RESET
	doau BufRead
endfunction

function! s:ReloadWins()
	let win = winnr()
	let tab = tabpagenr()
	tabdo windo exec 'runtime! ftplugin/'..&ft..'.vim'
	exec tab.."tabn"
	exec win.."winc w"
endfunction

augroup reload
	au!

	autocmd SourcePost * let s:timestamps[expand("<afile>:p")] = getftime(expand("<afile>"))
	autocmd User ReloadConfig call s:ReloadPre() | call s:Reload() | call s:ReloadPost()
	autocmd User ReloadLocals ++nested call s:ReloadLocals()
	autocmd User ReloadWins ++nested call s:ReloadWins()
	autocmd User ReloadPost eval 0
augroup END

command! -bang ShouldReload let b:reload_me=<bang>v:true

map			<LEADER>r			<NOP>
map			<LEADER>rr			<Cmd>do User ReloadConfig \| do User ReloadLocals<CR>
map			<LEADER>rf			<Cmd>do User ReloadConfig<CR>
map			<LEADER>rR			<ScriptCmd>let s:timestamps={}<CR><Cmd>do User ReloadConfig \| doautoall User ReloadLocals \| do User ReloadWins<CR>

map			<LEADER>Rf			:exec "tabnew ~/configs/vim/after/ftplugin/"..&ft..".vim"<CR>
map			<LEADER>Rs			:exec "tabnew ~/configs/vim/after/syntax/"..&ft..".vim"<CR>
map			<LEADER>Ri			:exec "tabnew ~/configs/vim/after/indent/"..&ft..".vim"<CR>
