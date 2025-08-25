vim9s

setg splitbelow
setg splitright

# Go to previous tab on close

augroup vimrc
	g:tablist = [1, 1]
	au TabLeave * g:tablist[0] = g:tablist[1]
	au TabLeave * g:tablist[1] = tabpagenr()
	au TabClosed * exe "normal " .. g:tablist[0] .. "gt"
augroup END

def ChooseBuffer()
	var jumps = getjumplist()[0]
	jumps = jumps->filter((i, v) => v.bufnr > 0 && v.bufnr != bufnr())
	var buffers = [{id: bufnr(), name: bufname()}]
	while jumps->len() > 0
		const buf = jumps[-1].bufnr
		jumps = jumps->filter((i, v) => v.bufnr != buf)
		if buf->buflisted()
			buffers += [{id: buf, name: buf->bufname()}]
		endif
	endwhile
	var delete = v:false
	buffers->mapnew((_, v) => v.id .. " " .. v.name)
		->popup_menu({
			filter: (id, key) => {
				if key == "<Esc>"
					popup_close(id, -1)
				elseif key == "X"
					delete = v:true
					return popup_filter_menu(id, " ")
				elseif key == "	"
					return popup_filter_menu(id, "j")
				elseif key->len() == 3
						&& char2nr(key[0]) == 0x80
						&& char2nr(key[1]) == 0x6b
						&& char2nr(key[2]) == 0x42
					return popup_filter_menu(id, "k")
				endif
				return popup_filter_menu(id, key)
			},
			callback: (_, result) => {
				if result >= 0
					if delete
						echo "Closing buffer '" .. buffers[result - 1].name .. "'"
						exec "bw " .. buffers[result - 1].id
					else
						exec "b " .. buffers[result - 1].id
					endif
				endif
			}
		})
enddef

nnoremap 	<LEADER>z 	<Cmd>call <SID>ChooseBuffer()<CR>
