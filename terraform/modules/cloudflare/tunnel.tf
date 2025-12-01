locals {
  tunnel_cname = "${cloudflare_zero_trust_tunnel_cloudflared.this.id}.cfargotunnel.com"
}

resource "cloudflare_zero_trust_tunnel_cloudflared" "this" {
  account_id = var.account_id
  name       = var.tunnel_name
  config_src = "cloudflare"
}

data "cloudflare_zero_trust_tunnel_cloudflared_token" "this" {
  account_id = var.account_id
  tunnel_id  = cloudflare_zero_trust_tunnel_cloudflared.this.id
}

resource "cloudflare_zero_trust_tunnel_cloudflared_config" "this" {
  account_id = var.account_id
  tunnel_id  = cloudflare_zero_trust_tunnel_cloudflared.this.id

  config = {
    ingress = concat(
      [
        for app in var.ingress :
        {
          hostname = format("%s.%s", app.name, data.cloudflare_zone.this.name)
          service  = app.service
        }
      ],
      [
        {
          service = var.catchall
        }
      ]
    )
  }
}

output "tunnel_token" {
  value     = data.cloudflare_zero_trust_tunnel_cloudflared_token.this.token
  sensitive = true
}
