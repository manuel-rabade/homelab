# el-respiro

- Propósito: NAS.
- Hardware: [QNAP TS-253E](https://www.qnap.com/en/product/ts-253e)
  - Intel Celeron J6412 (quad-core 2.0 GHz)
  - 16 GB DDR4 RAM
  - 1 TB SSD NVMe [Kingston NV3](https://www.kingston.com/en/ssd/nv3-nvme-pcie-ssd)
  - 2 × 16 TB SATA RAID 1
    - [Toshiba N300](https://www.toshiba-storage.com/products/toshiba-n300-nas-hard-drive/)
    - [WD Gold](https://www.westerndigital.com/products/internal-drives/wd-gold-sata-hdd)
  - 16 TB USB 3.0 [Seagate Expansion Desktop](https://www.seagate.com/products/external-hard-drives/desktop-drives/expansion-desktop/)
  - 2 Ethernet 2.5G
- OS: [QTS](https://www.qnap.com/la/operating-system/qts) 5.2
- Redes:
  - `LAN` 192.168.1.3

## Servicios

- Servidor de archivos SMB para la red local.
- Servidor multimedia [Jellyfin](https://jellyfin.org), puerto `8096`.
- Respaldo automático de datos al disco externo.

## Referencias

- [Jellyfin](https://hub.docker.com/r/jellyfin/jellyfin): imagen oficial de Docker del servidor multimedia.
- [Hybrid Backup Sync](https://www.qnap.com/en/software/hybrid-backup-sync): la aplicación de QTS que hace los respaldos al disco externo.
- [Home Assistant REST API](https://developers.home-assistant.io/docs/api/rest/): API HTTP con la que el script de respaldo prende y apaga el enchufe del disco externo.

## Archivos de configuración y scripts

- [backup-usb](backup-usb): prende y apaga el disco externo por medio de Home Assistant, y vigila los trabajos de HBS que respaldan en él.
- `/etc/config/crontab`: programación de [backup-usb](backup-usb).
- `~/.ha-token`: token de acceso a Home Assistant.
- `~/backup-usb.log`: bitácora que deja el script de respaldo.

## Mantenimiento

- [ ] Revisar y limpiar notificaciones/alertas de la barra de tareas
- [ ] Revisar estado de sistema y volúmenes en `Almacenamiento e instantáneas`
  - [ ] Revisar salud, temperatura y atributos SMART de los discos en `Discos/VJBOD`
    - Vigilar `Reallocated_Sector_Ct`, `Current_Pending_Sector`, `Offline_Uncorrectable` y `UDMA_CRC_Error`; cualquiera `> 0` es señal temprana de falla.
- [ ] Revisar temperatura del sistema/CPU y velocidad del ventilador: `Panel de control → Estado del sistema`
- [ ] Validar últimas sincronizaciones: `HBS 3 → Trabajos → Informe`
- [ ] Verificar respaldos automáticos del sistema: `File Station → RAID → backups → el-respiro`
- [ ] Revisar el `Centro de seguridad` y ejecutar un `Security Checkup`
- [ ] Buscar actualizaciones de QTS: `Panel de control → Actualización de firmware`
- [ ] Buscar actualizaciones de Apps: `App Center → Actualizaciones`
- [ ] Verificar el contenedor de Jellyfin en `Container Station`

## Pendientes

- [ ] Programar pruebas SMART en cada disco: rápida semanal y completa mensual.
- [ ] Configurar reglas de alerta para eventos SMART, de temperatura y del ventilador.
- [ ] Configurar instantáneas.
- [ ] Actualizar Jellyfin.
- [ ] Automatizar el respaldo de las demás computadoras hacia el-respiro.

## Bitácora

### 2026-08-16 respaldo automático al disco externo

El disco externo está alimentado por un enchufe inteligente y permanece apagado entre respaldos. Quien copia los datos es HBS, con sus propios trabajos y su propia programación; [backup-usb](backup-usb) solo se encarga de la corriente y de mirar: prende el enchufe, espera el montaje, sigue en el registro de eventos cuándo arranca y cuándo termina cada trabajo, reporta lo que vio y, si todo salió bien, desmonta y apaga el disco. El proceso completo es:

1. Cron ejecuta `backup-usb` los jueves a las 2:00.
2. El script lee el token de Home Assistant, rota la bitácora de la corrida anterior y marca la hora de corte.
3. Llama al servicio `switch.turn_on` de la API de Home Assistant sobre el enchufe del disco.
4. Espera hasta 5 minutos a que el disco monte. Si no monta, avisa y sigue de todos modos.
5. A las 2:05 HBS arranca `Backup SSD` y `Backup RAID` por su propia programación.
6. El script lee el registro de eventos cada minuto y anota cada arranque y cada final conforme aparecen, con un límite de 4 horas para el lote completo.
7. Reporta tres cuentas: cuántos trabajos arrancaron, cuántos terminaron bien y cuántos terminaron con errores.
8. Si todos terminaron bien desmonta el disco y llama a `switch.turn_off`. Cualquier otro desenlace lo deja montado y encendido para revisarlo a mano.

Las llamadas a Home Assistant van autenticadas con un token de acceso de larga duración que el script lee de `~/.ha-token`. Antes de leerlo verifica que el archivo tenga permisos `600` y cancela si están más abiertos. Cada paso manda una notificación con `notify`, la utilería de Notification Center, y todo queda además registrado en `~/backup-usb.log`.

#### ¿Por qué el script no lanza los trabajos?

La API de HBS vive en `/cc3/v1/` y exige un encabezado `X-QNAP-SID` que solo entrega `authLogin.cgi` después de un login real, así que un script desatendido tendría que guardar la contraseña de una cuenta de admin para pedir un SID que además caduca. Me pareció más sencillo programar `backup-usb` unos minutos antes que los trabajos de HBS y vigilar el registro de eventos para saber cuándo apagar el disco.

La otra alternativa sin autenticación es `hbs3-rr3c`, el motor de copia de HBS derivado de rclone: `hbssync origen destino` no pide credenciales y devuelve código de salida en vez de exigir sondeo, pero no usa las definiciones de trabajos ni deja registro en sus informes, que es justo lo que se revisa en el mantenimiento.

#### Programación periódica

La entrada de cron quedó puesta con:

```bash
echo "0 2 * * 4 /share/homes/manuel/backup-usb" >> /etc/config/crontab
crontab /etc/config/crontab && /etc/init.d/crond.sh restart
```

Las actualizaciones de QTS suelen borrar esa entrada, así que conviene revisar `crontab -l` después de cada una. El entorno de cron se prueba con `env -i PATH=/usr/bin:/bin /bin/bash`, más pobre que el real: si el `PATH` y el `USER_HOME` que fija el script bastan ahí, bastan en cron.

#### Notas de QTS

Todo esto es sobre la parte de `notify` de `backup-usb`, o sea la función `notify_send` y las variables `NOTIFY_*` que la alimentan. Es lo que costó trabajo averiguar y no se ve leyendo el script:

- `NOTIFY_KEY` pasado por `-M` no es un identificador del mensaje, es una llave que `notify` busca en el catálogo de la app que se pasa en `-A`. Si la encuentra imprime la plantilla de QNAP y tira el texto del script, así que la llave tiene que no existir: `backup-usb` sirve porque las llaves de `A200` son todas numéricas o `Vnnn`.
- `-A` tiene que ser una app registrada: un ID inventado devuelve código 12 y no manda nada. `-C` no se valida y una categoría inventada devuelve 0, pero el evento sale sin categoría. Se usa `A200` (Hybrid Backup Sync) con `C006` (System).
- Los avisos no salen por correo solos. Hay que crear una regla en Notification Center que empate con el `NOTIFY_PREFIX` en los tres niveles (`info`, `warning` y `error`), porque la regla general de la NAS arranca en `warning` y tira todo el `info`.
- `notify` siempre termina en 0, aunque el evento no empate con ninguna regla y nunca salga de la NAS. El veredicto está en `/var/log/nc.log` (`1 policies matched` contra `not match any policy`) y el resultado del envío en `/mnt/ext/opt/NotificationCenter/qanalytics/analytic.log`.
- QTS guarda los registros en dos lugares: `notify` escribe en la base MariaDB de QuLog Center (`qulogdb`) y `log_tool` en el SQLite `/mnt/HDA_ROOT/.logs/event.log`. QuLog Center muestra los dos, así que buscar en el archivo equivocado hace creer que la herramienta no sirve.
