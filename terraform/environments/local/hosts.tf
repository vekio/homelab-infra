locals {
  host_records = {
    for host in var.hosts :
    host.name => {
      domain = "${host.name}.${local.internal_domain}"
      answer = host.ip
    }
  }
}

module "adguard_hosts" {
  source  = "../../modules/adguard"
  records = local.host_records
}
