```
 __                                  ___             __
/\ \                                /\_ \           /\ \
\ \ \___     ___     ___ ___      __\//\ \      __  \ \ \____
 \ \  _ `\  / __`\ /' __` __`\  /'__`\\ \ \   /'__`\ \ \ '__`\
  \ \ \ \ \/\ \L\ \/\ \/\ \/\ \/\  __/ \_\ \_/\ \L\.\_\ \ \L\ \
   \ \_\ \_\ \____/\ \_\ \_\ \_\ \____\/\____\ \__/.\_\\ \_,__/
    \/_/\/_/\/___/  \/_/\/_/\/_/\/____/\/____/\/__/\/_/ \/___/
```

Fuente de verdad de mi infraestructura casera: [redes](#redes), [computadoras](#computadoras-y-equipos), [dispositivos](#dispositivos-iot-y-multimedia) y [servicios cloud](#servicios-cloud), más la [bitácora](#bitácora) del trabajo hecho en cada host.

- [MAINTENANCE.md](MAINTENANCE.md): checklist de mantenimiento recurrente.
- [LICENSE](LICENSE): licencia del depósito (CC0 1.0).

## Redes

Cinco zonas segmentan la casa por nivel de confianza: `LAN` confiable, `GUEST` aislada, e `IOT` y `MEDIA` para los dispositivos del hogar. `salon-corona` rutea esas cuatro y `SBC` cuelga de `savoy` como red aislada. Algunos equipos participan en tailnets, una personal en [Tailscale](https://tailscale.com) y otra de la [RHED](https://rhed.xyz) sobre [Headscale](https://headscale.net).

| Zona    | Segmento       | Propósito               | Medio                     | Políticas         |
|---------|----------------|-------------------------|---------------------------|-------------------|
| `LAN`   | 192.168.1.0/24 | Equipos confiables      | Wi-Fi 2.4/5 GHz, Ethernet | Sin restricciones |
| `GUEST` | 192.168.2.0/24 | Equipos externos        | Wi-Fi 5 GHz               | Dispositivos aislados, acceso a internet limitado |
| `IOT`   | 192.168.3.0/24 | Dispositivos IoT        | Wi-Fi 2.4 GHz             | Acceso a internet controlado por dispositivo |
| `MEDIA` | 192.168.4.0/24 | Dispositivos multimedia | Wi-Fi 5 GHz               | Acceso limitado a `LAN` |
| `SBC`   | 192.168.6.0/24 | Colección SBC           | Ethernet                  | Red aislada, acceso a internet limitado  |

### Mapa

```
                                   +------------+
                                   |  Internet  |
                                   +------------+
                                         |
                                         |
                          +-----------------------------+
        +-----------------|         salon-corona        |-----------------+
        |                 +-----------------------------+                 |
        |                     |                     |                     |
        |                     |                     |                     |
        |                     |                     |                     |
        |                     |                     |                     |
+----------------+    +----------------+    +----------------+    +----------------+
|      LAN       |    |     GUEST      |    |      IOT       |    |     MEDIA      |
| 192.168.1.0/24 |    | 192.168.2.0/24 |    | 192.168.3.0/24 |    | 192.168.4.0/24 |
+----------------+    +----------------+    +----------------+    +----------------+
                              |
                              |
                      +----------------+
                      |     savoy      |
                      +----------------+
                              |
                              |
                      +----------------+
                      |      SBC       |
                      | 192.168.6.0/24 |
                      +----------------+
```

## Computadoras y Equipos

Las computadoras administradas del hogar, excluyendo las personales. Cada una con su página en [hosts/](hosts/) como fuente de verdad. `salon-corona` es el router OpenWrt que segmenta, aplica firewall entre zonas y provee DHCP y DNS; `la-esperanza`, laboratorio de la `LAN`, corre scripts, automatizaciones y un Spotify Connect hacia un amplificador; `el-respiro` es el NAS QNAP con SMB, Jellyfin y respaldo automático de datos a un disco externo; `barba-azul` aloja Home Assistant para controlar los dispositivos IoT; `covadonga` es el mini PC dedicado a experimentar con LLMs locales; y `savoy` junto con la BeagleBone vintage `dux-de-venecia` forman la DMZ como nodos de la *hipermegaRHED*.

| Hostname                          | Propósito   | Hardware | OS | Redes |
| --------------------------------- | ----------- | ---------------------------------------------------------------- | --- | --- |
| [salon-corona](hosts/salon-corona/)     | Router y AP | [GL.iNet GL-MT6000](https://www.gl-inet.com/products/gl-mt6000/) | [OpenWrt](https://openwrt.org) 24 | `LAN`&nbsp;192.168.1.1<br>`GUEST`&nbsp;192.168.2.1<br>`IOT`&nbsp;192.168.3.1<br>`MEDIA`&nbsp;192.168.4.1 |
| [la-esperanza](hosts/la-esperanza/)     | Laboratorio LAN | [NanoPC T6 LTS](https://www.friendlyelec.com/index.php?route=product/product&path=69&product_id=292) | [Armbian](https://armbian.com) 26 (trixie) | `LAN`&nbsp;192.168.1.2<br>`VPN`&nbsp;tailnet |
| [el-respiro](hosts/el-respiro/)         | NAS         | [QNAP TS-253E](https://www.qnap.com/en/product/ts-253e) | [QTS](https://www.qnap.com/la/operating-system/qts) 5.2 | `LAN`&nbsp;192.168.1.3 |
| [barba-azul](hosts/barba-azul/)         | Hub IoT     | [Raspberry Pi 5](https://www.raspberrypi.com/products/raspberry-pi-5/) | [Home Assistant OS](https://www.home-assistant.io) 18 | `LAN`&nbsp;192.168.1.4<br>`IOT`&nbsp;192.168.3.3 |
| [covadonga](hosts/covadonga/)           | Laboratorio LLMs | [Minisforum UM890 Pro](https://www.minisforum.com/products/minisforum-um890-pro) | [Ubuntu Server](https://ubuntu.com/server) 26.04 LTS (resolute) | `LAN`&nbsp;192.168.1.5 |
| [savoy](hosts/savoy/)                   | Laboratorio DMZ | [Raspberry Pi 4B](https://www.raspberrypi.com/products/raspberry-pi-4-model-b/) | [Armbian](https://armbian.com) 26 (trixie) | `GUEST`&nbsp;192.168.2.2<br>`SBC`&nbsp;192.168.6.1<br>`RHED`&nbsp;tailnet |
| [dux-de-venecia](hosts/dux-de-venecia/) | SBC vintage | [BeagleBone](https://www.beagleboard.org/boards/beaglebone-original) | [Debian](https://www.debian.org) 12 (bookworm) | `SBC`&nbsp;192.168.6.2<br>`RHED`&nbsp;tailnet |

## Dispositivos IoT y Multimedia

Dispositivos de propósito específico, a diferencia de las computadoras de propósito general, repartidos entre las redes `IOT` y `MEDIA`. En `IOT` predominan enchufes inteligentes (Wemo, Kasa, Wyze), iluminación (Magic Home, Wiz), nodos LoRa para TinyGS y Meshtastic y una estación EcoFlow que respalda el homelab como UPS; en `MEDIA` están las bocinas, pantallas y el reproductor de Google.

| Dispositivo                      | Propósito                       | Red    | Hostname | IP |
|----------------------------------|---------------------------------|---------|----------|----|
| Becasmart BAF-908 Flower Waterer | Sistema de riego                | `IOT`   | | |
| EcoFlow DELTA 3 Classic          | UPS del homelab                 | `IOT`   | | |
| Google Nest Hub                  | Pantalla cocina                 | `MEDIA` | | |
| Google Nest Mini                 | Bocina estudio                  | `MEDIA` | | |
| Google Nest Mini                 | Bocina recamara                 | `MEDIA` | | |
| Google TV Streamer 4K            | Reproductor multimedia          | `MEDIA` | | |
| Lilygo TTGO LoRa 32 V1.6.1       | Estación TinyGS                 | `IOT`   | tinygs | 192.168.3.2 |
| Heltec WiFi LoRa 32 (V4)         | Nodo Meshtastic                 | `IOT`   | meshtastic | 192.168.3.10 |
| Kasa Smart Power Strip KP303     | Multicontacto                   | `IOT`   | | |
| Magic Home WiFi LED Controller   | Tira led                        | `IOT`   | | |
| Mi Air Purifier 3C               | Purificador de aire             | `IOT`   | | |
| TCL TV 55" 4K UHD                | Televisión                      | `IOT`   | | |
| Wemo Insight Smart Plug          | Switch para calentador          | `IOT`   | | |
| Wemo Mini Smart Plug             | Switch para bomba presurizadora | `IOT`   | | |
| Wemo Mini Smart Plug             | Switch para calentador de agua  | `IOT`   | | |
| Wiz DIM/5W G25 Amber             | Foco atenuable                  | `IOT`   | | |
| Wyze Smart Plug                  | Switch para lámpara             | `IOT`   | | |

## Servicios Cloud

VMs rentadas fuera de la red casera para servicios que necesitan exponerse a internet. Por ahora solo `balalaika`, una `e2-micro` con Debian en Google Cloud que hospeda mis sitios web (rabade.net, rabade.dev, entre otros), un servidor oPodSync para sincronizar mi historial de podcasts escuchados en AntennaPod y depósitos Git personales.

| Hostname                      | Propósito        | Proveedor | Instancia | OS | IP |
| ----------------------------- | ---------------- | --------- | --------- | -- | -- |
| [balalaika](cloud/balalaika/) | Servidor público | [Google Cloud](https://cloud.google.com) | `e2-micro` | [Debian](https://www.debian.org) 12 (bookworm) | 34.67.134.108 |

## Bitácora

Vista agregada del trabajo registrado en cada host, de lo más reciente a lo más viejo.

| Fecha | Host | Descripción |
| ----- | ---- | ----------- |
| [Ago&nbsp;22,&nbsp;2026](hosts/covadonga/README.md#2026-08-22-instalación-de-covadonga) | [covadonga](hosts/covadonga/) | Alta del mini PC dedicado a experimentar con LLMs locales. Se instaló Ubuntu Server 26.04 LTS con IP fija en la `LAN` |
| [Ago&nbsp;16,&nbsp;2026](hosts/el-respiro/README.md#2026-08-16-respaldo-automático-al-disco-externo) | [el-respiro](hosts/el-respiro/) | El script `backup-usb` prende el enchufe inteligente del disco externo, espera el montaje y vigila el registro de eventos hasta que terminan los trabajos de HBS. Si todos salen bien desmonta y apaga el disco, reportando cada paso por Notification Center |
| [Jul&nbsp;20,&nbsp;2026](hosts/barba-azul/README.md#2026-07-20-monitoreo-de-la-estación-ecoflow) | [barba-azul](hosts/barba-azul/) | Instalación de HACS y de la integración EcoFlow Cloud en Home Assistant. Con ella se monitorea y controla la estación DELTA 3 Classic en modo `private_api` |
| [Jul&nbsp;4,&nbsp;2026](hosts/savoy/README.md#2026-07-04-conexión-a-la-hipermegarhed) | [savoy](hosts/savoy/) | Alta del nodo en la *hipermegaRHED*, la red mesh sobre WireGuard de la RHED. Se instaló Tailscale desde su repositorio y se registró el nodo contra el servidor Headscale del KPR |
| [Jun&nbsp;28,&nbsp;2026](hosts/la-esperanza/README.md#2026-06-28-migración-a-go-librespot) | [la-esperanza](hosts/la-esperanza/) | Endpoint de Spotify Connect corriendo como servicio systemd de usuario. Se eligió go-librespot sobre raspotify por estar activamente mantenido, con salida por el codec rt5616 y volumen por software |
| [Jun&nbsp;23,&nbsp;2026](hosts/la-esperanza/README.md#2026-06-23-audio-roto-por-kernel-618) | [la-esperanza](hosts/la-esperanza/) | El kernel 6.18 rompió la salida de audio del codec rt5616, una regresión del driver y no de la configuración. Se bajó a la serie 6.12 con armbian-config y se retuvieron los paquetes con `apt-mark hold` |
