# Agent Notes

Follow these rules when editing or adding Compose files under `stacks/`:

- Keep service keys ordered as:
  1. `image`
  2. `container_name`
  3. `hostname` (if present)
  4. `restart`
  5. `depends_on`
  6. `networks`
  7. `ports`
  8. `expose`
  9. `volumes`
  10. `environment`
  11. `labels`
  12. `extra_hosts`
  13. `security_opt`
  14. `read_only` / `tmpfs` / other hardening flags
