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
- [go-librespot](https://github.com/devgianlu/go-librespot)

## Archivos de configuración y scripts

- [config-audio](config-audio): restablece el códec rt5616 a un estado base limpio y ajusta el volumen maestro (salida por el jack 3.5mm trasero hacia el amplificador, captura y line-out desactivados, guarda `asound.state`).
- [go-librespot/config.yml](go-librespot/config.yml): configuración de go-librespot, va en `~/.config/go-librespot/`.
- [go-librespot/go-librespot.service](go-librespot/go-librespot.service): unidad systemd de usuario de go-librespot, va en `~/.config/systemd/user/`.

## Mantenimiento

- [ ] Revisar uso de disco: `df -h -t ext4`
- [ ] Actualizar dotfiles: `git pull`
- [ ] Actualizar paquetes: `apt update && apt upgrade`
- [ ] Reiniciar: `reboot`
- [ ] Verificar go-librespot: `systemctl --user status go-librespot`

## Pendientes

Nada por ahora.

## Bitácora

### 2026-06-28 Migración a go-librespot

Endpoint de Spotify Connect ejecutándose como servicio systemd de usuario. Se eligió go-librespot sobre raspotify por estar activamente mantenido y manejar mejor la API actual de Spotify. Se instala como binario precompilado (no está en los repos de Armbian/Debian). La salida de audio es el codec rt5616 (`card 0`), con volumen manejado por software y controlado desde la app de Spotify.

#### Instalación

```bash
wget https://github.com/devgianlu/go-librespot/releases/download/v0.7.4/go-librespot_linux_arm64.tar.gz
tar -xzvf go-librespot_linux_arm64.tar.gz
mv go-librespot ~/bin/
```

#### Configuración

- [go-librespot/config.yml](go-librespot/config.yml) en `~/.config/go-librespot/`.
- [go-librespot/go-librespot.service](go-librespot/go-librespot.service) en `~/.config/systemd/user/`

Notas de configuración:

- `audio_device` usa el nombre de la tarjeta (`realtekrt5616co`) en vez del índice para sobrevivir a un re-enumerado de tarjetas.
- Volumen por software (sin `external_volume`): da mejor rango bajo que el DAC del rt5616, inaudible debajo de ~30%.
- El servicio usa `Restart=always`: al arranque puede fallar el primer intento si la red no está lista (error `apresolve`), y reintenta hasta enganchar.

#### Activar al arranque

```bash
systemctl --user daemon-reload
systemctl --user enable --now go-librespot
sudo loginctl enable-linger manuel
```

El lingering hace que el servicio de usuario arranque al boot sin necesidad de una sesión activa.

#### Logs

Van al journal del sistema, no al de usuario:

```bash
systemctl --user status go-librespot
journalctl -t go-librespot -f
```

### 2026-06-23 audio roto por kernel 6.18

El mantenimiento del 21 de junio subió el kernel a la serie 6.18 (6.18.35-current-rockchip64) y rompió la salida de audio: ALSA detecta el codec rt5616 y aplay no da error, pero no hay sonido (PCM en CLOSED, el i2s no inicializa). Es regresión del driver, no config.

Solución: downgrade vía armbian-config (System → Kernel) a la versión 25.11.2, serie 6.12 (6.12.58-current-rockchip64).

Para evitar que una futura actualización reinstale el 6.18, se retuvieron los paquetes del kernel:

```bash
sudo apt-mark hold linux-image-current-rockchip64 linux-dtb-current-rockchip64
```

Para probar un kernel nuevo en el futuro (por si se corrige la regresión del rt5616):

```bash
sudo apt-mark unhold linux-image-current-rockchip64 linux-dtb-current-rockchip64
sudo apt update && sudo apt upgrade
```

Probar el audio tras actualizar; si falla, volver a 6.12 con armbian-config y reaplicar el hold.
