# DEPRECATED

| Hostname                            | LAN         | EXT           | OS                     | Arch   |
|-------------------------------------|-------------|---------------|------------------------|--------|
| [laesperanza](#laesperanza)         | 192.168.0.2 |               | Raspbian GNU/Linux 11  | ARM32  |
| [lafaena](#lafaena)                 | 192.168.0.3 |               | Raspbian GNU/Linux 11  | ARM32  |
| [multiforoalicia](#multiforoalicia) | 192.168.0.4 |               | Ubuntu 24.04           | x86/64 |
| [latita](#latita)                   | 192.168.0.5 |               | Armbian 23.11.1        | ARM64  |
| [riodelaplata](#riodelaplata)       |             |               | AWS Linux 2023         | ARM64  |

### laesperanza

Servidor local de DHCP y DNS en una **Raspberry Pi B**. Utiliza Pi-hole, un servidor DNS con bloqueo de anuncios. Como proveedor de DNS ascendente uso _Cloudfare_.

- [Pi-hole: A black hole for Internet advertisements](https://github.com/pi-hole/pi-hole/)

### lafaena

Hace streaming de audio a un minicomponente. Es una **Raspberry Pi B** ejecutando Raspotify, un cliente de Spotify.

- [Raspotify Basic Setup Guide](https://github.com/dtcooper/raspotify/wiki/Basic-Setup-Guide)
- [Raspotify on Pi v1's and Pi Zero v1.x](https://github.com/dtcooper/raspotify/wiki/Raspotify-on-Pi-v1's-and-Pi-Zero-v1.x)

### multiforoalicia

Desktop Ubuntu en una **Share MiniPC X3700m** conectada a la TV para navegar en Internet, reproducir videos, etc. Para jugar tiene RetroPie, un emulador de consolas retro.

- [RetroPie Setup](https://github.com/RetroPie/RetroPie-Setup)

### latita

- http://www.orangepi.org/orangepiwiki/index.php/Orange_Pi_3B
- https://www.armbian.com/orangepi3b/

`Armbian_23.11.1_Orangepi3b_bookworm_edge_6.6.2.img`
`linux-image-current-rockchip64=24.5.3` -> 6.6.39

- https://forum.armbian.com/topic/42698-armbian-on-orange-pi-3b-with-vendor-images-linux-66-dont-seem-to-work/

### riodelaplata

Es una instancia `t4g.small` de **AWS EC2** que hospeda contenedores para:

- Almacenar mis suscripciones a podcasts y episodios escuchados (servidor [oPodSync](https://github.com/kd2org/opodsync) para [AntennaPod](https://antennapod.org/))
- Sincronizar mis notas entre dispositivos (servidor [CouchDB](https://couchdb.apache.org/) para [LiveSync](https://github.com/vrtmrz/obsidian-livesync) de [Obsidian](https://obsidian.md/)) `#DEP`
- Conectar mi red local con servidores remotos (servidor [OpenVPN](https://openvpn.net/)) `#DEP`
- Reenviar solicitudes a contenedores y mi red local (contenedor [Nginx Proxy Manager](https://github.com/NginxProxyManager/nginx-proxy-manager)) `#DEP`

Hice *chuletas* específicas para su [instalación](riodelaplata/instalacion.md) y configuración de [contenedores](riodelaplata/contenedores.md).
