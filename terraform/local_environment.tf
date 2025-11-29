module "local_environment" {
  source = "./environments/local"

  domain          = var.domain
  proxy_host      = var.proxy_host
  internal_domain = var.internal_domain
  services        = var.services
  hosts           = var.hosts
}
