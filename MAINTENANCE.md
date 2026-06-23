# Mantenimiento

Checklist de servicio para mi infraestructura casera, ver [`README.md`](README.md).

## salon-corona

- [ ] Revisar logs del sistema: `logread -e error`
- [ ] Buscar actualizaciones: `owut check`
  - [ ] Respaldar configuración: `sysupgrade -b /tmp/backup-config-salon-corona.tar.gz`
  - [ ] Respaldar paquetes instalados: `opkg list-installed > /tmp/backup-opkg-salon-corona.txt`
  - [ ] Descargar respaldos: `scp -O root@salon-corona:/tmp/backup-*-salon-corona.* ~`
- [ ] Buscar actualizaciones mayores: `owut versions`

**Pendiente**

- [ ] Actualizar a OpenWrt 25
```
https://firmware-selector.openwrt.org/?target=mediatek%2Ffilogic&id=glinet_gl-mt6000

# owut check --version-to 25.12.4 --verbose
# owut upgrade --version-to 25.12.4
```

## la-esperanza

- [ ] Revisar uso de disco: `df -h -t ext4`
- [ ] Actualizar dotfiles: `git pull`
- [ ] Actualizar paquetes: `apt update && apt upgrade`
- [ ] Reiniciar: `reboot`
- [ ] Verificar Raspotify: `systemctl status raspotify`
