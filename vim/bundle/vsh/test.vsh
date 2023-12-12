
python3 {
	print test
}

man bash
> PYTHON(1)                                                               General Commands Manual                                                               PYTHON(1)
> 
> NAME
>        python - an interpreted, interactive, object-oriented programming language
> 
> SYNOPSIS
>        python [ -B ] [ -b ] [ -d ] [ -E ] [ -h ] [ -i ] [ -I ]
>               [ -m module-name ] [ -q ] [ -O ] [ -OO ] [ -s ] [ -S ] [ -u ]
>               [ -v ] [ -V ] [ -W argument ] [ -x ] [ [ -X option ] -?  ]
>               [ --check-hash-based-pycs default | always | never ]
>               [ -c command | script | - ] [ arguments ]
> 
> DESCRIPTION
>        Python  is an interpreted, interactive, object-oriented programming language that combines remarkable power with very clear syntax.  For an introduction to pro‐
>        gramming in Python, see the Python Tutorial.  The Python Library Reference documents built-in and standard types, constants, functions  and  modules.   Finally,
>        the  Python  Reference Manual describes the syntax and semantics of the core language in (perhaps too) much detail.  (These documents may be located via the IN‐
>        TERNET RESOURCES below; they may be installed on your system as well.)
> 
>        Python's basic power can be extended with your own modules written in C or C++.  On most systems such modules may be dynamically loaded.  Python is also  adapt‐
>        able as an extension language for existing applications.  See the internal documentation for hints.
> 
....
<
<
<
<
<
<
<
<
<
<
<
<
<

ls

mkfifo stdin.pipe stdout.pipe
rm *.pipe
python3 -c '__import__("pty").spawn("/bin/bash")' < stdin.pipe | tee stdout.pipe

echo $$
mkdir -p /tmp/vsh
STDIN="/tmp/vsh/test.$$.in"
mkfifo "$STDIN"
STDOUT="/tmp/vsh/test.$$.out"
mkfifo "$STDOUT"
python3 -c '__import__("pty").spawn("/bin/bash")' < "$STDIN" > "$STDOUT" & true
