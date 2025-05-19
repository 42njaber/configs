
if ! exists('s:reload_pre')
	function! s:ReloadPre()
		mapclear
		imapclear
		cmapclear

		echo "[PRELOAD] "..expand('<script>').." "
		let s:reload_pre=0
		source <script>
		unlet s:reload_pre
	endfunc
endif

function! s:Reload()
	let l:scripts = getscriptinfo({"name":"/configs/vim/"})
	let l:scripts = filter(l:scripts, "v:val.name =~ '\\(vimrc\\|/plugin/\\|/autoload/\\|ftdetect\\)'")
	for script in scripts
		let l:script = getscriptinfo({"sid": script.sid})[0]
		let l:script_buf = bufnr(script.name)
		if script.variables->get('reload_me') || getbufvar(script_buf,"reload_me",v:false)
			echo "[RELOAD] "..script.name
			exec "source "..script.name
		endif
	endfor
	call s:ReloadFiletypes()
endfunction

function! s:ReloadFiletypes()
	echo "Reloading filetypedetect"
	augroup filetypedetect
		au!
		unlet g:did_load_filetypes
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

if ! exists('s:reload_post')
	function! s:ReloadPost()
		echo "[POSTLOAD] "..expand('<script>')..""
		let s:reload_post=0
		source <script>
		unlet s:reload_post
	endfunction
endif

augroup reload
	au!

	autocmd User ReloadConfig call s:ReloadPre() | call s:Reload() | call s:ReloadPost()
	autocmd User ReloadLocals ++nested call s:ReloadLocals()
	autocmd User ReloadWins ++nested call s:ReloadWins()
augroup END

command! -bang ShouldReload let b:reload_me=<bang>v:true

map			<LEADER>r			<NOP>
map			<LEADER>rr			<Cmd>do User ReloadConfig<CR>
map			<LEADER>ra			<Cmd>do User ReloadConfig \| doautoall User ReloadLocals \| do User ReloadWins<CR>

map			<LEADER>rf			:exec "tabnew ~/configs/vim/after/ftplugin/"..&ft..".vim"<CR>
map			<LEADER>rs			:exec "tabnew ~/configs/vim/after/syntax/"..&ft..".vim"<CR>
map			<LEADER>ri			:exec "tabnew ~/configs/vim/after/indent/"..&ft..".vim"<CR>
