# Contenedores `riodelaplata`

_Chuleta_ para configurar los contenedores de `riodelaplata`.

## CouchDB para LiveSync de Obisidian

Referencias:

- https://github.com/vrtmrz/obsidian-livesync
- https://github.com/vrtmrz/obsidian-livesync/blob/main/docs/setup_own_server.md
- https://github.com/vrtmrz/self-hosted-livesync-server/blob/main/docker-compose.yml
- https://docs.vrtmrz.net/LiveSync/procedures/Setup+Self-hosted+LiveSync+to+secondary+or+subsequent+devices

Pasos:

1. Configurar `.env` ver [dot.env](dot.env)

2. Levantar contenedor: `docker compose -f docker-compose.yml -f docker-compose.prod.yml up`

3. Inicializar BD:

```
export hostname=localhost:5984
export username=goojdasjdas
export password=kpkdasdosakpdsa
curl -s https://raw.githubusercontent.com/vrtmrz/obsidian-livesync/main/utils/couchdb/couchdb-init.sh | bash
```

4. Generar URI:

```
export hostname=https://tiles-photograph-routine-groundwater.trycloudflare.com
export database=obsidiannotes
export passphrase=dfsapkdjaskdjasdas
deno run -A https://raw.githubusercontent.com/vrtmrz/obsidian-livesync/main/utils/flyio/generate_setupuri.ts
```

5. Configurar Obisidian
