so $VIMRUNTIME/syntax/c.vim
syntax match CustomTypes /\<\(\(u\?\(char\|short\|int\|long\)\)\|float\|double\)\(16\|1\|2\|3\|4\|8\)\>/
syntax keyword Type kernel __kernel global __global local __local privat __private
