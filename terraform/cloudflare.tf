data "cloudflare_zone" "casta_me" {
  filter = {
    name = var.cloudflare_zone_name
  }
}

resource "cloudflare_dns_record" "mantita" {
  zone_id = data.cloudflare_zone.casta_me.id
  name    = "mantita"
  type    = "CNAME"
  content = "home.${var.cloudflare_zone_name}"
  ttl     = 120
  proxied = false
}
