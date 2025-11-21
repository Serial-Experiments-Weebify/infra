# Infra VM

## Multipass deploy

1. Make sure you have `multipass`, `caddy` and `make` installed.

2. Apply the weebnet.yaml with `netplan` (copy to `/etc/netplan/` first).

3. Copy `Caddyfile` to `/etc/caddy/Caddyfile` (modify domains if needed) and start Caddy (`systemctl enable --now caddy`).

4. Copy & modify the .env file in `./multipass/files/` as needed.

5. Run `make up` from `./multipass/`.

6. profit???

## Vagrant deploy

1. Make sure you have `vagrant`, `virtualbox`, `caddy` installed.

2. Copy `Caddyfile` to `/etc/caddy/Caddyfile` (modify domains if needed) and start Caddy (`systemctl enable --now caddy`).

3. Copy & modify the .env file in `./vagrant/weebify/` as needed.

4. Run `vagrant up` from `./vagrant/`.

5. profit???