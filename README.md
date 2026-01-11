```
 __                                  ___             __
/\ \                                /\_ \           /\ \
\ \ \___     ___     ___ ___      __\//\ \      __  \ \ \____
 \ \  _ `\  / __`\ /' __` __`\  /'__`\\ \ \   /'__`\ \ \ '__`\
  \ \ \ \ \/\ \L\ \/\ \/\ \/\ \/\  __/ \_\ \_/\ \L\.\_\ \ \L\ \
   \ \_\ \_\ \____/\ \_\ \_\ \_\ \____\/\____\ \__/.\_\\ \_,__/
    \/_/\/_/\/___/  \/_/\/_/\/_/\/____/\/____/\/__/\/_/ \/___/
```

Documentación de mi infraestructura casera.

La convención para los hostname es usar nombres de lugares de esparcimiento.

## Redes

- `EXT` - Red local administrada por el ISP
- `LAN` - Red local confiable
- `IOT` - Red local para dispositivos IoT `#TODO`

Por ahora, los dispositivos _inseguros_ están en `EXT` y los _confiables_ en `LAN`.

La idea es ir moviendo los dispositivos IoT a `IOT`, que debería:

- Aislar los dispositivos entre ellos
- Tener filtros y rutas hacia la `LAN`
- Limitar el acceso a Internet por dispositivo

```
+--------+    +------------------+    +------------------+    +----------+
| AP IOT |----|       EXT        |----|  Router/ONT ISP  |----| Internet |
+--------+    | 192.168.100.0/24 |    +------------------+    +----------+
              +------------------+
                       |
                       |
               +---------------+
               | Router/AP LAN |
               +---------------+
                       |
                       |
               +----------------+
               |      LAN       |
               | 192.168.0.0/24 |
               +----------------+

```

