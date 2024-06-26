# Contenedores `riodelaplata`

_Chuleta_ para configurar los contenedores de `riodelaplata`.

## CouchDB para LiveSync de Obisidian

Referencias:

- https://github.com/vrtmrz/obsidian-livesync
- https://github.com/vrtmrz/obsidian-livesync/blob/main/docs/setup_own_server.md
- https://github.com/vrtmrz/self-hosted-livesync-server/blob/main/docker-compose.yml
- https://docs.vrtmrz.net/LiveSync/procedures/Setup+Self-hosted+LiveSync+to+secondary+or+subsequent+devices

Pasos:

1. Crear `.env` (ver [dot.env](dot.env)), `/docker/couchdb` y configurar proxy

2. Levantar contenedor: `docker compose -f docker-compose.yml -f docker-compose.prod.yml up`

3. Inicializar BD:

```
export hostname=https://couchdb.example
export username=manuel
export password=
curl -s https://raw.githubusercontent.com/vrtmrz/obsidian-livesync/main/utils/couchdb/couchdb-init.sh | bash
```

4. Generar URI:

```
export hostname=https://couchdb.example
export database=manuel-notes
export passphrase=
deno run -A https://raw.githubusercontent.com/vrtmrz/obsidian-livesync/main/utils/flyio/generate_setupuri.ts
```

5. Configurar Obisidian

## oPodSync para AntennaPod

Referencias:

- https://github.com/kd2org/opodsync

Pasos:

1. Crear `/docker/opodsync` y configurar proxy

2. Clonar `https://github.com/kd2org/opodsync`

3. Copiar [opodsync/docker-compose.yml](opodsync/docker-compose.yml) y [opodsync/docker-compose.prod.yml](podsync/docker-compose.prod.yml) al deposito `opodsync`

4. Levantar contenedor: `docker compose -f docker-compose.yml -f docker-compose.prod.yml up`

## Nginx Proxy Manager

Referencias:

- https://github.com/NginxProxyManager/nginx-proxy-manager

Pasos:

1. Crear `/docker/nginx-proxy-manager`

2. Levantar contenedor: `docker compose -f docker-compose.yml -f docker-compose.prod.yml up`

3. Configurar en [proxy.example:81](http://proxy.example:81)
