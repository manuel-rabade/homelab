```
 __                                  ___             __
/\ \                                /\_ \           /\ \
\ \ \___     ___     ___ ___      __\//\ \      __  \ \ \____
 \ \  _ `\  / __`\ /' __` __`\  /'__`\\ \ \   /'__`\ \ \ '__`\
  \ \ \ \ \/\ \L\ \/\ \/\ \/\ \/\  __/ \_\ \_/\ \L\.\_\ \ \L\ \
   \ \_\ \_\ \____/\ \_\ \_\ \_\ \____\/\____\ \__/.\_\\ \_,__/
    \/_/\/_/\/___/  \/_/\/_/\/_/\/____/\/____/\/__/\/_/ \/___/
```

Fuente de verdad de mi infraestructura casera: [redes](#redes), [computadoras](#computadoras-y-equipos), [dispositivos](#dispositivos-iot-y-multimedia) y [servicios cloud](#cloud).

- [MAINTENANCE.md](MAINTENANCE.md): checklist de mantenimiento recurrente.
- [LICENSE](LICENSE): licencia del depósito (CC0 1.0).

## Redes

| Zona    | Segmento       | Propósito               | Medio                     | Políticas         |
|---------|----------------|-------------------------|---------------------------|-------------------|
| `LAN`   | 192.168.1.0/24 | Equipos confiables      | Wi-Fi 2.4/5 GHz, Ethernet | Sin restricciones |
| `GUEST` | 192.168.2.0/24 | Equipos externos        | Wi-Fi 5 GHz               | Dispositivos aislados, acceso a internet limitado |
| `IOT`   | 192.168.3.0/24 | Dispositivos IoT        | Wi-Fi 2.4 GHz             | Acceso a internet controlado por dispositivo |
| `MEDIA` | 192.168.4.0/24 | Dispositivos multimedia | Wi-Fi 5 GHz               | Acceso limitado a `LAN` |
| `SBC`   | 192.168.6.0/24 | Colección SBC           | Ethernet                  | Red aislada, acceso a internet limitado  |

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

Algunos equipos participan en redes privadas virtuales de [Tailscale](https://tailscale.com/), una personal y otra de la [RHED](https://rhed.xyz).

## Computadoras y equipos

| Hostname                          | Propósito   | Hardware | OS | Redes |
| --------------------------------- | ----------- | ---------------------------------------------------------------- | --- | --- |
| [salon-corona](hosts/salon-corona/)     | Router y AP | [GL.iNet GL-MT6000](https://www.gl-inet.com/products/gl-mt6000/) | [OpenWrt](https://openwrt.org) 24 | `LAN` 192.168.1.1<br>`GUEST` 192.168.2.1<br>`IOT` 192.168.3.1<br>`MEDIA` 192.168.4.1 |
| [la-esperanza](hosts/la-esperanza/)     | Laboratorio LAN | [NanoPC T6 LTS](https://www.friendlyelec.com/index.php?route=product/product&path=69&product_id=292) | [Armbian](https://armbian.com) 26 (trixie) | `LAN` 192.168.1.2<br>`VPN` Tailscale |
| [el-respiro](hosts/el-respiro/)         | NAS         | [QNAP TS-253E](https://www.qnap.com/en/product/ts-253e) | [QTS](https://www.qnap.com/la/operating-system/qts) 5.2 | `LAN` 192.168.1.3 |
| [barba-azul](hosts/barba-azul/)         | Hub IoT     | [Raspberry Pi 5](https://www.raspberrypi.com/products/raspberry-pi-5/) | [Home Assistant OS](https://www.home-assistant.io) | `LAN` 192.168.1.4<br>`IOT` 192.168.3.3 |
| [savoy](hosts/savoy/)                   | Laboratorio DMZ | [Raspberry Pi 4B](https://www.raspberrypi.com/products/raspberry-pi-4-model-b/) | [Armbian](https://armbian.com) 26 (trixie) | `GUEST` 192.168.2.2<br>`SBC` 192.168.6.1<br>`RHED` Tailscale |
| [dux-de-venecia](hosts/dux-de-venecia/) | SBC vintage | [BeagleBone](https://www.beagleboard.org/boards/beaglebone-original) | [Debian](https://www.debian.org) 12 (bookworm) | `SBC` 192.168.6.2<br>`RHED` Tailscale |

## Dispositivos IoT y multimedia

| Dispositivo                      | Propósito                       | Red    | Hostname | IP |
|----------------------------------|---------------------------------|---------|----------|----|
| Becasmart BAF-908 Flower Waterer | Sistema de riego                | `IOT`   | | |
| Google Nest Hub                  | Pantalla cocina                 | `MEDIA` | | |
| Google Nest Mini                 | Bocina estudio                  | `MEDIA` | | |
| Google Nest Mini                 | Bocina recamara                 | `MEDIA` | | |
| Google TV Streamer 4K            | Reproductor multimedia          | `MEDIA` | | |
| Lilygo TTGO LoRa 32 V1.6.1       | Estación TinyGS                 | `IOT`   | tinygs | 192.168.3.2 |
| Heltec WiFi LoRa 32 (V4)         | Nodo Meshtastic                 | `IOT`   | meshtastic | 192.168.3.10 |
| Kasa Smart Power Strip KP303     | Multicontacto                   | `IOT`   | | |
| Magic Home WiFi LED Controller   | Tira led                        | `IOT`   | | |
| Mi Air Purifier 3C               | Purificador de aire             | `IOT`   | | |
| TCL TV 55" 4K UHD                | Televisión                      | `MEDIA` | | |
| Wemo Insight Smart Plug          | Switch para calentador          | `IOT`   | | |
| Wemo Mini Smart Plug             | Switch para bomba presurizadora | `IOT`   | | |
| Wemo Mini Smart Plug             | Switch para calentador de agua  | `IOT`   | | |
| Wiz DIM/5W G25 Amber             | Foco atenuable                  | `IOT`   | | |
| Wyze Smart Plug                  | Switch para lámpara             | `IOT`   | | |

## Cloud

| Hostname                      | IP            |
|-------------------------------|---------------|
| [balalaika](#balalaika)       | 34.67.134.108 |

### balalaika

- Servidor Linux público
- Hospeda sitios web y depósitos Git

- Cloud: Google Compute Engine
- Instancia: `e2-micro`
- OS: Debian GNU/Linux 12
