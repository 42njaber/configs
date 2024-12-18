
command -nargs=1 Csshelp call system('vieb https://developer.mozilla.org/en-US/search?q=<args>; swaymsg [class="Vieb"] focus')

setlocal keywordprg=:Csshelp
setlocal iskeyword=a-z,A-Z,48-57,_,-
