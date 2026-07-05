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

- [ ] Revisar estado del router: `Status → Overview`
- [ ] Revisar logs del sistema: `logread -e error`
- [ ] Hacer backup del sistema
  - [ ] Guardar configuración: `sysupgrade -b /tmp/backup-config-salon-corona.tar.gz`
  - [ ] Guardar lista de paquetes: `opkg list-installed > /tmp/backup-opkg-salon-corona.txt`
  - [ ] Descargar respaldos: `scp -O root@salon-corona:/tmp/backup-*-salon-corona.* ~`
- [ ] Buscar actualizaciones: `owut check`
- [ ] Aplicar actualización: `owut upgrade`
- [ ] Buscar actualizaciones mayores: `owut versions`
- [ ] Revisar canales y congestión Wi-Fi: `Network → Wireless`
- [ ] Revisar reglas de firewall y redirecciones de puertos: `Network → Firewall`

## la-esperanza

- [ ] Revisar uso de disco: `df -h -t ext4`
- [ ] Actualizar dotfiles (`root` y usuario): `git pull`
- [ ] Actualizar paquetes: `apt update && apt upgrade`
- [ ] Reiniciar: `reboot`
- [ ] Verificar go-librespot: `systemctl --user status go-librespot`

## el-respiro

- [ ] Revisar y limpiar notificaciones/alertas de la barra de tareas
- [ ] Revisar estado de sistema y volúmenes en `Almacenamiento e instantáneas`
  - [ ] Revisar salud, temperatura y atributos SMART de los discos en `Discos/VJBOD`
    - Vigilar `Reallocated_Sector_Ct`, `Current_Pending_Sector`, `Offline_Uncorrectable` y `UDMA_CRC_Error`; cualquiera `> 0` es señal temprana de falla.
- [ ] Revisar temperatura del sistema/CPU y velocidad del ventilador: `Panel de control → Estado del sistema`
- [ ] Sincronizar al disco externo: `HBS 3 → Sincronizar`
- [ ] Verificar respaldos automáticos del sistema: `File Station → RAID → backups → el-respiro`
- [ ] Revisar el `Centro de seguridad` y ejecutar un `Security Checkup`
- [ ] Buscar actualizaciones de QTS: `Panel de control → Actualización de firmware`
- [ ] Buscar actualizaciones de Apps: `App Center → Actualizaciones`
- [ ] Verificar el contenedor de Jellyfin en `Container Station`

## barba-azul

- [ ] Revisar y limpiar notificaciones del menú principal
- [ ] Revisar `Reparaciones` y `Registros` en `Configuración → Sistema`
- [ ] Revisar uso de disco: `Configuración → Sistema → Almacenamiento`
- [ ] Verificar copias de seguridad automáticas: `Configuración → Sistema → Copias de seguridad`
- [ ] Aplicar actualizaciones de Core, OS, Supervisor y Aplicaciones: `Configuración → Sistema → Actualizaciones`
- [ ] Revisar dispositivos no disponibles: `Configuración → Dispositivos y servicios → Entidades` y filtrar por `Estado = No disponible`

## savoy

- [ ] Revisar uso de disco: `df -h -t ext4`
- [ ] Actualizar dotfiles (`root` y usuario): `git pull`
- [ ] Actualizar paquetes: `apt update && apt upgrade`
- [ ] Reiniciar: `reboot`
- [ ] Verificar conectividad hacia la red `SBC`: `ping -c 3 192.168.6.2`
- [ ] Verificar estado de Tailscale: `tailscale status`

## dux-de-venecia

- [ ] Revisar uso de disco: `df -h`
- [ ] Actualizar dotfiles (`root` y usuario): `git pull`
- [ ] Actualizar paquetes: `apt update && apt upgrade`
- [ ] Reiniciar: `reboot`
- [ ] Verificar estado de Tailscale: `tailscale status`
- [ ] Verificar estado de NGINX: `systemctl status nginx`
