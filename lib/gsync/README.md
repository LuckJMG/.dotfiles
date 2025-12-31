# Google Drive Sync Scripts

Automatic bidirectional synchronization between Google Drive and local storage using rclone bisync.

## Features

- Bidirectional sync on login
- Automatic sync before shutdown
- Skips Google Docs native files (Docs, Sheets, Slides)
- Skips shortcuts and dangling shortcuts
- Detailed logging

## Prerequisites

- `rclone` installed and configured with a remote named `gdrive:`
- Google Drive folder at `$HOME/Google Drive`

## Installation

1. **Copy systemd services to user directory:**
```bash
   cp ~/.dotfiles/lib/scripts/gsync/gsync-login.service ~/.config/systemd/user/
   cp ~/.dotfiles/lib/scripts/gsync/gsync-shutdown.service ~/.config/systemd/user/
```

2. **Reload systemd and enable services:**
```bash
   systemctl --user daemon-reload
   systemctl --user enable gsync-login.service
   systemctl --user enable gsync-shutdown.service
```

4. **Initial sync (required before using bisync):**
```bash
   rclone bisync gdrive: "$HOME/Google Drive" \
     --drive-skip-dangling-shortcuts \
     --drive-skip-shortcuts \
     --drive-skip-gdocs \
     --resync
```

## Manual Usage

Run the sync script manually:
```bash
~/.dotfiles/lib/scripts/gsync/gsync.sh
```

Or create an alias in your shell config (`~/.bashrc` or `~/.zshrc`):
```bash
alias gsync="$HOME/.dotfiles/lib/scripts/gsync/gsync.sh"
```

Then simply run:
```bash
gsync
```

## Service Management

**Check service status:**
```bash
systemctl --user status gsync-login.service
systemctl --user status gsync-shutdown.service
```

**View logs:**
```bash
journalctl --user -u gsync-login.service
journalctl --user -u gsync-shutdown.service
```

**Manually trigger sync:**
```bash
systemctl --user start gsync-login.service
```

**Disable services:**
```bash
systemctl --user disable gsync-login.service
systemctl --user disable gsync-shutdown.service
```

## Configuration

### Script Location
- Script: `~/.dotfiles/lib/scripts/gsync/gsync.sh`
- Services: `~/.config/systemd/user/`

### Logs
- rclone log: `~/.config/rclone/rclone.log`
- systemd logs: Use `journalctl --user -u gsync-*.service`

### Customization

Edit `gsync.sh` to modify:
- Remote name (default: `gdrive:`)
- Local directory (default: `$HOME/Google Drive`)
- rclone flags and options

## Troubleshooting

**"cannot find prior Path1 or Path2 listings" error:**
```bash
rclone bisync gdrive: "$HOME/Google Drive" \
  --drive-skip-dangling-shortcuts \
  --drive-skip-shortcuts \
  --drive-skip-gdocs \
  --resync
```

**Service not starting:**
```bash
systemctl --user daemon-reload
journalctl --user -u gsync-login.service -n 50
```

**Check if rclone is configured:**
```bash
rclone listremotes
```

Should show `gdrive:` in the list.

## Notes

- Bisync is an **EXPERIMENTAL** rclone feature
- Google Docs native files are skipped (only real files are synced)
- Shutdown sync has 180-second timeout
- Progress bar only shows in interactive terminal sessions

