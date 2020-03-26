#!/bin/sh


# ===DWM STATUS BAR===

	while true; do
		xsetroot -name "[$( date "+🌎%m-%d-%y | 🕓%H:%M" )]"
		sleep 60
	done &


# ===DWM BACKGROUND===

	while true; do
		feh --bg-fill --randomize ~/Pictures/Wallpapers/*
		sleep 900							# Sleep 15min (900 sec's)
	done &


# ===WINDOW TRANSPARCENCY===

	xcompmgr &
	transset .98 &


# ===KEYBOARD===

	setxkbmap dvorak


# ===DWM===

	exec dwm
