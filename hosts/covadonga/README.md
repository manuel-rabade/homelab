# covadonga

- Propósito: Hipervisor LAN.
- Hardware: [Minisforum UM890 Pro](https://www.minisforum.com/products/minisforum-um890-pro)
  - AMD Ryzen 9 8945HS (Zen 4 8C/16T, hasta 5.2 GHz)
  - AMD Radeon 780M (RDNA 3, 12 CU)
  - 64 GB DDR5 RAM (2 × 32 GB)
  - 1 TB SSD NVMe [Kingston NV3](https://www.kingston.com/en/ssd/nv3-nvme-pcie-ssd)
  - 2 Ethernet 2.5G
  - Wi-Fi 802.11ax
  - OCuLink PCIe 4.0 x4 disponible para eGPU
- OS: [Proxmox VE](https://www.proxmox.com/en/products/proxmox-virtual-environment/overview) 9.2 (trixie)
- Redes:
  - `LAN` 192.168.1.5

## Servicios

- Hipervisor para contenedores LXC y máquinas virtuales dentro de la `LAN`, pensado sobre todo para cargas de IA y LLMs locales.

## Referencias

- [Proxmox VE](https://pve.proxmox.com/pve-docs/): documentación oficial.
- [ROCm](https://rocm.docs.amd.com): stack de cómputo de AMD para aprovechar la Radeon 780M.

## Archivos de configuración y scripts

Nada por ahora.

## Mantenimiento

- [ ] Revisar uso de disco: `df -h -t ext4`
- [ ] Actualizar dotfiles (`root` y `manuel`): `git -C ~ pull`
- [ ] Actualizar paquetes: `apt update && apt full-upgrade`
- [ ] Reiniciar: `reboot`

## Pendientes

- [ ] Crear los contenedores LXC con el stack de inferencia para correr LLMs locales
- [ ] Mover la IP 192.168.1.5 a `nic0` y dejar `vmbr0` como bridge interno de `VMS` (192.168.5.1)
- [ ] Configurar la ruta hacia `VMS`
- [ ] Evaluar una eGPU por el puerto OCuLink

## Bitácora

### 2026-10-03 Migración a Proxmox VE

Se reemplazó Ubuntu Server por Proxmox VE 9.2 para que el equipo hospede contenedores LXC y máquinas virtuales en vez de correr todo sobre el sistema base. El disco quedó en ext4 sobre LVM con LVM-thin para los huéspedes, en lugar de ZFS: con un solo NVMe no hay redundancia que aprovechar y la RAM se reserva para los modelos.

### 2026-08-22 Instalación de covadonga

Nuevo mini PC dedicado a experimentar con LLMs locales. Se instaló Ubuntu Server 26.04 LTS con IP fija 192.168.1.5.
