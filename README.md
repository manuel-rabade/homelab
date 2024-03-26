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

La convención es usar nombres de lugares de espacimiento para los hostname.

| Hostname                            | Proposito                                        | Red | IP          |
|-------------------------------------|--------------------------------------------------|-----|-------------|
| [lafaena](#lafaena)                 | Streamer de música                               | LAN | 192.168.0.3 |
| [multiforoalicia](#multiforoalicia) | Consola de juegos retro y reproductor multimedia | LAN | 192.168.0.4 |

### lafaena

Es una **Raspberry Pi B** con *Raspotify* para hacer streaming de audio a un minicomponente LG.

- CPU: `ARM1176JZFS @ 700MHz`
- RAM: `256 MB`
- HDD: `16 GB SD`
- OS: `Raspbian GNU/Linux 11`

**Referencias**

- [Raspotify Basic Setup Guide](https://github.com/dtcooper/raspotify/wiki/Basic-Setup-Guide)
- [Raspotify on Pi v1's and Pi Zero v1.x](https://github.com/dtcooper/raspotify/wiki/Raspotify-on-Pi-v1's-and-Pi-Zero-v1.x)

### multiforoalicia

*Desktop XFce4* en una **Share MiniPC X3700m** conectada a una TV para navegar en Internet, reproducir videos, etc. También tiene *RetroPie* para jugar *Nintendo*.

- CPU: `Intel Celeron 1037U @ 1.80GHz`
- RAM: `8 GB`
- HDD: `128 GB mSATA`
- OS: `Xubuntu 23.10`

**Referencias**

- [RetroPie Setup](https://github.com/RetroPie/RetroPie-Setup)

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

<!--
**WIP**

- balalaika
  - GCloud
- duxdevenecia
  - RPi
  - Pi Hole
  - Hacks IoT
- saloncorona
  - BB Original
  - RRDTool
  - NUT

- cuatroveinte
  - BB Black c/pantalla
- covadonga
  - TrueNAS

- riodelaplata
  - AWS
- savoy
  - RPi5

- laesperanza
- nibelungengarten
-->
