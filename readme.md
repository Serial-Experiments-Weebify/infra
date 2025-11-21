# Weebify infra (virtualization)
[Main repo](https://github.com/Serial-Experiments-Weebify/weebify/tree/devops) | 
[Encodeher repo](https://github.com/Serial-Experiments-Weebify/encodeher) 

## Multipass

Quite a struggle to get working mostly due to:

- networking 
- apt module stopped importing keys from keyserver???

Also quite a hack since we use a bash script to preprocess (`##include <file>`) the `cloud-config.yml`.

### Deploy

1. Make sure you have `multipass`, `caddy` and `make` installed.

2. Apply the weebnet.yaml with `netplan` (copy to `/etc/netplan/` first).

3. Copy `Caddyfile` to `/etc/caddy/Caddyfile` (modify domains if needed) and start Caddy (`systemctl enable --now caddy`).

4. Copy & modify the .env file in `./multipass/files/` as needed.

5. Run `make up` from `./multipass/`.

6. profit???

## Vagrant

Nothing special, just mounts the compose stacks installs docker and runs them.

### Deploy

1. Make sure you have `vagrant`, libvirt dependencies and `caddy` installed.

2. `vagrant plugin install vagrant-libvirt` and add youself to the `libvirt` group.

3. Copy `Caddyfile` to `/etc/caddy/Caddyfile` (modify domains if needed) and start Caddy (`systemctl enable --now caddy`).

4. Copy & modify the .env file in `./vagrant/weebify/` as needed.

5. Run `vagrant up` from `./vagrant/`.

6. profit???

## Test scenario:

- Open configured domain in browser
- Login with configured admin user
- Rebuild search indices and generate an API key
- Create a show/movie
- Upload a cover image (and set your PFP)
- Try uploading a video using [encodeher](https://github.com/Serial-experiments-weebify/encodeher).
- Try searching for the show/movie.
- Link the video to an episode & try playing it back

## Docker stack

Both setups just spin up two docker stacks. One for Traefik (could be skipped) and one for Weebify.

For some reason a manual restart is needed in vagrant/multipass.

### `mongo`
The MongoDB instance for weebify. Has a relatively simple init script to create the admin user.

### `meili`

Meilisearch (search engine/db) for weebify. Exposed on `/api/search`.

### `minio`

S3 compatible object storage. Should probably used garage/seaweedfs instead. Exposed on `s3.` subdomain. 

### `minioinit`

Runs initialization script for minio to create the required buckets.

### `backend`

Main API, exposes `/graphql` endpoint.

### `media`

REST api for manipulating images/videos/... . Exposed on `/api/media`.

### `frontend`

Vue SPA served with `nginx`. Exposed as default route.