| Hostname                    | Equipo            | Propósito                      | EXT                                   | LAN                               |
|-----------------------------|-------------------|--------------------------------|---------------------------------------|-----------------------------------|
|                             | Huawei HG8245H    | Ruteador del ISP               | [192.168.100.1](http://192.168.100.1) |                                   |
| [saloncorona](#saloncorona) | GL.iNet GL-MT6000 | Ruteador y punto de acceso LAN | 192.168.100.2                         | [192.168.0.1](http://192.168.0.1) |
|                             | Netgear AV200     | Punto de acceso IOT            | [192.168.100.3](http://192.168.100.3) |                                   |

### saloncorona

`#WIP`

- https://openwrt.org/toh/gl.inet/gl-mt6000
- https://openwrt.org/docs/guide-quick-start/walkthrough_login
- https://forum.openwrt.org/t/best-newcomer-routers-2024/189050/1

## Computadoras

Dispositivos del hogar que corren Linux.

No incluye equipos personales (laptops o teléfonos) ni dispositivos _comerciales_ con Linux empotrado (Google Nest o TV con Android).

| Hostname                            | LAN         | EXT           | OS                     | Arch   |
|-------------------------------------|-------------|---------------|------------------------|--------|
| [duxdevenecia](#duxdevenecia)       |             | 192.168.100.4 | Debian GNU/Linux 12    | ARM32  |
| [laesperanza](#laesperanza)         | 192.168.0.2 |               | Raspbian GNU/Linux 11  | ARM32  |
| [lafaena](#lafaena)                 | 192.168.0.3 |               | Raspbian GNU/Linux 11  | ARM32  |
| [multiforoalicia](#multiforoalicia) | 192.168.0.4 |               | Ubuntu 24.04           | x86/64 |
| [latita](#latita)                   | 192.168.0.5 |               | Armbian 23.11.1        | ARM64  |

### duxdevenecia

`#WIP`

- [BeagleBone System Reference Manual](https://github.com/beagleboard/BeagleBone/blob/master/BeagleBone_SRM_A6_0_1.pdf)
- [Debian 11.x (Bullseye) - Monthly Snapshot - 2023-10-07](https://forum.beagleboard.org/t/debian-11-x-bullseye-monthly-snapshot-2023-10-07/31280/5)

### laesperanza

Hace streaming de audio a un minicomponente.

- [NanoPC-T6 - FriendlyELEC WiKi](https://wiki.friendlyelec.com/wiki/index.php/NanoPC-T6)
- [NanoPC T6 LTS - Armbian](https://www.armbian.com/nanopct6-lts/)
- [Raspotify](https://github.com/dtcooper/raspotify)

### latita

`#WIP`

- http://www.orangepi.org/orangepiwiki/index.php/Orange_Pi_3B
- https://www.armbian.com/orangepi3b/

`Armbian_23.11.1_Orangepi3b_bookworm_edge_6.6.2.img`
`linux-image-current-rockchip64=24.5.3` -> 6.6.39

- https://forum.armbian.com/topic/42698-armbian-on-orange-pi-3b-with-vendor-images-linux-66-dont-seem-to-work/

## IoT

Todo lo que tenga dirección IP y no es una computadora.

| Equipo                           | Lugar              | Propósito                                         | Red |
|----------------------------------|--------------------|---------------------------------------------------|-----|
| Becasmart BAF-908 Flower Waterer | Balcón             | Sistema de riego automático                       | DMZ |
| Wemo Mini Smart Plug             | Cuarto de servicio | Switch inteligente para calentador de agua        | DMZ |
| Wemo Mini Smart Plug             | Cuarto de servicio | Switch inteligente para bomba presurizadora       | DMZ |
| Google Nest Hub                  | Estancia           | Pantalla inteligente                              | LAN |
| Magic Home WiFi LED Controller   | Estancia           | Controla tira led                                 | DMZ |
| Kasa Smart Power Strip KP303     | Estancia           | Switch inteligente para ruteadores LAN y ONT      | DMZ |
| Wyze Smart Plug                  | Estancia           | Switch inteligente para globo terráqueo iluminado | DMZ |
| Google Nest Mini                 | Estudio            | Bocina inteligente                                | LAN |
| TLC TV 55" 4K UHD                | Estudio            | Televisión inteligente                            | LAN |
| Google Nest Mini                 | Recámara           | Bocina inteligente                                | LAN |
| Mi Air Purifier 3C               | Recámara           | Purificador de aire                               | DMZ |
| Wemo Insight Smart Plug          | Recámara           | Switch inteligente para calentador                | DMZ |
| Wiz DIM/5W G25 Amber             | Recámara           | Foco en lámpara de piso                           | DMZ |

## Cloud

| Hostname                      | OS                     | Arch   |
|-------------------------------|------------------------|--------|
| [balalaika](#balalaika)       | Debian GNU/Linux 12    | x86/64 |
| [riodelaplata](#riodelaplata) | AWS Linux 2023         | ARM64  |

### balalaika

Hospeda un servidor web y repositorios de Git en una instancia `e2-micro` de **Google Compute Engine**.

### riodelaplata

`#DEP`

Es una instancia `t4g.small` de **AWS EC2** que hospeda contenedores para:

- Almacenar mis suscripciones a podcasts y episodios escuchados (servidor [oPodSync](https://github.com/kd2org/opodsync) para [AntennaPod](https://antennapod.org/))
- Sincronizar mis notas entre dispositivos (servidor [CouchDB](https://couchdb.apache.org/) para [LiveSync](https://github.com/vrtmrz/obsidian-livesync) de [Obsidian](https://obsidian.md/)) `#DEP`
- Conectar mi red local con servidores remotos (servidor [OpenVPN](https://openvpn.net/)) `#DEP`
- Reenviar solicitudes a contenedores y mi red local (contenedor [Nginx Proxy Manager](https://github.com/NginxProxyManager/nginx-proxy-manager)) `#DEP`

Hice *chuletas* específicas para su [instalación](riodelaplata/instalacion.md) y configuración de [contenedores](riodelaplata/contenedores.md).
