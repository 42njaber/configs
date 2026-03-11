
function CompleteFile(findstart,base)
	if a:findstart == 1
		let line = getline('.')[:col('.')-2]
		return line->match('[[:fname:]]\@<![[:fname:]]*$')
	else
		let path = expand(a:base)
		let files = glob(path.."*",v:false,v:true,v:true)
		let files = files->map({i,f -> isdirectory(f) ? f .. "/" : f})
		return files->map({i,f -> f->substitute(path,a:base,"")})
	endif
endfunction

setg completefunc=CompleteFile

inoremap <C-X><C-U> <Nop>
inoremap <C-X><C-F> <Cmd>set cfu=CompleteFile<CR><C-X><C-U>
