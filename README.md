```
 __                                  ___             __
/\ \                                /\_ \           /\ \
\ \ \___     ___     ___ ___      __\//\ \      __  \ \ \____
 \ \  _ `\  / __`\ /' __` __`\  /'__`\\ \ \   /'__`\ \ \ '__`\
  \ \ \ \ \/\ \L\ \/\ \/\ \/\ \/\  __/ \_\ \_/\ \L\.\_\ \ \L\ \
   \ \_\ \_\ \____/\ \_\ \_\ \_\ \____\/\____\ \__/.\_\\ \_,__/
    \/_/\/_/\/___/  \/_/\/_/\/_/\/____/\/____/\/__/\/_/ \/___/
```

Documentacion de mi infraestructura casera. `#WIP4EVER`

## Red

El objetivo es separar los dispositivos _inseguros_ en la **DMZ** de los _confiables_ en la **LAN**. El plan a futuro es migrar de la doble NAT a redes propiamente enrutadas y filtradas.

```
                                                +--------+
                                                | AP DMZ |
                                                +--------+
                                                     |
                                                     |
+----------------+    +---------------+    +------------------+    +------------+
|      LAN       |----| Router/AP LAN |----|       DMZ        |----| Router ISP |
| 192.168.0.0/24 |    +---------------+    | 192.168.100.0/24 |    +------------+
+----------------+                         +------------------+
```

| Equipo         | Proposito                      | IP                                    |
|----------------|--------------------------------|---------------------------------------|
| Archer C2300   | Ruteador y punto de acceso LAN | [192.168.0.1](http://192.168.0.1)     |
| Huawei HG8245H | Ruteador proveedor de Internet | [192.168.100.1](http://192.168.100.1) |
| Netgear AV200  | Punto de acceso DMZ            | [192.168.100.3](http://192.168.100.3) |

## Computadoras

Dispositivos del hogar que corren Linux. No incluye equipos personales (laptops o teléfonos) ni dispositivos _comerciales_ con Linux empotrado (Google Nest o TV con Android). La convención para los hostname es usar nombres de lugares de espacimiento.

| Hostname                            | Red      | IP            | OS                     | CPU    |
|-------------------------------------|----------|---------------|------------------------|--------|
| [balalaika](#balalaika)             | Internet | 34.67.134.108 | Debian GNU/Linux 12    | x86/64 |
| [laesperanza](#laesperanza)         | LAN      | 192.168.0.2   | Raspbian GNU/Linux 11  | ARMv6  |
| [lafaena](#lafaena)                 | LAN      | 192.168.0.3   | Raspbian GNU/Linux 11  | ARMv6  |
| [multiforoalicia](#multiforoalicia) | LAN      | 192.168.0.4   | Xubuntu 23.10          | x86/64 |

### balalaika

Servidor web NGINX con PHP 8.2 en una instancia `e2-micro` de **Google Compute Engine**.

### laesperanza

Servidor local de DHCP y DNS en una **Raspberry Pi B**. Utiliza Pi-hole, un servidor DNS con bloqueo de anuncios. Como proveedor de DNS ascendente estoy probando CloudFare.

- [Pi-hole: A black hole for Internet advertisements](https://github.com/pi-hole/pi-hole/)

### lafaena

Hace streaming de audio a un minicomponente. Es una **Raspberry Pi B** ejecutando Raspotify, un cliente de Spotify.

- [Raspotify Basic Setup Guide](https://github.com/dtcooper/raspotify/wiki/Basic-Setup-Guide)
- [Raspotify on Pi v1's and Pi Zero v1.x](https://github.com/dtcooper/raspotify/wiki/Raspotify-on-Pi-v1's-and-Pi-Zero-v1.x)

### multiforoalicia

Desktop XFce4 en una **Share MiniPC X3700m** conectada a la TV para navegar en Internet, reproducir videos, etc. Para jugar tiene RetroPie, un emulador de consolas retro.

- [RetroPie Setup](https://github.com/RetroPie/RetroPie-Setup)

<!--
- riodelaplata -> Servidor docker en AWS
- duxdevenecia -> Hacks IoT en BB
- cuatroveinte -> VPN/Cacti/NUT en OPi3B
- saloncorona -> Logger Receptor Alertas SAME en RPi Zero o Yun
- savoy -> Torrents y varios en RPi5
- covadonga -> TrueNAS en x86 o OpenVMS en FriendlyElec
- barbaazul -> BB Black con pantalla
- nibelungengarten -> TBD
-->

## IoT

Todo lo que tenga dirección IP y no es una computadora.

| Equipo                           | Lugar              | Proposito                       | Red |
|----------------------------------|--------------------|---------------------------------|-----|
| Becasmart BAF-908 Flower Waterer | Balcón             | Sistema de riego automático     | DMZ |
| Wemo Mini Smart Plug             | Cuarto de servicio | Controla calentador de agua     | DMZ |
| Wemo Mini Smart Plug             | Cuarto de servicio | Controla bomba presurizadora    | DMZ |
| Google Nest Hub                  | Estancia           | Pantalla inteligente            | LAN |
| Magic Home WiFi LED Controller   | Estancia           | Controla tira led               | DMZ |
| Wiz DIM/5W G25 Amber             | Estancia           | Foco lampara de piso            | DMZ |
| Wyze Smart Plug                  | Estancia           | Controla luz globo terráqueo    | DMZ |
| Google Nest Mini                 | Estudio            | Bocina inteligente              | LAN |
| TLC TV 55" 4K UHD                | Estudio            | Televisión inteligente          | LAN |
| Google Nest Mini                 | Recámara           | Bocina inteligente              | LAN |
| Mi Air Purifier 3C               | Recámara           | Purificador de aire             | DMZ |
| Wemo Insight Smart Plug          | Recámara           | Controla y monitorea calentador | DMZ |
