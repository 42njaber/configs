#!/bin/env bash

cd "$HOME/.vimstore/undo"
find . -type f -printf "%P\0" | {
	while read -rd '' UNDOFILE; do {
		FILE=`tr '%' '/' <<< $UNDOFILE`
		[ -f "$FILE" ] || printf "%s%s\0" "$UNDOFILE"
	} done
} | xargs -0 -o -I{} -- rm -i {}
