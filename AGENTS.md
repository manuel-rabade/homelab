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

- [README.md](README.md): top-level inventory of networks, computers and devices, plus the aggregated work log.
- [MAINTENANCE.md](MAINTENANCE.md): aggregated recurring-maintenance checklist.
- [hosts/](hosts/): one folder per computer (e.g. [hosts/la-esperanza/](hosts/la-esperanza/)): scripts, config files and a `README.md`.
- [cloud/](cloud/): one folder per cloud host (e.g. [cloud/balalaika/](cloud/balalaika/)): same page structure as a host, for rented VMs off the home network.
- [deprecated/](deprecated/): retired computers and configurations.

Each host's `hosts/hostname/README.md` (and each cloud host's `cloud/hostname/README.md`) is the single source of truth for that host. The `## Computadoras y Equipos`, `## Servicios Cloud` and `## Bitácora` tables in [README.md](README.md), and the sections in [MAINTENANCE.md](MAINTENANCE.md), are **aggregated views**: regenerated from the host pages, never authored directly. When you change a host page, regenerate the affected views to match. [hosts/la-esperanza/README.md](hosts/la-esperanza/README.md) is the canonical example of a host page.

## Resúmenes de sección

Every `##` section in [README.md](README.md) opens with a short summary paragraph, placed between the heading and the section's content. One or two sentences of Spanish prose giving the gist: what the section holds and its notable specifics (roles, groupings, what sits on which network). The paragraph is authored directly, even in the sections whose table is a derived view ([Computadoras y Equipos](#computadoras-y-equipos), [Servicios Cloud](#servicios-cloud), [Bitácora](#bitácora)): the table below is regenerated from the host pages, the summary above is written by hand.

Keep the summary in sync with the data it describes: whenever the table or the host pages behind it change (a host or device added, retired, moved between networks, or repurposed), update the paragraph in the same edit so it never contradicts the content below it.

## Redes

Authored directly in [README.md](README.md). Defines the network zones.

