
augroup filetypedetect
	au BufNewFile,BufRead *.man                         setfiletype man
	au BufNewFile,BufRead *.pl,*.plt,*.ow               setfiletype prolog
	au BufNewFile,BufRead ranger/rc.conf,rangerrc.conf  setfiletype ranger
	au BufNewFile,BufRead sawy/config,swayconfig        setfiletype swayconfig
	au BufNewFile,BufRead *.tpp                         setfiletype cpp
augroup END

	" au BufNewFile,BufRead *.sh set filetype=bash syntax=bash
	" au BufNewFile,BufRead .i3.config,i3.config,*.i3config,*.i3.config setfiletype i3config
	" au BufNewFile,BufRead *.cl,*.clh                    setfiletype cl
	" au BufNewFile,BufRead *.shader                      setfiletype fx
	" au BufNewFile,BufRead *.fs,*.vs                     setfiletype glsl
