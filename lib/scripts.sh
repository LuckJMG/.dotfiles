#!/usr/bin/env bash

v() {
	cd "$1" && nvim .
}

mkcd() {
	mkdir -p "$1" && cd "$1" || return
}
