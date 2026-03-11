#!/bin/bash
# This wrapper script is invoked by xdg-desktop-portal-termfilechooser.
#
# Inputs:
# 1. "1" if multiple files can be chosen, "0" otherwise.
# 2. "1" if a directory should be chosen, "0" otherwise.
# 3. "0" if opening files was requested, "1" if writing to a file was
#    requested. For example, when uploading files in Firefox, this will be "0".
#    When saving a web page in Firefox, this will be "1".
# 4. If writing to a file, this is recommended path provided by the caller. For
#    example, when saving a web page in Firefox, this will be the recommended
#    path Firefox provided, such as "~/Downloads/webpage_title.html".
#    Note that if the path already exists, we keep appending "_" to it until we
#    get a path that does not exist.
# 5. The output path, to which results should be written.
#
# Output:
# The script should print the selected paths to the output path (argument #5),
# one path per line.
# If nothing is printed, then the operation is assumed to have been canceled.

multiple="$1"
directory="$2"
save="$3"
path="$4"
out="$5"

cmd=$(which ranger)
termcmd=("$(which alacritty)" --class Info -T 'Ranger file picker' )

if ! [ -f "$out" ]; then
    touch "$out"
fi

if [ "$save" = "1" ]; then

    touch "$path"
    set -- --choosefile="$out" \
        --cmd="echo Select save path" \
        --cmd="touch $path" \
        "$(dirname "$path")"

elif [ "$directory" = "1" ]; then
    set -- --choosedir="$out" --show-only-dirs --cmd="echo Select directory (quit in dir to select it)"
elif [ "$multiple" = "1" ]; then
    echo >> "$out"
    set -- --choosefiles="$out" --cmd="echo Select file(s) (open file to select it; <Space> to select multiple)"
else
    set -- --choosefile="$out" --cmd="echo Select file (open file to select it)"
fi

cmd=( "${cmd[@]}" "${@}" )
selcmd=( "${termcmd[@]}" -e "${cmd[@]}" )
echo "${selcmd[@]@Q}"
"${selcmd[@]}"
if [ -f "$path" ] && [ "$save" = "1" ] && [ ! -s "$out" ]; then
    rm "$path"
fi
