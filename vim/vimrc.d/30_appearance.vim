
set list
set belloff=all
set lcs=tab:--\|,leadmultispace:\|\ \ \ ,multispace:.\ \ \ ,eol:.,nbsp:#
set conceallevel=2
set diffopt=vertical,hiddenoff,filler

set numberwidth=4
set number
set relativenumber

colorscheme custom
setg synmaxcol=400

setg ttyfast
setg lazyredraw

setg laststatus=2
setg showcmd
setg showmode
setg noshowmatch
setg report=2

setg more
setg cursorline
setg hlsearch

setg tabline=%{%GetTabline()%}

setg statusline=
setg statusline+=%1*%{%FileTags()%}%*
setg statusline+=%{getcwd(-1,tabpagenr())==getcwd()?'':'\ ('..getcwd()->ShortestPath(getcwd(-1,tabpagenr()))..')'}
setg statusline+=\ %{expand('%:p')->ShortestPath(getcwd())}
setg statusline+=\ %2*%{%FileStatus()%}%#Visual#
setg statusline+=%{%exists('b:StatusExtra')?b:StatusExtra():''%}
setg statusline+=%=\ \ \ %*
setg statusline+=%{%Ruler()%}

function! FileTags()
	let ret=[
			\ '%.20('..&ft..'%)',
			\ (&buftype == 'help' ? "" : &buftype)
			\ ]
	return '['..ret->filter('v:val != ""')->join(' ')..']'
endfunction

function! FileStatus()
	let ret=&modified?' + ':''
	return ret
endfunction

function! Ruler()
	return 'Bx%02B C:%6(%c%V%) %10(L:%l/%L(%p%%)%)'
endfunction

function! GetTabline()
	let ret = []

	for i in range(tabpagenr('$'))
		let s = '%' .. (i + 1) .. 'T'
		let s ..= GetTabLabel(i + 1,i + 1 == tabpagenr() ? 'TabLineSel' : 'TabLine')
		let ret = ret->add(s)
	endfor

	return ret->join('%#TabLineFill#%T ') .. '%#TabLineFill#%T'
endfunction

function GetTabLabel(n,hi)
	const buflist = tabpagebuflist(a:n)->filter('v:val->getbufvar("&buftype") != "help"')
	const winnr = tabpagewinnr(a:n)
	let bufs = []
	for i in range(buflist->len())
		let bufs = bufs->add("["..(i + 1 == winnr ? '%#'..a:hi..'Em#' : '')
					\.."%.30(" .. expand("#"..buflist[i]..":p")->ShortestPath(getcwd(-1,a:n))->pathshorten().."%)"
					\..(i + 1 == winnr ? '%#'..a:hi..'#' : '').."]")
	endfor
	let cwd = getcwd(-1,a:n)->ShortestPath(getcwd(-1))->pathshorten()
	return '%#'..a:hi..'# '..(cwd==''?'':'('..cwd..') ')..(bufs == [] ? "[%#"..a:hi.."Em#Help%#"..a:hi.."#]" : bufs->join(' '))..' '
endfunction

function! ShortestPath(to,from)
	let from=a:from->split('/')[0:]
	let to=a:to->split('/')[0:]
	let i=0
	while i < from->len() && i < to->len() && from[i] == to[i]
		let i += 1
	endwhile
	let prefix=''
	if i == 0
		let prefix = '/'
	elseif i < from->len()
		if i < from->len() - i
			let prefix = '/' .. from[0:i]->join('/') .. '/'
		else
			let prefix = repeat('.',from->len() - i) .. './'
		endif
	endif
	return prefix .. to[i:-1]->join('/')
endfunction
