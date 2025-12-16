# Simple dedicated Server for Sapiens using Docker
## Installation Options

This project supports two installation methods:

### Option A — Docker Compose (Recommended)
Best for:
- Developers
- VPS / Linux hosts
- Advanced users
- Reproducible setups

Use the provided `docker-compose.yml`.


---

### Option B — Unraid Template
Best for:
- Unraid users
- GUI-based setup
- One-click installs

An Unraid-compatible XML template is provided in:

Import the template via **Unraid → Docker → Add Container → Template URL**.

Both methods use the same entrypoint and configuration logic.

## Build image yourself

To build the image yourself use `docker build .`

## Contribute

If you have anything to improve this repository, feel free to add a new issue/discussion with feedback

## Public Server Notes

This container explicitly launches Sapiens in **PUBLIC** mode using the `-public` flag.

If the server starts in LAN mode, it will **not appear in the public server list**
even though direct IP connections still work.

Environment variables:
- `PUBLIC_MODE=true` (required for listing)
- `UDP_PORT=16161`
- `BUGREPORT_OPTIN=true` (recommended)

After first boot, allow up to **24 hours** for public listing propagation.




-------------------------------------------------
🐳 Deployment (Unraid / Docker)
Build and start the server

From the root of your cloned repository:
___________________
docker compose build --no-cache
docker compose up -d
___________________

This will:

Build the Sapiens dedicated server image

Start the container in public server mode

Persist world data using a Docker volume

View server logs

To follow the server startup and runtime logs:

docker logs -f sapiens
___________________
✅ Verify public server mode

On startup, confirm that the log output does NOT contain:
___________________
Starting LAN server
___________________

If this message appears, the server has started in LAN/private mode and will not appear in the public server list (even though direct IP connections may still work).

This setup explicitly forces public mode, so seeing this message would indicate an upstream engine behavior rather than a container or configuration issue.
___________________
🌍 Public server listing

Once running:

The server should accept direct IP connections immediately

Appearance in the public server list may take minutes to several hours

In some cases, the master server cache can take up to 24 hours to refresh

This delay is normal and does not indicate a networking or configuration problem.
