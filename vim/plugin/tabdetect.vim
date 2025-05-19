
function! TabDetect()
	let svpos = winsaveview()
	const linecount=min([1000,line('$')])
	let tabs = 0
	exec "silent 0,"..linecount.." g /^\\t\\+/ let tabs += 1"
	let dominant = "1"
	for i in [1,2,4,8]
		let space = 0
		exec "silent 0,"..linecount.." g /^\\([ ]\\{"..i.."}\\)[^ ]/ let space += 1"
		exec "let space"..i.." = space"
		if i > 1 && eval("space >= 8 * space"..dominant)
			let dominant = i
		endif
	endfor
	setlocal softtabstop=0
	if tabs > 0 && eval("tabs >= space"..dominant)
		setlocal noet
		let tabsize = 4
		for i in [1,2,4,8]
			let space = 0
			exec "silent 0,"..linecount.." g /^\\t*\\([ ]\\{"..i.."}\\)\\+/ let space += 1"
			if eval(8 * space > tabs)
				if i == 1
					break
				endif
				let tabsize = i
			endif
		endfor
		exec "setlocal shiftwidth="..tabsize
	elseif eval("space"..dominant.." > 0")
		setlocal et
		exec "setlocal shiftwidth="..dominant
	endif
	call winrestview(svpos)
endfunction

augroup tabdetect
	au!
	au BufRead * call TabDetect()
augroup END
