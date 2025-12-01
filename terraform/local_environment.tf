module "local_environment" {
  source = "./environments/local"

  domain          = var.domain
  internal_domain = var.internal_domain
  services        = var.services
  hosts           = var.hosts
  proxy_host      = var.proxy_host
}

module "cloudflare" {
  source = "./modules/cloudflare"

  account_id  = var.cloudflare_account_id
  zone_name   = var.cloudflare_zone_name
  tunnel_name = var.cloudflare_tunnel_name
  ingress = [
    for svc in var.services :
    {
      name    = svc.name
      service = format("https://%s.%s", svc.name, var.domain)
    } if svc.public
  ]
}
