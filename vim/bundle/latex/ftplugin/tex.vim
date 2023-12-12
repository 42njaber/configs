
set sw=4

set iskeyword+=:

let Tex_DefaultTargetFormat="pdf"
let g:tex_noindent_env = "verbatim\|comment\|lstlisting"
let g:Tex_MultipleCompileFormats = "dvi,pdf"
let Tex_FoldedSections=""
let Tex_FoldedEnvironments=""
let Tex_FoldedMisc=""

let Tex_CompileRule_pdf = "pdflatex -synctex=1 -interaction=nonstopmode -shell-escape -file-line-error-style $*"
let Tex_CompileRule_dvi = "latex -interaction=nonstopmode -shell-escape -file-line-error-style $*"

imap é \'e
imap è \`e
imap ê \^e
imap ù \`u
imap à \`a
imap ç \c{c}
