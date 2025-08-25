
set list
set belloff=all
set lcs=tab:--\|,multispace:.\ \ \ ,eol:$,nbsp:#
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
	const bufs = tabpagebuflist()

	let ret = []
	for num in range(tabpagenr('$'))
		let num += 1
		let cwd = getcwd(-1,num)->ShortestPath(getcwd(-1))->PathAbbrev(15)

		let s = ('%' .. num .. 'T') .. (num == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')
		let s ..= ' [' .. tabpagebuflist(num)->len() .. '] '
		let s ..= (cwd == ''?'(.) ':'(%.20('..cwd..')%) ')

		let ret = ret->add(s)
	endfor

	let ret = ret->add('%=')

	for num in range(bufs->len())
		let num += 1
		let s = '%#TabLineSel# ['
		let s ..= (num == winnr() ? '%#TabLineSelEm#' : '')
		let s ..= "%.50(" .. expand("#"..bufs[num - 1]..":p")->ShortestPath(getcwd(-1,tabpagenr()))->PathAbbrev(50).."%)"
		let s ..= (num == winnr() ? '%#TabLineSel#' : '').."] "

		let ret = ret->add(s)
	endfor

	return ret->join('%#TabLineFill#%T ')
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

function! PathAbbrev(path,max=0)
	if a:max > 0 && a:path->len() < a:max
		return a:path
	else
		return a:path->pathshorten()
	endif
endfunction

try 
	call GetTabline()
	setg tabline=%{%GetTabline()%}
catch
	echoh Error
	echom v:exception
	echoh None
	setg tabline=
endtry
