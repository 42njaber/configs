#!/usr/bin/env bash

if [ `pgrep -f autoclick.sh | wc -w` -gt 3 ] > /dev/null
then
	notify-send -t 1000 "Autoclicker has been stopped"
	pkill -f autoclick.sh > /dev/null
else
	notify-send -t 1000 "Autoclicker has been started"
	while [ true ]; do
		ydotool click 1
		sleep 0.1
	done
fi
