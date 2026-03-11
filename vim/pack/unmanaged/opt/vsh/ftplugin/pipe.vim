
let b:tried_term = 0

function! s:PipeStatus()
	let status = job_status( b:vsh_job )
	let ret = ' Status '..status
	if status == "run" && b:tried_term
		let ret ..= ' [terminating]'
	endif
	return ret
endfunction

let b:StatusExtra = function('s:PipeStatus')

function! s:TryStop()
	if job_status(b:vsh_job) == "run"
		if b:tried_term
			call job_stop(b:vsh_job, "kill")
		else
			call job_stop(b:vsh_job, "term")
			let b:tried_term = 1
		endif
	endif
endfunc

function! s:ForceStop()
	if job_status(b:vsh_job) == "run"
		call job_stop(b:vsh_job, "kill")
	endif
endfunc

if !exists("b:do_rerun")
	function! s:RunAgain()
		let b:do_rerun=1
		let b:tried_term=0
		e!
		if job_status(b:vsh_job) != "run"
			call vsh#VimBufRunner(bufnr(), b:vsh_script)
		endif
		unlet b:do_rerun
	endfunc
endif

nnoremap <buffer> 	<C-c> 	<ScriptCmd>call s:TryStop()<CR>
nnoremap <buffer> 	R     	<ScriptCmd>call s:RunAgain()<CR>

" if !exists('b:ansi_loaded')
" 	let b:ansi_loaded = 1
" 	AnsiEsc
" else
" 	AnsiEsc!
" endif
