```
 __                                  ___             __
/\ \                                /\_ \           /\ \
\ \ \___     ___     ___ ___      __\//\ \      __  \ \ \____
 \ \  _ `\  / __`\ /' __` __`\  /'__`\\ \ \   /'__`\ \ \ '__`\
  \ \ \ \ \/\ \L\ \/\ \/\ \/\ \/\  __/ \_\ \_/\ \L\.\_\ \ \L\ \
   \ \_\ \_\ \____/\ \_\ \_\ \_\ \____\/\____\ \__/.\_\\ \_,__/
    \/_/\/_/\/___/  \/_/\/_/\/_/\/____/\/____/\/__/\/_/ \/___/
```

Documentacion de mi infraestructura casera.

## Red

El objetivo es separar los dispositivos _inseguros_ en la **DMZ** de los _confiables_ en la **LAN**.

El propósito de la **VPN** es exponer servicios locales en Internet.

El plan a futuro es migrar de la doble NAT a redes propiamente enrutadas y filtradas.

```
+----------------+    +---------------+    +------------------+    +----------+
|      LAN       |----| Router/AP LAN |----|  Router/ONT ISP  |----| Internet |
| 192.168.0.0/24 |    +---------------+    +------------------+    +----------+
+----------------+                                  |
        |                                           |
        |                                  +------------------+
 +------------+                            |       DMZ        |
 | Router VPN |                            | 192.168.100.0/24 |
 +------------+                            +------------------+
        |                                           |
        |                                           |
+----------------+                             +--------+
|      VPN       |                             | AP DMZ |
| 192.168.1.0/24 |                             +--------+
+----------------+
```

