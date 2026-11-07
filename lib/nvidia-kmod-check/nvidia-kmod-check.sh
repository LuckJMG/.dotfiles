#!/usr/bin/bash
# Run after "dnf upgrade" and BEFORE you reboot.
# For each installed kernel, make sure that the nvidia module has the same
# version as the userspace (xorg-x11-drv-nvidia-580xx). If the versions differ,
# rebuild the module with akmods. Then no kernel boots with "NVRM: API mismatch".
#
#   nvidia-kmod-check          check and repair
#   nvidia-kmod-check --check  check only (exit code 1 if a problem exists)
set -u
check_only=0; [ "${1:-}" = --check ] && check_only=1
[ $check_only = 1 ] || [ "$EUID" = 0 ] || exec sudo "$0" "$@"

want=$(rpm -q --qf '%{VERSION}' xorg-x11-drv-nvidia-580xx) || exit 1
echo "nvidia userspace: $want"
bad=0

for k in $(rpm -q --qf '%{VERSION}-%{RELEASE}.%{ARCH}\n' kernel-core); do
    have=$(modinfo -k "$k" -F version nvidia 2>/dev/null)
    if [ "$have" != "$want" ] && [ $check_only = 0 ]; then
        echo "$k: module ${have:-missing}, rebuilding $want..."
        # If rpm already records the correct version but the files are old
        # (an install cut short by a forced reboot), dnf does not reinstall.
        # Remove all recorded versions before the build.
        if rpm -q "kmod-nvidia-580xx-$k-$want" >/dev/null; then
            rpm -e --allmatches "kmod-nvidia-580xx-$k"
        fi
        akmods --force --kernels "$k"
        have=$(modinfo -k "$k" -F version nvidia 2>/dev/null)
    fi
    [ -s "/boot/initramfs-$k.img" ] || { echo "$k: MISSING /boot/initramfs-$k.img"; bad=1; }
    if [ "$have" = "$want" ]; then
        echo "$k: OK ($have)"
    else
        echo "$k: BAD (module ${have:-missing}, userspace $want)"; bad=1
    fi
done

[ $bad = 0 ] && echo "Done: you can reboot." || echo "Problems found: do not reboot yet."
exit $bad
