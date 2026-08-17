# barba-azul

- Propósito: Hub IoT.
- Hardware: [Raspberry Pi 5](https://www.raspberrypi.com/products/raspberry-pi-5/)
  - Broadcom BCM2712 (Cortex-A76 quad-core 2.4 GHz)
  - 8 GB LPDDR4X RAM
  - 128 GB microSDXC [Samsung PRO Endurance](https://www.samsung.com/us/computing/memory-storage/memory-cards/pro-endurance-adapter-microsdxc-128gb-mb-mj128ka-am/)
  - Ethernet 1G
  - Wi-Fi 802.11ac
- OS: [Home Assistant OS](https://www.home-assistant.io) 18
- Redes:
  - `LAN` 192.168.1.4
  - `IOT` 192.168.3.3

## Servicios

- Plataforma de automatización del hogar.
- Integra y controla dispositivos IoT.
- Servidor API para que otros equipos operen dispositivos IoT.
  - [el-respiro](../el-respiro/): enciende y apaga el enchufe de su disco externo con [backup-usb](../el-respiro/backup-usb).

## Referencias

- [HACS](https://hacs.xyz): tienda de integraciones y complementos de la comunidad de Home Assistant.
- [hassio-ecoflow-cloud](https://github.com/tolwi/hassio-ecoflow-cloud): integración para monitorear y controlar la DELTA 3 por medio de la nube de EcoFlow.
- [REST API](https://developers.home-assistant.io/docs/api/rest/): API HTTP de Home Assistant para operar Home Assistant desde otros equipos.

## Archivos de configuración y scripts

Nada por ahora.

## Mantenimiento

- [ ] Revisar y limpiar notificaciones del menú principal
- [ ] Revisar `Reparaciones` y `Registros` en `Configuración → Sistema`
- [ ] Revisar uso de disco: `Configuración → Sistema → Almacenamiento`
- [ ] Verificar copias de seguridad automáticas: `Configuración → Sistema → Copias de seguridad`
- [ ] Aplicar actualizaciones de Core, OS, Supervisor y Aplicaciones: `Configuración → Sistema → Actualizaciones`
- [ ] Revisar dispositivos no disponibles: `Configuración → Dispositivos y servicios → Entidades` y filtrar por `Estado = No disponible`
- [ ] Revisar los tokens de acceso de larga duración: `Perfil → Seguridad`

## Pendientes

Nada por ahora.

## Bitácora

### 2026-07-20 monitoreo de la estación EcoFlow

Para monitorear y controlar la DELTA 3 Classic desde Home Assistant instalé HACS y la integración EcoFlow Cloud.

1. Instalé HACS por medio de la aplicación `Get HACS` del listado oficial de Home Assistant y seguí la configuración básica.
2. Para la integración EcoFlow Cloud, instalé `hassio-ecoflow-cloud` por medio de HACS y agregué un dispositivo EcoFlow usando el modo `private_api` que por el momento es el único que soporta la DELTA 3.
