#!/bin/bash

ENABLED=$(xinput list-props 'SynPS/2 Synaptics TouchPad' | grep "Device Enabled" | sed "s/.*\(.\)$/\1/")

if [ "$ENABLED" == "1" ]; then
	xinput disable 'SynPS/2 Synaptics TouchPad'
else
	xinput enable 'SynPS/2 Synaptics TouchPad'
fi
