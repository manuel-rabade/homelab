# balalaika

- Propósito: Servidor público.
- Proveedor: [Google Cloud](https://cloud.google.com)
- Instancia: `e2-micro`
- OS: [Debian](https://www.debian.org) 12 (bookworm)
- IP: 34.67.134.108

## Servicios

- Hospeda sitios web.
  - Página personal: [rabade.net](https://rabade.net) y [rabade.mx](https://rabade.mx)
  - Sitio de experimentos: [rabade.dev](https://rabade.dev)
  - Sitio pendiente: [rabade.com](https://rabade.com)
  - Fotoetnografías de la pandemia: [fotoetnografiasdelapandemia.com](https://fotoetnografiasdelapandemia.com)
- Servidor de [oPodSync](https://ops.rabade.net) para respaldar mi historial de podcasts escuchados en AntennaPod.
- Aloja depósitos Git personales.

## Referencias

- [oPodSync](https://github.com/kd2org/opodsync)
- [AntennaPod](https://antennapod.org)

## Archivos de configuración y scripts

Nada por ahora.

## Mantenimiento

- [ ] Revisar uso de disco: `df -h`
- [ ] Actualizar dotfiles (`root` y `manuel`): `git -C ~ pull`
- [ ] Actualizar paquetes: `apt update && apt upgrade`
- [ ] Reiniciar: `reboot`
- [ ] Verificar estado de NGINX: `systemctl status nginx`
- [ ] Revisar la vigencia de los certificados SSL: `certbot certificates`
- [ ] Verificar que los sitios web respondan correctamente
- [ ] Verificar que AntennaPod sincronice con oPodSync

## Pendientes

- [ ] Conectar a Tailnet `VPN`

## Bitácora

Nada por ahora.
