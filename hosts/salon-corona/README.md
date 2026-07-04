# salon-corona

- Propósito: Router y AP.
- Hardware: [GL.iNet GL-MT6000](https://www.gl-inet.com/products/gl-mt6000/)
  - MediaTek MT7986A (Filogic 830, Cortex-A53 quad-core 2.0 GHz)
  - 1 GB DDR4 RAM
  - 8 GB NAND Flash
  - 2 puertos Ethernet 2.5G (Internet y disponible)
  - 4 puertos Ethernet 1G (`LAN`)
  - Wi-Fi 802.11ac/ax/n (`LAN`, `GUEST` y `MEDIA`)
  - Wi-Fi 802.11ax/b/g/n (`LAN` y `IOT`)
- OS: [OpenWrt](https://openwrt.org) 24
- Redes:
  - `LAN` 192.168.1.1
  - `GUEST` 192.168.2.1
  - `IOT` 192.168.3.1
  - `MEDIA` 192.168.4.1

## Servicios

- Router principal y punto de acceso inalámbrico.
- Aplica segmentación, enrutamiento y políticas de firewall entre las zonas de red.

## Referencias

- [[OpenWrt Wiki] GL.iNet GL-MT6000](https://openwrt.org/toh/gl.inet/gl-mt6000)

## Archivos de configuración y scripts

- Ruta estática a `192.168.6.0/24` por medio de [savoy](../savoy/).

## Mantenimiento

- [ ] Revisar estado del router en `Status → Overview`
- [ ] Revisar logs del sistema: `logread -e error`
- [ ] Hacer backup del sistema
  - [ ] Guardar configuración: `sysupgrade -b /tmp/backup-config-salon-corona.tar.gz`
  - [ ] Guardar lista de paquetes: `opkg list-installed > /tmp/backup-opkg-salon-corona.txt`
  - [ ] Descargar respaldos: `scp -O root@salon-corona:/tmp/backup-*-salon-corona.* ~`
- [ ] Buscar actualizaciones: `owut check`
- [ ] Aplicar actualización: `owut upgrade`
- [ ] Buscar actualizaciones mayores: `owut versions`
- [ ] Revisar canales y congestión Wi-Fi en `Network → Wireless`
- [ ] Revisar reglas de firewall y redirecciones de puertos en `Network → Firewall`

## Pendientes

- [ ] Actualizar a OpenWrt 25
```bash
https://firmware-selector.openwrt.org/?target=mediatek%2Ffilogic&id=glinet_gl-mt6000

# owut check --version-to 25.12.4 --verbose
# owut upgrade --version-to 25.12.4
```

## Bitácora

Nada por ahora.
