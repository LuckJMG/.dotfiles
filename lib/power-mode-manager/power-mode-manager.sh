#!/bin/bash

while true; do
	STATUS=$(cat /sys/class/power_supply/BAT1/status)
	BATTERY=$(cat /sys/class/power_supply/BAT1/capacity)

	if [ "$STATUS" = "Charging" ]; then
		powerprofilesctl set performance
	elif [ "$BATTERY" -le 30 ]; then
		powerprofilesctl set power-saver
	else
		powerprofilesctl set balanced
	fi

	sleep 30
done

