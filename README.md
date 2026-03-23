```
 __                                  ___             __
/\ \                                /\_ \           /\ \
\ \ \___     ___     ___ ___      __\//\ \      __  \ \ \____
 \ \  _ `\  / __`\ /' __` __`\  /'__`\\ \ \   /'__`\ \ \ '__`\
  \ \ \ \ \/\ \L\ \/\ \/\ \/\ \/\  __/ \_\ \_/\ \L\.\_\ \ \L\ \
   \ \_\ \_\ \____/\ \_\ \_\ \_\ \____\/\____\ \__/.\_\\ \_,__/
    \/_/\/_/\/___/  \/_/\/_/\/_/\/____/\/____/\/__/\/_/ \/___/
```

Fuente de verdad de mi infraestructura casera.

## Redes

| Zona    | Segmento       | Propósito          | Notas |
|---------|----------------|--------------------|-------|
| `LAN`   | 192.168.1.0/24 | Equipos confiables | Sin restricciones |
| `GUEST` | 192.168.2.0/24 | Equipos externos   | Solo Wi-Fi, dispositivos aislados, acceso a internet limitado |
| `IOT`   | 192.168.3.0/24 | Dispositivos IoT   | Solo Wi-Fi, acceso a internet controlado por dispositivo |
| `SBC`   | 192.168.4.0/24 | Colección SBC      | Solo Ethernet, red aislada, acceso a internet limitado  |

```
                        +------------+
                        |  Internet  |
                        +------------+
                              |
                              |
                      +----------------+
        --------------|  salon-corona  |-------------
        |             +----------------+            |
        |                     |                     |
        |                     |                     |
+----------------+    +----------------+    +----------------+
|      LAN       |    |     GUEST      |    |      IOT       |
| 192.168.1.0/24 |    | 192.168.2.0/24 |    | 192.168.3.0/24 |
+----------------+    +----------------+    +----------------+
                              |
                              |
                      +----------------+
                      |     savoy      |
                      +----------------+
                              |
                              |
                      +----------------+
                      |      SBC       |
                      | 192.168.4.0/24 |
                      +----------------+
```

Adicionalmente, algunos equipos participan en redes privadas virtuales de [Tailscale](https://tailscale.com/), incluyendo una red personal y otra de la [RHED](https://rhed.xyz).

## Dispositivos

| Hostname                          | `LAN`       | `GUEST`     | `IOT`       | `SBC`       |
|-----------------------------------|-------------|-------------|-------------|-------------|
| [salon-corona](#salon-corona)     | 192.168.1.1 | 192.168.2.1 | 192.168.3.1 |             |
| [la-esperanza](#la-esperanza)     | 192.168.1.2 |             |             |             |
| [el-respiro](#el-respiro)         | 192.168.1.3 |             |             |             |
| [barba-azul](#barba-azul)         | 192.168.1.4 |             | 192.168.3.3 |             |
| [savoy](#savoy)                   |             | 192.168.2.2 |             | 192.168.4.1 |
| [dux-de-venecia](#dux-de-venecia) |             |             |             | 192.168.4.2 |

### salon-corona

Router principal y punto de acceso inalámbrico. Aplica segmentación y políticas de red para toda la infraestructura.

- Hardware: [GL.iNet GL-MT6000](https://www.gl-inet.com/products/gl-mt6000/)
- OS: OpenWrt 24
- Referencias:
  - [[OpenWrt Wiki] GL.iNet GL-MT6000](https://openwrt.org/toh/gl.inet/gl-mt6000)

### la-esperanza

Equipo Linux multipropósito. Reproduce Spotify en un amplificador Fosi Audio TB10D1 con bocinas LG FBS162V.

- Hardware: [NanoPC T6 LTS](https://www.friendlyelec.com/index.php?route=product/product&path=69&product_id=292)
- OS: Armbian 26 (trixie)
- Referencias:
  - [NanoPC-T6 - FriendlyELEC WiKi](https://wiki.friendlyelec.com/wiki/index.php/NanoPC-T6)
  - [NanoPC T6 LTS - Armbian](https://www.armbian.com/nanopct6-lts/)
  - [Raspotify](https://github.com/dtcooper/raspotify)

### el-respiro

Servidor NAS. Almacena datos y gestiona copias de seguridad periódicas.

- Hardware:
  - [QNAP TS-253E](https://www.qnap.com/en/product/ts-253e)
  - 2 × 16 TB en RAID 1 (almacenamiento principal)
  - 1 × 16 TB externo (respaldo general)
- OS: QTS 5.2

### barba-azul

Plataforma de automatización del hogar. Integra y controla dispositivos IoT.

- Hardware: [Raspberry Pi 5](https://www.raspberrypi.com/products/raspberry-pi-5/)
- OS: [Home Assistant OS](https://www.home-assistant.io)

### savoy

Nodo de la RHED y router de la red `SBC`.

- Hardware: [Raspberry Pi 4B](https://www.raspberrypi.com/products/raspberry-pi-4-model-b/)
- OS: Armbian 26 (trixie)
- Configuración:
  - `/etc/sysctl.d/10-ip_forward.conf`
  - `/etc/netplan/30-wifi-static.yaml`
  - `/etc/netplan/40-eth-static.yaml`
  - Ruta estática en `salon-corona` hacia `192.168.4.0/24`

### dux-de-venecia

SBC de colección. Parte del laboratorio personal y nodo de la RHED.

- Hardware: [BeagleBone](https://www.beagleboard.org/boards/beaglebone-original)
- OS: Debian 12 (bookworm)
- Referencias:
  - [BeagleBone System Reference Manual](https://github.com/beagleboard/BeagleBone/blob/master/BeagleBone_SRM_A6_0_1.pdf)
  - [Debian 11.x (Bullseye) - Monthly Snapshot - 2023-10-07](https://forum.beagleboard.org/t/debian-11-x-bullseye-monthly-snapshot-2023-10-07/31280/5)

## IoT

| Dispositivo                      | Propósito                       | Zona  | Hostname | IP |
|----------------------------------|---------------------------------|-------|----------|----|
| Becasmart BAF-908 Flower Waterer | Sistema de riego                | `IOT` | | |
| Google Nest Hub                  | Pantalla cocina                 | `LAN` | | |
| Google Nest Mini                 | Bocina estudio                  | `LAN` | | |
| Google Nest Mini                 | Bocina recamara                 | `LAN` | | |
| Lilygo TTGO LoRa 32 V1.6.1       | Estación TinyGS                 | `IOT` | tinygs | 192.168.3.2 |
| Heltec WiFi LoRa 32 (V4)         | Nodo Meshtastic                 | `IOT` | meshtastic |  192.168.3.10 |
| Kasa Smart Power Strip KP303     | Multicontacto                   | `IOT` | | |
| Magic Home WiFi LED Controller   | Tira led                        | `IOT` | | |
| Mi Air Purifier 3C               | Purificador de aire             | `IOT` | | |
| TCL TV 55" 4K UHD                | Televisión                      | `LAN` | | |
| Wemo Insight Smart Plug          | Switch para calentador          | `IOT` | | |
| Wemo Mini Smart Plug             | Switch para bomba presurizadora | `IOT` | | |
| Wemo Mini Smart Plug             | Switch para calentador de agua  | `IOT` | | |
| Wiz DIM/5W G25 Amber             | Foco atenuable                  | `IOT` | | |
| Wyze Smart Plug                  | Switch para lámpara             | `IOT` | | |

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
