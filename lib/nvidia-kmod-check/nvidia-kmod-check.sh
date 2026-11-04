#!/usr/bin/bash
# Ejecutar después de "dnf upgrade" y ANTES de reiniciar.
# Para cada kernel instalado, comprueba que el módulo nvidia tiene la misma
# versión que el userspace (xorg-x11-drv-nvidia-580xx). Si no coincide,
# lo recompila con akmods. Así no arranca un kernel con "NVRM: API mismatch".
#
#   nvidia-kmod-check          revisa y repara
#   nvidia-kmod-check --check  solo revisa (sale con 1 si hay un problema)
set -u
check_only=0; [ "${1:-}" = --check ] && check_only=1
[ $check_only = 1 ] || [ "$EUID" = 0 ] || exec sudo "$0" "$@"

want=$(rpm -q --qf '%{VERSION}' xorg-x11-drv-nvidia-580xx) || exit 1
echo "userspace nvidia: $want"
bad=0

for k in $(rpm -q --qf '%{VERSION}-%{RELEASE}.%{ARCH}\n' kernel-core); do
    have=$(modinfo -k "$k" -F version nvidia 2>/dev/null)
    if [ "$have" != "$want" ] && [ $check_only = 0 ]; then
        echo "$k: módulo ${have:-ausente}, recompilando $want..."
        # Si rpm ya registra la versión correcta pero los archivos son viejos
        # (instalación cortada por un reinicio forzado), dnf no reinstala.
        # Hay que borrar todas las versiones registradas antes de compilar.
        if rpm -q "kmod-nvidia-580xx-$k-$want" >/dev/null; then
            rpm -e --allmatches "kmod-nvidia-580xx-$k"
        fi
        akmods --force --kernels "$k"
        have=$(modinfo -k "$k" -F version nvidia 2>/dev/null)
    fi
    [ -s "/boot/initramfs-$k.img" ] || { echo "$k: FALTA /boot/initramfs-$k.img"; bad=1; }
    if [ "$have" = "$want" ]; then
        echo "$k: OK ($have)"
    else
        echo "$k: MAL (módulo ${have:-ausente}, userspace $want)"; bad=1
    fi
done

[ $bad = 0 ] && echo "Listo: se puede reiniciar." || echo "Hay problemas: no reinicies todavía."
exit $bad
