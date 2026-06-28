# savoy

- Propósito: Laboratorio DMZ.
- Hardware: [Raspberry Pi 4B](https://www.raspberrypi.com/products/raspberry-pi-4-model-b/)
- OS: [Armbian](https://armbian.com) 26 (trixie)
- Redes:
  - `GUEST` 192.168.2.2
  - `SBC` 192.168.6.1
  - `RHED` Tailscale

## Servicios

- Nodo de la RHED.
- Router de la red `SBC`.

## Referencias

Nada por ahora.

## Archivos de configuración y scripts

- `/etc/sysctl.d/10-ip_forward.conf`: IP forwarding.
- `/etc/netplan/30-wifi-static.yaml` y `/etc/netplan/40-eth-static.yaml`: IPs estáticas por netplan.

## Mantenimiento

Nada por ahora.

## Pendientes

Nada por ahora.

## Bitácora

Nada por ahora.