| Equipo         | Proposito                      | DMZ                                   | LAN                               |
|----------------|--------------------------------|---------------------------------------|-----------------------------------|
| Archer C2300   | Ruteador y punto de acceso LAN | 192.168.100.2                         | [192.168.0.1](http://192.168.0.1) |
| Huawei HG8245H | Ruteador proveedor de Internet | [192.168.100.1](http://192.168.100.1) |                                   |
| Netgear AV200  | Punto de acceso DMZ            | [192.168.100.3](http://192.168.100.3) |                                   |

### VPN

Permite el acceso a servicios locales desde Internet por medio de servidores _en la nube_.

- El servidor de la VPN se encuentra en [riodelaplata](#riodelaplata), un servidor _en la nube_.
- El cliente de la VPN [latita](#latita) se encarga de enrutar el trafico con la LAN.
- También [balalaika](#balalaika) es cliente de la VPN, otro servidor _en la nube_.

Esta configuración es necesaria porque mi ISP utiliza redes privadas y NAT en su servicio de Internet _residencial_.

Laptops y celulares también pueden conectarse a la VPN para acceder recursos locales de forma remota.

## Computadoras

Dispositivos del hogar que corren Linux.

No incluye equipos personales (laptops o teléfonos) ni dispositivos _comerciales_ con Linux empotrado (Google Nest o TV con Android).

La convención para los hostname es usar nombres de lugares de espacimiento.

| Hostname                            | LAN         | VPN         | DMZ           | OS                     | Arch   |
|-------------------------------------|-------------|-------------|---------------|------------------------|--------|
| [balalaika](#balalaika)             |             | 192.168.1.3 |               | Debian GNU/Linux 12    | x86/64 |
| [duxdevenecia](#duxdevenecia)       |             |             | 192.168.100.4 | Debian GNU/Linux 12    | ARM32  |
| [laesperanza](#laesperanza)         | 192.168.0.2 |             |               | Raspbian GNU/Linux 11  | ARM32  |
| [lafaena](#lafaena)                 | 192.168.0.3 |             |               | Raspbian GNU/Linux 11  | ARM32  |
| [latita](#latita)                   | 192.168.0.5 | 192.168.1.2 |               | Armbian 23.11.1        | ARM64  |
| [multiforoalicia](#multiforoalicia) | 192.168.0.4 |             |               | Ubuntu 24.04           | x86/64 |
| [riodelaplata](#riodelaplata)       |             | 192.168.1.1 |               | AWS Linux 2023         | ARM64  |

### balalaika

Hospeda un servidor web y repositorios de Git en una instancia `e2-micro` de **Google Compute Engine**.

### duxdevenecia

`#WIP`

- [BeagleBone System Reference Manual](https://github.com/beagleboard/BeagleBone/blob/master/BeagleBone_SRM_A6_0_1.pdf)
- [Debian 11.x (Bullseye) - Monthly Snapshot - 2023-10-07](https://forum.beagleboard.org/t/debian-11-x-bullseye-monthly-snapshot-2023-10-07/31280/5)

### laesperanza

Servidor local de DHCP y DNS en una **Raspberry Pi B**. Utiliza Pi-hole, un servidor DNS con bloqueo de anuncios. Como proveedor de DNS ascendente uso CloudFare.

- [Pi-hole: A black hole for Internet advertisements](https://github.com/pi-hole/pi-hole/)

### lafaena

Hace streaming de audio a un minicomponente. Es una **Raspberry Pi B** ejecutando Raspotify, un cliente de Spotify.

- [Raspotify Basic Setup Guide](https://github.com/dtcooper/raspotify/wiki/Basic-Setup-Guide)
- [Raspotify on Pi v1's and Pi Zero v1.x](https://github.com/dtcooper/raspotify/wiki/Raspotify-on-Pi-v1's-and-Pi-Zero-v1.x)

### latita

`#WIP`

- http://www.orangepi.org/orangepiwiki/index.php/Orange_Pi_3B
- https://www.armbian.com/orangepi3b/

### multiforoalicia

Desktop Ubuntu en una **Share MiniPC X3700m** conectada a la TV para navegar en Internet, reproducir videos, etc. Para jugar tiene RetroPie, un emulador de consolas retro.

- [RetroPie Setup](https://github.com/RetroPie/RetroPie-Setup)

### riodelaplata

Es una instancía `t4g.small` de **AWS EC2** que hospeda contenedores para:

- Almacenar mis suscripciones a podcasts y episodios escuchados (servidor [oPodSync](https://github.com/kd2org/opodsync) para [AntennaPod](https://antennapod.org/))
- Sincronizar mis notas entre dispositivos (servidor [CouchDB](https://couchdb.apache.org/) para [LiveSync](https://github.com/vrtmrz/obsidian-livesync) de [Obsidian](https://obsidian.md/))
- Conectar mi red local con servidores remotos (servidor [OpenVPN](https://openvpn.net/))
- Reenviar solicitudes a contendores y mi red local (contenedor [Nginx Proxy Manager](https://github.com/NginxProxyManager/nginx-proxy-manager))

Hice *chuletas* especificas para su [instalación](riodelaplata/instalacion.md) y configurar sus [contenedores](riodelaplata/contenedores.md).

## IoT

Todo lo que tenga dirección IP y no es una computadora.

| Equipo                           | Lugar              | Proposito                       | Red |
|----------------------------------|--------------------|---------------------------------|-----|
| Becasmart BAF-908 Flower Waterer | Balcón             | Sistema de riego automático     | DMZ |
| Wemo Mini Smart Plug             | Cuarto de servicio | Controla calentador de agua     | DMZ |
| Wemo Mini Smart Plug             | Cuarto de servicio | Controla bomba presurizadora    | DMZ |
| Google Nest Hub                  | Estancia           | Pantalla inteligente            | LAN |
| Magic Home WiFi LED Controller   | Estancia           | Controla tira led               | DMZ |
| Kasa Smart Power Strip KP303     | Estancia           | Controla ruteador LAN y ONT     | DMZ |
| Wyze Smart Plug                  | Estancia           | Controla luz globo terráqueo    | DMZ |
| Google Nest Mini                 | Estudio            | Bocina inteligente              | LAN |
| TLC TV 55" 4K UHD                | Estudio            | Televisión inteligente          | LAN |
| Google Nest Mini                 | Recámara           | Bocina inteligente              | LAN |
| Mi Air Purifier 3C               | Recámara           | Purificador de aire             | DMZ |
| Wemo Insight Smart Plug          | Recámara           | Controla y monitorea calentador | DMZ |
| Wiz DIM/5W G25 Amber             | Recámara           | Foco en lampara de piso         | DMZ |

<!--
## To-dos

- saloncorona -> Logger Receptor Alertas SAME en RPi Zero o Arduino Yun
- savoy -> Torrents y varios en RPi5
- covadonga -> TrueNAS en x86 o OpenVMS en FriendlyElec
- barbaazul -> BB Black con pantalla
- nibelungengarten -> Router
- cuatroveinte -> TBD
-->
