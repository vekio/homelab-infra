# Homelab Infra

Homelab automation that keeps my self-hosted services reproducible. Terraform stitches together DNS, Cloudflare Tunnel and AdGuard; Ansible bootstraps hosts and deploys Docker Compose stacks; each stack lives under `stacks/<node>/<service>`.

---


## Repository layout

| Path | Purpose |
| --- | --- |
| `ansible/` | Inventories, playbooks and the `service_deploy` role that knows how to sync Compose stacks and supporting files. |
| `terraform/` | Root module plus reusable modules for Cloudflare + AdGuard. Stores DNS/tunnel configuration for both internal and public domains. |
| `stacks/` | Docker Compose stacks grouped by host (e.g. `stacks/janus/traefik`, `stacks/atlas/cutter`). Each stack folder contains compose files, config and dynamic Traefik definitions. |
| `cloud-init/` | Cloud-init snippets (`network-config`, `user-data`) used to bootstrap Raspberry Pi nodes with Ubuntu before Ansible takes over. |
| `scripts/`, `Makefile` | Quality-of-life helpers. The `Makefile` wraps common playbooks (`make setup_host`, `make deploy`, etc.). |
| `docs/` | Additional documentation or diagrams (ignored in Git to keep the repo slim). |

---

## Adding a new service

1. Create `stacks/<host>/<service>/compose.yml` plus any config/templates it needs. Follow the Compose ordering convention documented below for tidy diffs.
2. Declare the service under the matching host in `ansible/inventories/prod/group_vars/all/catalog.yml`, referencing the compose file, appdata folders and templates to render.
3. If the service should be exposed publicly, add it to the `services` array in `terraform/terraform.tfvars` with `public = true`; Terraform will wire the DNS rewrite, Cloudflare ingress and Traefik routes automatically.
4. `make deploy` (or the targeted playbook) to sync the new service to its host.
