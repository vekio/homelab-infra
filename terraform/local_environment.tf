module "local_environment" {
  source = "./environments/local"

  domain          = var.domain
  domain_demos    = var.domain_demos
  internal_domain = var.internal_domain
  services        = var.services
  hosts           = var.hosts
  proxy_host      = var.proxy_host
}

module "cloudflare" {
  source = "./modules/cloudflare"

  account_id      = var.cloudflare_account_id
  zone_id         = var.cloudflare_zone_id
  tunnel_name     = var.cloudflare_tunnel_name
  hostname_domain = var.domain_demos
  ingress = [
    for svc in var.services :
    {
      name = svc.name
      service = coalesce(
        try(svc.tunnel_service, null),
        format("https://%s.%s", svc.name, var.domain_demos)
      )
    } if svc.public
  ]
}
