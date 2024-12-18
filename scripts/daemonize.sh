#!/bin/env bash

pidfile="/tmp/$1"
shift
exe="$1"
shift

start-stop-daemon --stop  --pidfile "$pidfile" --remove-pidfile --oknodo
start-stop-daemon --start --pidfile "$pidfile" --background --make-pidfile -a "$exe" -- $@
