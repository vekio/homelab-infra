locals {
  service_records = {
    for svc in var.services :
    svc => {
      domain = "${svc}.${var.domain}"
      answer = var.proxy_host
    }
  }
}

module "adguard_proxy_services" {
  source  = "../../modules/adguard"
  records = local.service_records
}
