

syn match svelteSnippet /#snippet/  contained containedin=jsBlock,javascriptBlock
syn match svelteSnippet +/snippet+  contained containedin=jsBlock,javascriptBlock
syn match svelteKeyword /@render/   contained containedin=jsBlock,javascriptBlock

hi link svelteSnippet Statement

let main_syntax="svelte"
syn include @typescriptStatement syntax/shared/typescriptcommon.vim
unlet main_syntax
syn region typeScript start=/<script lang="ts"/rs=e,hs=s end=/<\/script>/re=s,he=e keepend
	\ contains=@typescriptStatement,@typescriptComments,htmlScriptTag,htmlEndTag
