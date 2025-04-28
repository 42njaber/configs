
augroup vimrc
	autocmd BufNewFile *.sh 0r ~/.vim/templates/sh/default.sh | normal G
	autocmd BufNewFile *.cpp
				\ if(@% =~ ".*\.class\.cpp") |
				\	0r ~/.vim/templates/cpp/class.cpp | exe 'normal 9G' |
				\ else |
				\	0r ~/.vim/templates/cpp/default.cpp | exe 'normal G' |
				\ endif
	autocmd BufNewFile *.hpp
				\ if(@% =~ ".*\.class\.hpp") |
				\	0r ~/.vim/templates/cpp/class.hpp | exe 'normal 9G' |
				\ else |
				\	0r ~/.vim/templates/cpp/default.hpp | exe 'normal G' |
				\ endif
	autocmd! BufNewFile * %s#\[:VIM_EVAL:\]\(.\{-\}\)\[:END_EVAL:\]#\=eval(submatch(1))#ge|''
augroup END

