# dux-de-venecia

- Propósito: SBC vintage.
- Hardware: [BeagleBone](https://www.beagleboard.org/boards/beaglebone-original)
  - TI Sitara AM3359 (Cortex-A8 720 MHz)
  - 256 MB DDR2 RAM
  - 32 GB microSDHC [SanDisk Ultra](https://www.sandisk.com/products/memory-cards/microsd-cards/sandisk-ultra-microsd)
  - Ethernet 100M
- OS: [Debian](https://www.debian.org) 12 (bookworm)
- Redes:
  - `SBC` 192.168.6.2
  - `RHED` tailnet

## Servicios

- SBC (single board computer) de colección.
- Nodo de la *hipermegaRHED*.
- Servidor web con phpSysInfo.

## Referencias

- [BeagleBone System Reference Manual](https://github.com/beagleboard/BeagleBone/blob/master/BeagleBone_SRM_A6_0_1.pdf)
- [Debian 12.x (Bookworm) - Monthly Snapshot - 2023-10-07](https://forum.beagleboard.org/t/debian-12-x-bookworm-monthly-snapshot-2023-10-07/36175)
- [phpSysInfo](https://phpsysinfo.github.io)
- [Red Hispana de Entusiastas Digitales](https://rhed.xyz)
- [Tailscale](https://tailscale.com)

## Archivos de configuración y scripts

Nada por ahora.

## Mantenimiento

- [ ] Revisar uso de disco: `df -h`
- [ ] Actualizar dotfiles (`root` y `manuel`): `git -C ~ pull`
- [ ] Actualizar paquetes: `apt update && apt upgrade`
- [ ] Reiniciar: `reboot`
- [ ] Verificar estado de Tailscale: `tailscale status`
- [ ] Verificar estado de NGINX: `systemctl status nginx`

## Pendientes

- [ ] Documentar servidor web
- [ ] *Web Shell Museo de SBCs*

## Bitácora

Nada por ahora.
