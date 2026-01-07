#!/usr/bin/env bash

wezterm() {
	local windowsConfigPath="/mnt/c/Users/luck/.wezterm.lua"
	local linuxConfigPath="$HOME/.config/wezterm/wezterm.lua"

	"$EDITOR" "$windowsConfigPath"
	cp "$windowsConfigPath" "$linuxConfigPath"
}
