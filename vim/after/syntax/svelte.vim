
syn match svelteSnippet /#snippet/  contained containedin=jsBlock,javascriptBlock
syn match svelteSnippet +/snippet+  contained containedin=jsBlock,javascriptBlock
syn match svelteKeyword /@render/   contained containedin=jsBlock,javascriptBlock


hi link svelteSnippet Statement

