# Sync Google Drive
function gsync {
	local REMOTE="gdrive:"
	local LOCAL="$HOME/Google Drive"

	/usr/bin/rclone bisync "$REMOTE" "$LOCAL" \
		--progress \
		--drive-skip-dangling-shortcuts \
		--drive-skip-shortcuts \
		--drive-skip-gdocs
}

