#!/usr/bin/env bash
CSV_FILE="$HOME/.dotfiles/lib/pkg/pkg.csv"

# A package manager interface to track manually installed packages, pacman version.
pkg() {
	case "$1" in
	"list")
		cat "$CSV_FILE" | sed 's/^[^,]*,//'
		;;
	"upgrade")
		sudo pacman -Syu
		;;
	"search")
		pacman -Ss "$2"
		;;
	"show")
		pacman -Si "$2"
		;;
	"install")
		if [[ $(grep -c "$2$" "$CSV_FILE") -lt 1 ]]; then
			if sudo pacman -S "$2"; then
				echo "$(date --rfc-3339 s),$2" >>"$CSV_FILE"
			fi
		else
			echo "Package '$2' is already installed."
			return
		fi
		;;
	"remove")
		if [[ $(grep -c "$2$" "$CSV_FILE") -ne 0 ]]; then
			if sudo pacman -Rs "$2"; then
				sed -i "/,$2$/d" "$CSV_FILE"
			fi
		else
			echo "Package '$2' is not installed."
			return
		fi
		;;
	esac
}
