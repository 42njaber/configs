
if exists("g:loaded_advancedsyntax")
	finish
endif
let g:loaded_advancedsyntax = 1

function! advancedsyntax#ClearPatterns()
	let w:defined_patterns = []
	call advancedsyntax#UpdateMatches()
endfunction

function! advancedsyntax#AddIdentifierPattern(group, pattern)
	if !exists("w:identifier_patterns")
		let w:identifier_patterns = []
	endif
	let w:identifier_patterns += [[a:group, a:pattern]]
	call advancedsyntax#UpdateMatches()
endfunction

function! advancedsyntax#AddPattern(group, pattern)
	if !exists("w:defined_patterns")
		let w:defined_patterns = []
	endif
	let w:defined_patterns += [[a:group, a:pattern]]
	call advancedsyntax#UpdateMatches()
endfunction

function! advancedsyntax#UpdateIdentifiers()
	w:identifiers = []
	while (l:i <= line('$'))
		let l:line = getline(l:i)
		for [group, pattern] in w:identifier_patterns
			let l:col = 0
			let l:matches = []
			while (l:col >= 0)
				let l:match_pos = [match(l:line, pattern, col), matchend(l:line, pattern, col)]
				if (l:match_pos[0] >= 0)
					let l:col = l:match_pos[1]
				else
					let l:col = -1
				endif
			endwhile
			if len(l:matches) > 0
				let w:current_matches += [matchaddpos("Visual", l:matches)]
			endif
		endfor
	endwhile
endfunction

function! advancedsyntax#UpdateMatches()
	if !exists("w:defined_patterns")
		return
	endif
	if exists("w:current_matches")
		for id in w:current_matches
			call matchdelete(id)
		endfor
	endif
	let w:current_matches = []
	let l:i = 1
	while (l:i <= line('$'))
		let l:line = getline(l:i)
		for [group, pattern] in w:defined_patterns
			let l:col = 0
			let l:matches = []
			while (l:col >= 0)
				let l:match_pos = [match(l:line, pattern, col), matchend(l:line, pattern, col)]
				if (l:match_pos[0] >= 0)
					if (synID(l:i, l:match_pos[0] + 1, 1) == 0 && synID(l:i, l:match_pos[1], 1) == 0)
						let l:matches += [[l:i, l:match_pos[0] + 1, l:match_pos[1] - l:match_pos[0]]]
						let l:col = l:match_pos[1]
					elseif (synID(l:i, l:match_pos[0] + 1, 1) == 0)
						let l:col = l:match_pos[0] + 1
					else
						let l:col = l:match_pos[1]
					endif
				else
					let l:col = -1
				endif
			endwhile
			if len(l:matches) > 0
				let w:current_matches += [matchaddpos("Visual", l:matches)]
			endif
		endfor
		let l:i += 1
	endwhile
endfunction

augroup advancedsyntax
	au!
	au BufNewFile,BufReadPost,Syntax,TextChanged,TextChangedI * call advancedsyntax#UpdateMatches()
augroup END
