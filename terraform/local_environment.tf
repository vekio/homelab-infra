module "local_environment" {
  source = "./environments/local"

  domain     = var.domain
  proxy_host = var.proxy_host
  services   = var.services

  oberon_ip  = var.oberon_ip
  titan_ip   = var.titan_ip
  calisto_ip = var.calisto_ip
  atlas_ip   = var.atlas_ip
}
