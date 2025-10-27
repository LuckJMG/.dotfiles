# Power Mode Manager Installation

Script that automatically switches power profiles on Ubuntu based on charging status and battery level.

## Requirements

- Ubuntu with `power-profiles-daemon` installed
- Superuser permissions

## Installation

Replace `{dotfiles dir}` with your dotfiles dir.

1. Create the monitoring script
```bash
sudo cp {dotfiles dir}/lib/scripts/power-mode-manager/power-mode-manager.sh /usr/local/bin/power-mode-manager.sh
```

2. Create the systemd service
```bash
sudo cp {dotfiles dir}/lib/scripts/power-mode-manager/power-mode-manager.service /etc/systemd/system/power-mode-manager.service
```

3. Enable the service
```bash
sudo systemctl daemon-reload
sudo systemctl enable power-mode-manager.service
sudo systemctl start power-mode-manager.service
```

4. Verify it's working
```bash
sudo systemctl status power-mode-manager.service
```

## Notes

- The script checks status every 30 seconds
- If your battery is not BAT1, check with `ls /sys/class/power_supply/` and adjust the script
- Behavior:
  - **Charging**: Performance
  - **≤30% battery**: Power Saver
  - **>30% battery**: Balanced

## Uninstallation
```bash
sudo systemctl stop power-mode-manager.service
sudo systemctl disable power-mode-manager.service
sudo rm /etc/systemd/system/power-mode-manager.service
sudo rm /usr/local/bin/power-mode-manager.sh
sudo systemctl daemon-reload
```
