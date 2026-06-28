# la-esperanza

- Propósito: Laboratorio LAN.
- Hardware: [NanoPC T6 LTS](https://www.friendlyelec.com/index.php?route=product/product&path=69&product_id=292)
- OS: [Armbian](https://armbian.com) 26 (trixie)
- Redes:
  - `LAN` 192.168.1.2
  - `VPN` Tailscale

## Servicios

- Host para pruebas, scripts, automatizaciones y servicios dentro de la LAN.
- Reproductor de Spotify Connect con salida a un amplificador [Fosi Audio TB10D1](https://fosiaudio.com/es/pages/2-channel-amplifier-tb10d) y bocinas LG FBS162V.

## Referencias

- [NanoPC-T6 - FriendlyELEC WiKi](https://wiki.friendlyelec.com/wiki/index.php/NanoPC-T6)
- [NanoPC T6 LTS - Armbian](https://www.armbian.com/nanopct6-lts/)
- [Raspotify](https://github.com/dtcooper/raspotify)

## Archivos de configuración y scripts

- [config-audio.sh](config-audio.sh): ajusta el volumen maestro y deja el códec rt5616 en un estado base limpio (salida por el jack 3.5mm trasero hacia el amplificador, captura y line-out desactivados, guarda `asound.state`).

## Mantenimiento

- [ ] Revisar uso de disco: `df -h -t ext4`
- [ ] Actualizar dotfiles: `git pull`
- [ ] Actualizar paquetes: `apt update && apt upgrade`
- [ ] Reiniciar: `reboot`
- [ ] Verificar Raspotify: `systemctl status raspotify`

## Pendientes

Nada por ahora.

## Bitácora

### 2026-06-23 audio roto por kernel 6.18

El mantenimiento del 21 de junio subió el kernel a la serie 6.18 (6.18.35-current-rockchip64) y rompió la salida de audio: ALSA detecta el codec rt5616 y aplay no da error, pero no hay sonido (PCM en CLOSED, el i2s no inicializa). Es regresión del driver, no config.

Solución: downgrade vía armbian-config (System → Kernel) a la versión 25.11.2, serie 6.12 (6.12.58-current-rockchip64).

Para evitar que una futura actualización reinstale el 6.18, se retuvieron los paquetes del kernel:

```
sudo apt-mark hold linux-image-current-rockchip64 linux-dtb-current-rockchip64
```

Para probar un kernel nuevo en el futuro (por si se corrige la regresión del rt5616):

```
sudo apt-mark unhold linux-image-current-rockchip64 linux-dtb-current-rockchip64
sudo apt update && sudo apt upgrade
```

Probar el audio tras actualizar; si falla, volver a 6.12 con armbian-config y reaplicar el hold.
