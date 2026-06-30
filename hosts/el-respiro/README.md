# el-respiro

- Propósito: NAS.
- Hardware: [QNAP TS-253E](https://www.qnap.com/en/product/ts-253e)
  - 16 GB DDR4
  - 1 TB SSD NVMe (disco de sistema)
    - [Kingston NV3](https://www.kingston.com/en/ssd/nv3-nvme-pcie-ssd)
  - 2 × 16 TB SATA RAID 1 (almacenamiento principal)
    - [Toshiba N300](https://www.toshiba-storage.com/products/toshiba-n300-nas-hard-drive/)
    - [WD Gold](https://www.westerndigital.com/products/internal-drives/wd-gold-sata-hdd)
  - 16 TB USB 3.0 (respaldo general)
    - [Seagate Expansion Desktop](https://www.seagate.com/products/external-hard-drives/desktop-drives/expansion-desktop/)
- OS: [QTS](https://www.qnap.com/la/operating-system/qts) 5.2
- Redes:
  - `LAN` 192.168.1.3

## Servicios

- Servidor de archivos SMB para la red local.
- Servidor multimedia [Jellyfin](https://jellyfin.org), puerto `8096`.
- Sincronización periódica de datos al disco externo.

## Referencias

- [Jellyfin](https://hub.docker.com/r/jellyfin/jellyfin)

## Archivos de configuración y scripts

Nada por ahora.

## Mantenimiento

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

## Pendientes

- [ ] Configurar la sincronización automática al disco externo.
  - Reemplazar en Mantenimiento "Sincronizar al disco externo" por "Validar últimas sincronizaciones: `HBS 3 → Trabajos → Informe`".
- [ ] Programar pruebas SMART en cada disco: rápida semanal y completa mensual.
- [ ] Configurar reglas de alerta para eventos SMART, de temperatura y del ventilador.
- [ ] Configurar instantáneas.
- [ ] Actualizar Jellyfin.

## Bitácora

Nada por ahora.
