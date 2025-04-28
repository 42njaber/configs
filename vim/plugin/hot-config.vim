
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

	do BufRead
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
augroup END

command! -bang ShouldReload let b:reload_me=<bang>v:true

map			<TAB>r			<NOP>
map			<TAB>rr			<Cmd>do User ReloadConfig<CR>
map			<TAB>ra			<Cmd>do User ReloadConfig \| doautoall User ReloadLocals<CR>

map			<TAB>rf			:exec "tabnew ~/.vim/after/ftplugin/"..&ft..".vim"<CR>
map			<TAB>rs			:exec "tabnew ~/.vim/after/syntax/"..&ft..".vim"<CR>
map			<TAB>ri			:exec "tabnew ~/.vim/after/indent/"..&ft..".vim"<CR>
