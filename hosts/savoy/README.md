# savoy

- Propósito: Laboratorio DMZ.
- Hardware: [Raspberry Pi 4B](https://www.raspberrypi.com/products/raspberry-pi-4-model-b/)
  - Broadcom BCM2711 (Cortex-A72 quad-core 1.8 GHz)
  - 4 GB LPDDR4 RAM
  - 64 GB microSDXC [ADATA High Endurance](https://www.adata.com/us/consumer/614/)
  - Ethernet 1G
  - Wi-Fi 802.11ac
- OS: [Armbian](https://armbian.com) 26 (trixie)
- Redes:
  - `GUEST` 192.168.2.2
  - `SBC` 192.168.6.1
  - `RHED` tailnet

## Servicios

- Nodo de la *hipermegaRHED*.
- Router de la red `SBC`.

## Referencias

- [Red Hispana de Entusiastas Digitales](https://rhed.xyz)
- [Kernel Panic Room](https://kernelpanic.lol), hackerspace en Querétaro
- [WireGuard](https://www.wireguard.com)
- [Tailscale](https://tailscale.com)
- [Headscale](https://headscale.net)

## Archivos de configuración y scripts

- `/etc/sysctl.d/10-ip_forward.conf`: IP forwarding.
- `/etc/netplan/30-wifi-static.yaml`: IP estática de `GUEST` por netplan.
- `/etc/netplan/40-eth-static.yaml`: IP estática de `SBC` por netplan.

## Mantenimiento

- [ ] Revisar uso de disco: `df -h -t ext4`
- [ ] Actualizar dotfiles (`root` y `manuel`): `git -C ~ pull`
- [ ] Actualizar paquetes: `apt update && apt upgrade`
- [ ] Reiniciar: `reboot`
- [ ] Verificar conectividad hacia la red `SBC`: `ping -c 3 192.168.6.2`
- [ ] Verificar estado de Tailscale: `tailscale status`

## Pendientes

- [ ] NGINX con phpSysInfo
- [ ] Proxy TinyGS
- [ ] Rutear entre red `SBC` e *hipermegaRHED*
- [ ] *Museo de SBCs*
- [ ] *Disco duro hipermegaRHED*
- [ ] *MQTT hipermegaRHED*

## Bitácora

### 2026-07-04 Conexión a la *hipermegaRHED*

La *hipermegaRHED* es la red de la Red Hispana de Entusiastas Digitales, una red privada para conectar equipos, servicios y experimentos. Técnicamente, es una red mesh basada en WireGuard que usa los clientes de Tailscale y un servidor Headscale hospedado por el KPR para coordinar los nodos.

Agregar la llave de firma y el repositorio de Tailscale:

```bash
curl -fsSL https://pkgs.tailscale.com/stable/debian/trixie.noarmor.gpg | tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null
curl -fsSL https://pkgs.tailscale.com/stable/debian/trixie.tailscale-keyring.list | tee /etc/apt/sources.list.d/tailscale.list
```

Instalar Tailscale: `apt update && apt install tailscale`.

Dar de alta el nodo apuntando al servidor Headscale de la *hipermegaRHED*: `tailscale up --login-server https://hipermega.rhed.xyz`.

El comando imprime una URL de registro, visitarla y pasar la solicitud a un administrador de la *hipermegaRHED* para que autorice el nodo en el servidor Headscale.

Verificar el estado de la conexión: `tailscale status`.
