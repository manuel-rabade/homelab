```
                 _       _
                (_)     | |
 _ __ ___   __ _ _ _ __ | |_ ___ _ __   __ _ _ __   ___ ___
| '_ ` _ \ / _` | | '_ \| __/ _ \ '_ \ / _` | '_ \ / __/ _ \
| | | | | | (_| | | | | | ||  __/ | | | (_| | | | | (_|  __/
|_| |_| |_|\__,_|_|_| |_|\__\___|_| |_|\__,_|_| |_|\___\___|
```

Checklist de mantenimiento para mi infraestructura casera.

## salon-corona

- [ ] Revisar logs del sistema: `logread -e error`
- [ ] Buscar actualizaciones: `owut check`
  - [ ] Respaldar configuración: `sysupgrade -b /tmp/backup-config-salon-corona.tar.gz`
  - [ ] Respaldar paquetes instalados: `opkg list-installed > /tmp/backup-opkg-salon-corona.txt`
  - [ ] Descargar respaldos: `scp -O root@salon-corona:/tmp/backup-*-salon-corona.* ~`
- [ ] Buscar actualizaciones mayores: `owut versions`

## la-esperanza

- [ ] Revisar uso de disco: `df -h -t ext4`
- [ ] Actualizar dotfiles: `git pull`
- [ ] Actualizar paquetes: `apt update && apt upgrade`
- [ ] Reiniciar: `reboot`
- [ ] Verificar Raspotify: `systemctl status raspotify`

## el-respiro

Nada por ahora.

## barba-azul

Nada por ahora.

## savoy

Nada por ahora.

## dux-de-venecia

Nada por ahora.
