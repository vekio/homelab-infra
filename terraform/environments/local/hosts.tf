locals {
  host_records = {
    oberon = {
      domain = "oberon.${local.internal_domain}"
      answer = var.oberon_ip
    }
    titan = {
      domain = "titan.${local.internal_domain}"
      answer = var.titan_ip
    }
    calisto = {
      domain = "calisto.${local.internal_domain}"
      answer = var.calisto_ip
    }
    atlas = {
      domain = "atlas.${local.internal_domain}"
      answer = var.atlas_ip
    }
  }
}

module "adguard_hosts" {
  source  = "../../modules/adguard"
  records = local.host_records
}
