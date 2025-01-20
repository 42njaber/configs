
command -nargs=1 TmuxMan :Man tmux ^\s*<args>
setlocal keywordprg=:TmuxMan
setlocal iskeyword+=-
