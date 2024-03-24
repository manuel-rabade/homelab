```
 __                                  ___             __
/\ \                                /\_ \           /\ \
\ \ \___     ___     ___ ___      __\//\ \      __  \ \ \____
 \ \  _ `\  / __`\ /' __` __`\  /'__`\\ \ \   /'__`\ \ \ '__`\
  \ \ \ \ \/\ \L\ \/\ \/\ \/\ \/\  __/ \_\ \_/\ \L\.\_\ \ \L\ \
   \ \_\ \_\ \____/\ \_\ \_\ \_\ \____\/\____\ \__/.\_\\ \_,__/
    \/_/\/_/\/___/  \/_/\/_/\/_/\/____/\/____/\/__/\/_/ \/___/
```

Documentacion de mi infraestructura casera. #WIP4EVER

## Arquitectura

```
+--------------------+                                 +----------------------+
|                    |                                 |                      |
|        LAN         |      +-------------------+      |         DMZ          |       +-------------+
|   192.168.0.0/24   |------|   Router/AP LAN   |------|   192.168.100.0/24   |-------|   ISP ONT   |
|                    |      +-------------------+      |                      |       +-------------+
+--------------------+                                 +----------------------+
                                                                   |
                                                                   |
                                                            +------------+
                                                            |   AP DMZ   |
                                                            +------------+
```

## Computadoras

La convención es usar nombres de lugares de espacimiento para los hostname.

| Hostname                            | Proposito                                        | IP          |
|-------------------------------------|--------------------------------------------------|-------------|
| [lafaena](#lafaena)                 | Streamer de música                               | 192.168.0.3 |
| [multiforoalicia](#multiforoalicia) | Consola de juegos retro y reproductor multimedia | 192.168.0.4 |

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

## Dispositivos de red

| Equipo         | Proposito                      | IP                                    |
|----------------|--------------------------------|---------------------------------------|
| Archer C2300   | Ruteador y punto de acceso LAN | [192.168.0.1](http://192.168.0.1)     |
| Huawei HG8245H | ONT de proveedor de Internet   | [192.168.100.1](http://192.168.100.1) |
| Netgear AV200  | Punto de acceso DMZ            | [192.168.100.2](http://192.168.100.2) |

## IoT

Todo lo que tenga dirección IP y no es una computadora.

### Cuarto de servicio

- Wemo Mini Smart Plug x 2

### Estancia

- Google Nest Hub
- Magic Home WiFi LED Controller
- Wiz Wi-Fi DIM/5W G25 Amber 920 E26 6/1PF
- Wyze Smart Plug

### Estudio

- Google Nest Mini
- TLC TV 55" 4K UHD

### Recámara

- Google Nest Mini
- Mi Air Purifier 3C
- Wemo Insight Smart Plug

### Terraza

- Becasmart Smart Watering Device BAF-908

<!--
## WIP

### balalaika

- GCloud

### covadonga

- NAS

### cuatroveinte

- BB Black

### duxdevenecia

- RPi (Pi Hole)

### laesperanza

- TBD

### nibelungengarten

- TBD

### riodelaplata

- AWS

### saloncorona

- BB Original

### savoy

- RPi5
-->
