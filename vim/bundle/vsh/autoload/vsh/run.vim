
function! vsh#run#SimpleRun(command, capture_stdout, capture_stderr)
endfunc

function! s:ReplaceOutput(lines, prefix, start, length)
	for l:i in range(0, a:length - 1)
		call setline(a:start + l:i, a:prefix..(l:i < len(a:lines) ? a:lines[i] : ""))
	endfor
endfunc

function! vsh#run#RunOutputInBuffer(command, line_buffers)
	let l:outputs = vsh#run#SimpleRun(a:command, len(keys(a:line_buffers["stdout"])) > 0, len(keys(a:line_buffers["stderr"])) > 0)
	if has_key(a:line_buffers["stdout"], "head")
		let l:buffer = a:line_buffers["stdout"]["head"]
		call s:ReplaceOutput(l:outputs["stdout"][0:l:buffer["length"]], l:buffer["prefix"], l:buffer["start"], l:buffer["length"])
	endif
	if has_key(a:line_buffers["stdout"], "tail")
		let l:buffer = a:line_buffers["stdout"]["tail"]
		call s:ReplaceOutput(l:outputs["stdout"][-l:buffer["length"]:], l:buffer["prefix"], l:buffer["start"], l:buffer["length"])
	endif
endfunc
