locals {
  service_records = {
    for svc in var.services :
    svc.name => {
      domain = "${svc.name}.${var.domain}"
      answer = "${svc.host}.${var.internal_domain}"
    }
  }
}

module "adguard_proxy_services" {
  source  = "../../modules/adguard"
  records = local.service_records
}
