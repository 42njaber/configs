#/bin/env bash

COMMAND="display-message 'new-session -s %%'"
COMMAND="new-session -s %%"

ENTRIES=()
for session in `ls "$TMUX_STORE/sessions"`; do
	if [[ -n "`tmux list-sessions -f "#{==:#S,$session}"`" ]]; then
		session="-$session"
	fi
	ENTRIES+=("$session" "" "${COMMAND/\%\%/${session@Q}}")
done

ENTRIES+=("#[fg=red,bold]New" '""' "command-prompt -p 'Session name' ${COMMAND@Q}")

tmux display-menu -xP -y0 -T "SAVED SESSIONS" -- "${ENTRIES[@]}"
