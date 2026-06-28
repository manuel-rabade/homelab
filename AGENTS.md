```
                          █
 ▀▀▀▄ ▄▀▀▀█ ▄▀▀▀▄ █▀▀▀▄  ▀█▀  ▄▀▀▀▀
▄▀▀▀█ █   █ █▀▀▀▀ █   █   █    ▀▀▀▄
▀▄▄▄█ ▀▄▄▄█ ▀▄▄▄▄ █   █   ▀▄▄ ▄▄▄▄▀
       ▄▄▄▀
```

Guide for maintaining this repository's documentation. Read it before adding or modifying content to keep the existing style and format.

## Overview

This repository is the source of truth for my home infrastructure.

- [README.md](README.md): top-level inventory of networks, computers and devices.
- [MAINTENANCE.md](MAINTENANCE.md): aggregated recurring-maintenance checklist.
- One folder per computer (e.g. [la-esperanza/](la-esperanza/)): scripts, config files and a `README.md`.
- [deprecated/](deprecated/): retired computers and configurations.

Each host's `hostname/README.md` is the single source of truth for that host. The `## Computadoras y equipos` table in [README.md](README.md) and [MAINTENANCE.md](MAINTENANCE.md) are **aggregated views**: regenerated from the host pages, never authored directly. When you change a host page, regenerate both to match. [la-esperanza/README.md](la-esperanza/README.md) is the canonical example of a host page.

## Redes

Authored directly in [README.md](README.md). Defines the network zones.

- A table `Zona | Segmento | Propósito | Medio | Políticas`, one row per zone.
- An ASCII diagram showing how the zones connect; include only the hosts that route between networks, not every host.
- A prose note about the Tailscale networks.

Keep zone codes in backticks. Update the table and the diagram together when a zone is added or removed.

## Computadoras y equipos

The inventory table in [README.md](README.md) is **derived** from the host pages, which are the source of truth. Columns `Hostname | Propósito | Hardware | OS | Redes`, each cell taken from the matching host page:

- **Hostname** ← folder name, linked to `hostname/`.
- **Propósito** ← `Propósito:` bullet.
- **Hardware** ← `Hardware:` bullet verbatim, link included, sub-bullets dropped.
- **OS** ← `OS:` bullet verbatim, link included, sub-bullets dropped.
- **Redes** ← `Redes:` sub-bullets joined with `<br>`.

Strip the trailing period from every cell. `Redes` is plural because a host can sit on several networks. When you add or retire a host, update this table and the `## Redes` diagram as needed.

### Host page

Each host has a folder `hostname/` whose `README.md` is the source of truth for that host. Every host page has the same structure, in this order. The identity bullets and every `##` section are **always present**; an empty `##` section holds the line `Nada por ahora.` instead of being omitted.

1. `# hostname`: matches the folder name.
2. **Identity bullets**, in order, the fields the inventory table mirrors:
   - `- Propósito:` short role, one phrase.
   - `- Hardware:` primary device, linked; components as 2-space sub-bullets when relevant.
   - `- OS:` name and version, linked when there's an official page.
   - `- Redes:` 2-space sub-bullets, one per network: `` `ZONA` IP `` for local zones, `` `VPN` Tailscale `` / `` `RHED` Tailscale `` for overlays.
3. `## Servicios`: what the host runs.
4. `## Referencias`: external links (official docs, repos).
5. `## Archivos de configuración y scripts`: index of the files in the folder, one line per file, filename linked plus a short description.
6. `## Mantenimiento`: recurring service checklist, task definitions only, boxes left unchecked. Aggregated into [MAINTENANCE.md](MAINTENANCE.md).
7. `## Pendientes`: one-off or future tasks for this host.
8. `## Bitácora`: work log, newest entry on top. Each entry is `### YYYY-MM-DD título corto` followed by a summary; commands go in fenced code blocks.

Template:

```markdown
# hostname

- Propósito: Rol breve.
- Hardware: [Modelo](url)
  - Componente adicional si aplica
- OS: [Nombre](url) versión
- Redes:
  - `ZONA` 192.168.x.y
  - `VPN` Tailscale

## Servicios

- Qué corre el host.

## Referencias

- [Enlace oficial](url)

## Archivos de configuración y scripts

- [script.sh](script.sh): descripción breve.

## Mantenimiento

- [ ] Tarea con comando: `comando`

## Pendientes

Nada por ahora.

## Bitácora

### 2026-06-24 título corto

Resumen del trabajo realizado.
```

### Maintenance checklist

[MAINTENANCE.md](MAINTENANCE.md) is a derived view: the recurring service checklist for all hosts. It lists **every** host, one `## hostname` section in the same order as the inventory table, copying that host's `## Mantenimiento` verbatim (including nested checkboxes and fenced commands). A host with no recurring tasks shows `Nada por ahora.`.

Checked boxes (`[x]`) are ephemeral working state for a service pass; never sync them back to the host page. Task lists live unchecked in git on both sides.

## Dispositivos IoT y multimedia

Authored directly in [README.md](README.md). Devices that aren't full hosts (no folder). Table `Dispositivo | Propósito | Red | Hostname | IP`. The column is `Red` (singular) because each device sits on exactly one network, unlike the computers table's `Redes` (plural). Leave `Hostname` and `IP` blank for devices without a reserved address.

## Cloud

Authored directly in [README.md](README.md). A `Hostname | IP` table, followed by a `### hostname` block per host with bullets (provider, instance type, OS, what it hosts).

## Writing conventions

- **Language**:
  - **Spanish**: only in the documentation prose: `README.md`, `MAINTENANCE.md` and the per-host `README.md` files. This is what a human reads.
  - **English**: everything else: this `AGENTS.md`, commit and PR messages, config files, scripts, code, inline commands, code comments, and file/folder names.
  - Technical vocabulary stays in English inside Spanish prose when that's the norm (router, hostname, RAID 1, NAS). Literal labels stay as written (`Propósito:`, `Redes:`, `## Bitácora`, ...).
  - When writing Spanish prose, translate «repository» as «depósito», not «repositorio».
- **Dashes**: use a regular hyphen (`-`); never em dashes (`—`) or en dashes (`–`).
- **Lines**: let prose flow, one line per paragraph; don't hard-wrap by hand.
- **Heading hierarchy**: host pages go `# hostname` then `## section`. Root `README.md` goes `## category`, with `### name` only for entries that have no own page (e.g. under `## Cloud`).
- **No frontmatter**: files start straight with the content.
- **Banner**: the three top-level docs open with an ASCII-art title (figlet) instead of an `#` heading, each in its own font: `larry3d` for `README.md`, `doom` for `MAINTENANCE.md`, `terminus` for `AGENTS.md`. Host pages use a plain `# hostname`.
- **Backticks** for technical terms: network zones (`LAN`, `GUEST`, `IOT`, `MEDIA`, `SBC`), CIDR segments and IPs, hostnames, file paths and inline commands.
- **Links**: use the bare filename or path as link text, without backticks (`[README.md](README.md)`). Internal references by anchor; external links to official documentation or repositories under `## Referencias`.
- **Sub-bullets** nest 2 spaces.
- **Tables** (markdown pipes) for inventories; `<br>` to stack multiple values in one cell.
- **Lists** with `-`; checkboxes `- [ ]` for maintenance and pending tasks.
- **Fenced code blocks** for multi-line commands, scripts or configuration; inline backticks for a single command.
- **Tone**: concise and technical; no filler. OS versions and hardware models always specific and linked.
