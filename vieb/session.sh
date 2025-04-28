#!/usr/bin/env bash

ls -1 "$HOME/.viebstore/" | \
tofi --auto-accept-single=false --require-match=false --prompt-text=Session --placeholder-text=\<session\> | \
{ read SESSION
	[ -z "$SESSION" ] && exit
	DIR="$HOME/.viebstore/$SESSION"
	mkdir -p "$DIR"
	! [ -e "$DIR/viebrc" ] && { echo "set windowtitle=\"$SESSION - %title\"" | tee "$DIR/viebrc"; }
	vieb --datafolder="$DIR"
}
