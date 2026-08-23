# covadonga

- Propósito: Laboratorio LLMs.
- Hardware: [Minisforum UM890 Pro](https://www.minisforum.com/products/minisforum-um890-pro)
  - AMD Ryzen 9 8945HS (Zen 4 8C/16T, hasta 5.2 GHz)
  - AMD Radeon 780M (RDNA 3, 12 CU)
  - 64 GB DDR5 RAM (2 × 32 GB)
  - 1 TB SSD NVMe [Kingston NV3](https://www.kingston.com/en/ssd/nv3-nvme-pcie-ssd)
  - 2 Ethernet 2.5G
  - Wi-Fi 802.11ax
  - OCuLink PCIe 4.0 x4 disponible para eGPU
- OS: [Ubuntu Server](https://ubuntu.com/server) 26.04 LTS (resolute)
- Redes:
  - `LAN` 192.168.1.5

## Servicios

Nada por ahora.

## Referencias

- [Ubuntu Server](https://documentation.ubuntu.com/server/): documentación oficial.
- [ROCm](https://rocm.docs.amd.com): stack de cómputo de AMD para aprovechar la Radeon 780M.

## Archivos de configuración y scripts

Nada por ahora.

## Mantenimiento

- [ ] Revisar uso de disco: `df -h -t ext4`
- [ ] Actualizar dotfiles (`root` y `manuel`): `git -C ~ pull`
- [ ] Actualizar paquetes: `apt update && apt upgrade`
- [ ] Reiniciar: `reboot`

## Pendientes

- [ ] Instalar el stack de inferencia para correr LLMs locales
- [ ] Evaluar una eGPU por el puerto OCuLink

## Bitácora

### 2026-08-22 Instalación de covadonga

Nuevo mini PC dedicado a experimentar con LLMs locales. Se instaló Ubuntu Server 26.04 LTS con IP fija 192.168.1.5.
