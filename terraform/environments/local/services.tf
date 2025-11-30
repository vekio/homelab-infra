locals {
  service_records = {
    for svc in var.services :
    svc.name => {
      domain = "${svc.name}.${var.domain}"
      answer = svc.cname
    }
  }
}

module "adguard_proxy_services" {
  source  = "../../modules/adguard"
  records = local.service_records
}
