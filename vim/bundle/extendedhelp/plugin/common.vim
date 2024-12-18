
augroup extendedhelp
	au!
	au BufWinEnter */doc/* call CloseEHIfHelp()
augroup END

function! CloseEHIfHelp()
	if &buftype != "help"
		return
	endif
	let l:wins = gettabinfo(tabpagenr())[0]["windows"]
	let l:found_help = 0
	for l:win in l:wins
		if winbufnr(win)->getbufvar("&buftype") == "nofile" && winbufnr(win)->getbufvar("&ft") == "man"
			exec win_execute(win,"close")
		endif
	endfor
endfunction

function! OpenExtendedHelp(buf,search_pattern)
	if bufwinnr(a:buf) > 0
		call win_gotoid(win_getid(bufwinnr(a:buf)))
	else
		let l:wins = gettabinfo(tabpagenr())[0]["windows"]
		let l:found_help = 0
		for l:win in l:wins
			if winbufnr(win)->getbufvar("&buftype") == "help" || winbufnr(win)->getbufvar("&buftype") == "nofile"
				call win_gotoid(win)
				exec "b ".a:buf
				let l:found_help = 1
				break
			endif
		endfor
		if !found_help
			exec "sb ".a:buf
		endif
	endif
	if a:search_pattern != ""
		call cursor(0,0)
		echo a:search_pattern
		call search(a:search_pattern)
		let @/=a:search_pattern
	endif
	set ft=man
endfunction

function! ExtendedHelpAsync(bufnr,search,job,status)
	if a:status == 0
		call OpenExtendedHelp(a:bufnr,a:search)
	else
		exec "bdel" a:bufnr
		echo "Man failed to open"
	endif
endfunction

function! ExtendedHelp(bufname,command,search = "")
	if bufloaded(a:bufname) && type(getbufvar(a:bufname,"eh_command")) == type(a:command) && getbufvar(a:bufname,"eh_command") == a:command
		call OpenExtendedHelp(a:bufname,a:search)
	else
		if bufloaded(a:bufname)
			exec "bdelete" bufnr(a:bufname)
		endif
		call bufadd(a:bufname)
		let l:ehbufnr = bufnr(a:bufname)
		call job_start(a:command, {
					\ 	"in_io": "null",
					\ 	"out_io": "buffer",
					\ 	"out_name": a:bufname,
					\ 	"out_modifiable": 0,
					\ 	"exit_cb": function("ExtendedHelpAsync", [ehbufnr,a:search]),
					\ 	"err_cb": function("Error"),
					\ })
		let l:bufnr = bufnr()
		execute 'noautocmd keepalt buffer' ehbufnr
		let b:eh_command = a:command
		execute 'noautocmd keepalt buffer' l:bufnr
	endif
endfunction

function! Error(channel,msg)
	echomsg a:msg
endfunction

