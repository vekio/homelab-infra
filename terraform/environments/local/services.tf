locals {
  service_records = {
    for svc in var.services :
    svc.name => {
      domain = "${svc.name}.${svc.public ? var.domain_demos : var.domain}"
      answer = var.proxy_host
    }
  }
}

module "adguard_proxy_services" {
  source  = "../../modules/adguard"
  records = local.service_records
}
