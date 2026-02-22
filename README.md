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

| Zona    | Segmento       | Notas |
|---------|----------------|-------|
| `LAN`   | 192.168.1.0/24 | Dispositivos confiables, sin restricciones |
| `GUEST` | 192.168.2.0/24 | Solo Wi-Fi, dispositivos aislados, acceso a internet limitado |
| `IOT`   | 192.168.3.0/24 | Solo Wi-Fi, acceso a internet controlado |

## Dispositivos

| Hostname                            | `LAN`       | `GUEST`     | `IOT`       |
|-------------------------------------|-------------|-------------|-------------|
| [salon-corona](#salon-corona)       | 192.168.1.1 | 192.168.2.1 | 192.168.3.1 |
| [la-esperanza](#la-esperanza)       | 192.168.1.2 |             |             |

### salon-corona

- Router y punto de acceso inalámbrico
- Aplica segmentación y políticas de red

- Hardware: [GL.iNet GL-MT6000](https://www.gl-inet.com/products/gl-mt6000/)
- OS: OpenWrt 24
- Referencias:
  - [[OpenWrt Wiki] GL.iNet GL-MT6000](https://openwrt.org/toh/gl.inet/gl-mt6000)

### la-esperanza

- Equipo Linux multipropósito
- Reproduce Spotify en un amplificador Fosi Audio TB10D1 con bocinas LG FBS162V

- Hardware: [NanoPC T6 LTS](https://www.friendlyelec.com/index.php?route=product/product&path=69&product_id=292)
- OS: Armbian 26 (trixie)
- Referencias:
  - [NanoPC-T6 - FriendlyELEC WiKi](https://wiki.friendlyelec.com/wiki/index.php/NanoPC-T6)
  - [NanoPC T6 LTS - Armbian](https://www.armbian.com/nanopct6-lts/)
  - [Raspotify](https://github.com/dtcooper/raspotify)

## IoT

| Dispositivo                      | Propósito                       | Zona  |
|----------------------------------|---------------------------------|-------|
| Becasmart BAF-908 Flower Waterer | Sistema de riego                | `IOT` |
| Google Nest Hub                  | Pantalla cocina                 | `LAN` |
| Google Nest Mini                 | Bocina estudio                  | `LAN` |
| Google Nest Mini                 | Bocina recamara                 | `LAN` |
| Kasa Smart Power Strip KP303     | Multicontacto                   | `IOT` |
| Magic Home WiFi LED Controller   | Tira led                        | `IOT` |
| Mi Air Purifier 3C               | Purificador de aire             | `IOT` |
| TLC TV 55" 4K UHD                | Televisión                      | `LAN` |
| Wemo Insight Smart Plug          | Switch para calentador          | `IOT` |
| Wemo Mini Smart Plug             | Switch para bomba presurizadora | `IOT` |
| Wemo Mini Smart Plug             | Switch para calentador de agua  | `IOT` |
| Wiz DIM/5W G25 Amber             | Foco atenuable                  | `IOT` |
| Wyze Smart Plug                  | Switch para lámpara             | `IOT` |

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