- The section summary (see [Resúmenes de sección](#resúmenes-de-sección)), which for this section also carries the note about the tailnets: one personal and the [RHED](https://rhed.xyz) one.
- A table `Zona | Segmento | Propósito | Medio | Políticas`, one row per zone.
- A `### Mapa` subsection holding an ASCII diagram of how the zones connect (only the hosts that route between networks, not every host). It comes from outside this repo: maintained in [textik.com](https://textik.com) and imported as-is, so never edit or regenerate it.

Keep zone codes in backticks. Update the table when a zone is added or removed.

## Computadoras y Equipos

The inventory table in [README.md](README.md) is **derived** from the host pages, which are the source of truth. Columns `Hostname | Propósito | Hardware | OS | Redes`, each cell taken from the matching host page:

- **Hostname** ← folder name, linked to `hosts/hostname/`.
- **Propósito** ← `Propósito:` bullet.
- **Hardware** ← `Hardware:` bullet verbatim, link included, sub-bullets dropped.
- **OS** ← `OS:` bullet verbatim, link included, sub-bullets dropped.
- **Redes** ← `Redes:` sub-bullets joined with `<br>`.

Strip the trailing period from every cell. `Redes` is plural because a host can sit on several networks. When you add or retire a host, update this table.

### Host page

Each host has a folder `hosts/hostname/` whose `README.md` is the source of truth for that host. Every host page has the same structure, in this order. The identity bullets and every `##` section are **always present**; an empty `##` section holds the line `Nada por ahora.` instead of being omitted.

1. `# hostname`: matches the folder name.
2. **Identity bullets**, in order, the fields the inventory table mirrors:
   - `- Propósito:` short role, one phrase.
   - `- Hardware:` the specific machine model, linked; internal components as 2-space sub-bullets when relevant, ordered processor, then RAM, then storage, then networking:
     - Processor: a plain sub-bullet naming the model and key specs (e.g. `Broadcom BCM2712 (Cortex-A76 quad-core 2.4 GHz)`).
     - RAM: a plain sub-bullet reading `<capacity> <type> RAM` (e.g. `8 GB LPDDR4X RAM`).
     - Storage: `<capacity/type> <interface> <model>`. When the slot holds a specific device model worth naming, name it inline and linked on the same line (e.g. `32 GB microSDHC [SanDisk Ultra](url)`). Exception: a multi-disk array can't inline several models, so it stays a bare line with each linked model nested one level deeper (e.g. `2 × 16 TB SATA RAID 1` with `Toshiba N300` and `WD Gold` as sub-bullets).
     - Networking: one sub-bullet per interface or port group, wired before wireless, the speed only. Prefix the port count only when there is more than one (`Ethernet 1G`, `2 Ethernet 2.5G`, `4 Ethernet 1G`), or give the Wi-Fi 802.11 standards (`Wi-Fi 802.11ax/b/g/n`).
   - `- OS:` name and version, linked when there's an official page.
   - `- Redes:` 2-space sub-bullets, one per network: `` `ZONA` IP `` for local zones, `` `VPN` tailnet `` / `` `RHED` tailnet `` for overlays (the tailnet, not the Tailscale/Headscale service running it).
3. `## Servicios`: what the host runs. One bullet per service, each a full sentence ending in a period. A service another host consumes takes a sub-bullet per consumer, `- [hostname](../hostname/): qué hace por ese host.`, also a full sentence with its period. See [hosts/barba-azul/README.md](hosts/barba-azul/README.md).
4. `## Referencias`: external links (official docs, repos).
5. `## Archivos de configuración y scripts`: the host's configuration and scripts - repo files in the folder (filename linked), relevant on-host config paths, and the paths a script reads or writes when they matter for maintenance (its token file, its log), all backticked and each with a short description. Write on-host paths with `~/` when they sit in a user's home, absolute otherwise.
6. `## Mantenimiento`: recurring service checklist, task definitions only, boxes left unchecked. Aggregated into [MAINTENANCE.md](MAINTENANCE.md). Each task names where it is done:
   - Shell host: an inline command (`` Tarea: `comando` ``).
   - GUI appliance: point at the UI instead - a single app or section woven in with a preposition (`` Revisar estado en `Almacenamiento e instantáneas` ``), or a multi-step navigation path as `` Tarea: `Menú → Submenú → Opción` ``. See [hosts/el-respiro/README.md](hosts/el-respiro/README.md) for a GUI-appliance example.
   - Trailing period depends on the kind of line, not how deeply it is nested. A task (a checkbox line, `- [ ]`) is a short instruction and takes no period, even when nested under another task. A plain sub-bullet (`-`, no checkbox) that adds a note about its task is a full sentence and ends with a period. Example in [hosts/el-respiro/README.md](hosts/el-respiro/README.md): the nested SMART `- [ ]` checkbox has no period, while the `-` note beneath it listing which attributes to watch does.
7. `## Pendientes`: one-off or future tasks for this host.
8. `## Bitácora`: work log, newest entry on top. Each entry is `### YYYY-MM-DD título corto` followed by a summary; commands go in fenced code blocks. Every entry also gets a row in the [Bitácora](#bitácora) table of [README.md](README.md): add it in the same edit that adds the entry.

Template:

```markdown
# hostname

- Propósito: Rol breve.
- Hardware: [Modelo](url)
  - Componente adicional si aplica
- OS: [Nombre](url) versión
- Redes:
  - `ZONA` 192.168.x.y
  - `VPN` tailnet

## Servicios

- Qué corre el host.

## Referencias

- [Enlace oficial](url)

## Archivos de configuración y scripts

- [script.sh](script.sh): descripción breve.
- `/etc/ejemplo.conf`: qué configura.

## Mantenimiento

- [ ] Tarea con comando: `comando`

## Pendientes

Nada por ahora.

## Bitácora

### 2026-06-24 título corto

Resumen del trabajo realizado.
```

## Dispositivos IoT y Multimedia

Authored directly in [README.md](README.md). Devices that aren't full hosts (no folder). Table `Dispositivo | Propósito | Red | Hostname | IP`. The column is `Red` (singular) because each device sits on exactly one network, unlike the computers table's `Redes` (plural). Leave `Hostname` and `IP` blank for devices without a reserved address.

## Servicios Cloud

The `## Servicios Cloud` table in [README.md](README.md) is **derived** from the cloud host pages, the same source-of-truth model as [Computadoras y Equipos](#computadoras-y-equipos). A cloud host is a rented VM, not a machine on the home network, so it lives in its own `cloud/hostname/` folder and its identity bullets differ: no physical `Hardware`, no zone-based `Redes`. Columns `Hostname | Propósito | Proveedor | Instancia | OS | IP`, each cell taken from the matching cloud host page:

- **Hostname** ← folder name, linked to `cloud/hostname/`.
- **Propósito** ← `Propósito:` bullet.
- **Proveedor** ← `Proveedor:` bullet verbatim, link included.
- **Instancia** ← `Instancia:` bullet verbatim.
- **OS** ← `OS:` bullet verbatim, link included.
- **IP** ← `IP:` bullet.

Strip the trailing period from every cell. When you add or retire a cloud host, update this table.

### Cloud host page

Each cloud host has a folder `cloud/hostname/` whose `README.md` is its source of truth. It follows the same section order and rules as a [host page](#host-page), and its `## Mantenimiento` is aggregated into [MAINTENANCE.md](MAINTENANCE.md) alongside the computers. Only the identity bullets differ: `Proveedor`, `Instancia` and a plain `IP:` bullet replace the physical `Hardware` and the zone-based `Redes`.

Template:

```markdown
# hostname

- Propósito: Rol breve.
- Proveedor: [Proveedor](url)
- Instancia: `tipo`
- OS: [Nombre](url) versión
- IP: 203.0.113.1

## Servicios

- Qué hospeda.

## Referencias

- [Enlace oficial](url)

## Archivos de configuración y scripts

- `/etc/ejemplo.conf`: qué configura.

## Mantenimiento

- [ ] Tarea con comando: `comando`

## Pendientes

Nada por ahora.

## Bitácora

### 2026-06-24 título corto

Resumen del trabajo realizado.
```

## Bitácora

The `## Bitácora` table in [README.md](README.md) is a **derived** view of the `## Bitácora` entries of every host and cloud page: one row per entry, all hosts merged into a single timeline, newest first. It sits at the bottom of [README.md](README.md), after [Servicios Cloud](#servicios-cloud), because it grows without bound and the inventory is what the page is for. Columns `Fecha | Host | Descripción`:

- **Fecha** ← the `YYYY-MM-DD` of the entry heading, linked to that heading's anchor in the host page (e.g. `[2026-08-22](hosts/covadonga/README.md#2026-08-22-instalación-de-covadonga)`). The anchor is the whole heading text lowercased, spaces turned into hyphens, accents kept and punctuation dropped, so `### 2026-06-23 audio roto por kernel 6.18` anchors as `#2026-06-23-audio-roto-por-kernel-618` and the italics of `### 2026-07-04 Conexión a la *hipermegaRHED*` vanish in `#2026-07-04-conexión-a-la-hipermegarhed`.
- **Host** ← folder name, linked to `hosts/hostname/` or `cloud/hostname/`, the same link text as the inventory tables.
- **Descripción** ← two sentences at most, written for this table rather than copied from the entry: what was done and the part worth remembering. Keep the prose conventions of the entry itself, backticks for technical terms and italics for *hipermegaRHED*.

Rows carry no trailing period. Two entries on the same host and date sort by the order they appear on the host page. When an entry is added, edited or removed, update this table in the same edit.

## Maintenance checklist

[MAINTENANCE.md](MAINTENANCE.md) is a derived view: the recurring service checklist for all hosts. It lists **every** host, computers first then cloud hosts, one `## hostname` section in the same order as the `## Computadoras y Equipos` and `## Servicios Cloud` tables, copying that host's `## Mantenimiento` verbatim (including nested checkboxes and fenced commands). A host with no recurring tasks shows `Nada por ahora.`.

Checked boxes (`[x]`) are ephemeral working state for a service pass; never sync them back to the host page. Task lists live unchecked in git on both sides.

## Writing conventions

- **Language**:
  - **Spanish**: only in the documentation prose: `README.md`, `MAINTENANCE.md` and the per-host `README.md` files. This is what a human reads.
  - **English**: everything else: this `AGENTS.md`, commit and PR messages, config files, scripts, code, inline commands, code comments, and file/folder names.
  - Technical vocabulary stays in English inside Spanish prose when that's the norm (router, hostname, RAID 1, NAS). Literal labels stay as written (`Propósito:`, `Redes:`, `## Bitácora`, ...).
  - When writing Spanish prose, translate «repository» as «depósito», not «repositorio».
- **Dashes**: use a regular hyphen (`-`); never em dashes (`—`) or en dashes (`–`).
- **Lines**: let prose flow, one line per paragraph; don't hard-wrap by hand.
- **Heading hierarchy**: host and cloud pages go `# hostname` then `## section`. Root `README.md` goes `## category` for its sections, with one exception: the `### Mapa` subsection under `## Redes`. Other `### name` subsections appear only inside host and cloud pages (`## Bitácora` entries). A `## Bitácora` entry long enough to need parts breaks into `#### name` subsections; bold text is never used as a heading.
- **No frontmatter**: files start straight with the content.
- **Banner**: the three top-level docs open with an ASCII-art title (figlet) instead of an `#` heading, each in its own font: `larry3d` for `README.md`, `doom` for `MAINTENANCE.md`, `terminus` for `AGENTS.md`. Host pages use a plain `# hostname`.
- **Backticks** for technical terms: network zones (`LAN`, `GUEST`, `IOT`, `MEDIA`, `SBC`), CIDR segments and IPs, hostnames, file paths, inline commands, and GUI app names and menu navigation paths (`App Center`, `Panel de control → Estado del sistema`).
- **Italics** (`*…*`): only for proper names, never for general emphasis. Two cases: (a) *hipermegaRHED*, the proper name of the `RHED` overlay network - used in narrative prose (Bitácora, and the Servicios/Pendientes items tied to it); in structured fields use the backticked zone code `` `RHED` `` instead (`Redes` bullets, `Mantenimiento` tasks, the README `## Redes` table and the inventory `Redes` column), the two being synonyms. (b) The codename of a planned experiment or project, e.g. `*Museo de SBCs*`, `*Disco duro hipermegaRHED*`; when the codename embeds the network name the whole phrase stays italic.
- **Links**: use the bare filename or path as link text, without backticks (`[README.md](README.md)`). Internal references by anchor; external links to official documentation or repositories under `## Referencias`. A page may still link its own hosted sites or services inline in `## Servicios`.
- **Sub-bullets** nest 2 spaces.
- **Tables** (markdown pipes) for inventories; `<br>` to stack multiple values in one cell.
- **Lists** with `-`; checkboxes `- [ ]` for maintenance and pending tasks.
- **Fenced code blocks** for multi-line commands, scripts or configuration; inline backticks for a single command. Warn when an opening fence has no language tag (`bash` for shell, `yaml`, `markdown`, ...); the only blocks that stay language-less are the figlet banners of the three top-level docs and the imported ASCII network diagram in `README.md`.
- **Tone**: concise and technical; no filler. OS versions and hardware models always specific and linked.

## Commits

English, like everything outside the documentation prose. A commit reads:

- **Subject**: one line in the imperative mood, capitalized, no trailing period, kept short (around 50-70 characters). It names the change as a whole (`Add per-section summaries to README and document the convention`).
- **Body**: separated from the subject by a blank line, present whenever the change needs explaining. Unlike the documentation prose, commit bodies **are** hard-wrapped by hand, at around 72 columns. Open with a sentence on the what and why, then continue as prose paragraphs or a `-` bullet list. When several files or areas change, lead each bullet with the one it touches (`README.md:`, `AGENTS.md:`, `cloud/balalaika/README.md:`). Backtick technical terms as in the docs (`### Mapa`, `IOT`, `git -C ~ pull`).
- **Trailer**: after a blank line, a `Co-Authored-By:` trailer crediting the assistant that helped write the change, in git's `Name <email>` form (e.g. `Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>`).

PR messages follow the same voice.
