# la-faena

- Propósito: Hipervisor DMZ.
- Hardware: [KAMRUI E3B](https://store.kamrui.com/products/e3b-mini-pc)
  - AMD Ryzen 7 7730U (Zen 3 8C/16T, hasta 4.5 GHz)
  - AMD Radeon Graphics (Vega, 8 CU)
  - 16 GB DDR4 RAM (2 × 8 GB)
  - 512 GB SSD SATA M.2 Superheer
  - Ethernet 1G
  - Wi-Fi 802.11ax
- OS: [Proxmox VE](https://www.proxmox.com/en/products/proxmox-virtual-environment/overview) 9.2 (trixie)
- Redes:
  - `GUEST` 192.168.2.3
  - `VPS` 192.168.7.1

## Servicios

- Hipervisor para máquinas virtuales y contenedores LXC en la DMZ conectado a `GUEST` por Wi-Fi.
- Gateway de `VPS`, la red interna de los huéspedes.

## Referencias

- [Proxmox VE](https://pve.proxmox.com/pve-docs/): documentación oficial.

## Archivos de configuración y scripts

- `/etc/network/interfaces`: Wi-Fi `nic1` con IP fija y las credenciales de la red, bridge interno `vmbr0` sin puertos físicos y Ethernet `nic0` sin dirección.
- `/usr/local/lib/systemd/network/50-pmx-nic1.link`: fija el nombre `nic1` de la tarjeta Wi-Fi. Lo genera Proxmox con `Type=ether` y está cambiado a mano a `Type=wlan`.
- `/etc/sysctl.d/10-forward.conf`: activa el reenvío de paquetes IPv4 entre `vmbr0` y `nic1`.

## Mantenimiento

- [ ] Revisar uso de disco: `df -h -t ext4`
- [ ] Revisar el enlace Wi-Fi: `iw dev nic1 link`
- [ ] Actualizar paquetes: `apt update && apt full-upgrade`
- [ ] Reiniciar: `reboot`

## Pendientes

- [ ] Configurar la ruta hacia `VPS`
- [ ] Desactivar el ahorro de energía del Wi-Fi
- [ ] Definir las reglas de firewall
- [ ] Instalar el servidor Matrix de la *hipermegaRHED*

## Bitácora

### 2026-10-04 Instalación de la-faena

Segundo hipervisor Proxmox VE, este en la DMZ y conectado solo por Wi-Fi. Una interfaz Wi-Fi en modo cliente no puede ser puerto de un bridge, así que el `vmbr0` del instalador no sirve: el equipo sale por la tarjeta Wi-Fi con IP fija 192.168.2.3 y los huéspedes viven en una red interna ruteada, 192.168.7.0/24, con direcciones fijas. Falta la ruta hacia esa red, así que por ahora los huéspedes no tienen salida.

#### Red temporal por Ethernet

Tras instalar Proxmox VE se comentó el bloque de `vmbr0` en `/etc/network/interfaces` y se agregó el puerto Ethernet por DHCP, solo para tener internet durante la configuración:

```text
auto nic0
iface nic0 inet dhcp
```

```bash
ifreload -a
```

#### Wi-Fi

Con internet se instalaron las herramientas de Wi-Fi y se comprobó que la tarjeta ve la red:

```bash
apt install wpasupplicant iw
iw dev wlp1s0 scan
```

La tarjeta seguía llamándose `wlp1s0` porque `/usr/local/lib/systemd/network/50-pmx-nic1.link`, el archivo con el que Proxmox fija los nombres de las interfaces, la busca como `Type=ether`. Se cambió a `Type=wlan` y tras un `reboot` quedó como `nic1`. Ya con ese nombre se configuró en `/etc/network/interfaces` con IP fija y las credenciales de la red.

#### Red interna de los huéspedes

`vmbr0` se volvió a declarar, ahora sin puertos físicos y como gateway de 192.168.7.0/24, y se activó el reenvío de paquetes, que se aplica en el siguiente arranque:

```bash
echo "net.ipv4.ip_forward=1" > /etc/sysctl.d/10-forward.conf
```

#### Resultado

`/etc/network/interfaces` quedó así, con el Ethernet sin dirección y su bloque DHCP comentado por si hace falta de rescate:

```text
auto lo
iface lo inet loopback

#auto nic0
#iface nic0 inet dhcp
iface nic0 inet manual

auto nic1
iface nic1 inet static
    address 192.168.2.3/24
    gateway 192.168.2.1
    wpa-ssid <SSID>
    wpa-psk <clave>

auto vmbr0
iface vmbr0 inet static
    address 192.168.7.1/24
    bridge-ports none
    bridge-stp off
    bridge-fd 0

source /etc/network/interfaces.d/*
```

La prueba final fue reiniciar sin el cable Ethernet: el equipo subió solo por Wi-Fi y todo funcionó.
