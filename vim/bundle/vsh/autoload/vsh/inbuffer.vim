
function! vsh#inbuffer#GetOutputSpace()
	let l:ret = {"stdout": {}, "stderr": {}}
	let l:stdout_head_char = ">"
	let l:stdout_tail_char = "<"
	let l:cursor_pos = getcurpos()[1:2]
	let l:end = search("^$", "Wn")
	let l:end = l:end == 0 ? line('$') : l:end

	let l:stdout_head_start = search("^"..l:stdout_head_char, "Wn", l:end)
	if (l:stdout_head_start > 0)
		call cursor(l:stdout_head_start, 0)
		let l:stdout_head_end = search("^\\("..l:stdout_head_char.."\\)\\@!", "Wn")
		let l:stdout_head_end = l:stdout_head_end == 0 ? line('$') + 1 : l:stdout_head_end
		let l:ret["stdout"]["head"] = {"prefix": l:stdout_head_char.." ", "start": l:stdout_head_start, "length": l:stdout_head_end - l:stdout_head_start}
	endif
	call cursor(l:cursor_pos)

	let l:stdout_tail_start = search("^"..l:stdout_tail_char, "Wn", l:end)
	if (l:stdout_tail_start > 0)
		call cursor(l:stdout_tail_start, 0)
		let l:stdout_tail_end = search("^\\("..l:stdout_tail_char.."\\)\\@!", "Wn")
		let l:stdout_tail_end = l:stdout_tail_end == 0 ? line('$') + 1 : l:stdout_tail_end
		let l:ret["stdout"]["tail"] = {"prefix": l:stdout_tail_char.." ", "start": l:stdout_tail_start, "length": l:stdout_tail_end - l:stdout_tail_start}
	endif
	call cursor(l:cursor_pos)

	return ret
endfunc
