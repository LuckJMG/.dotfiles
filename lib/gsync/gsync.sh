#!/usr/bin/sh
set -e

REMOTE="gdrive:"
LOCAL="$HOME/Google Drive"
PROGRESS=""

if [ ! -d "$LOCAL" ]; then
	echo "[ERROR] directory does not exist: $LOCAL"
	exit 1
fi

if [ -t 1 ]; then
	PROGRESS="--progress"
fi

/usr/bin/rclone bisync "$REMOTE" "$LOCAL" \
	$PROGRESS \
	--drive-skip-dangling-shortcuts \
	--drive-skip-shortcuts \
	--drive-skip-gdocs \
    --log-file "$HOME/.config/rclone/rclone.log" \
    --log-level INFO

echo "[INFO] google drive synced successfully"

