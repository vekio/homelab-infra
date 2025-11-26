locals {
  internal_domain = "home.local" # TODO remove this

  static_records = { # TODO remove this
    traefik_int = {
      domain = "traefik-int.${var.domain}"
      answer = "oberon.${local.internal_domain}"
    }
  }
}

module "adguard_static_services" {
  source  = "../../modules/adguard"
  records = local.static_records
}
