resource "cloudflare_dns_record" "this" {
  for_each = { for app in var.ingress : app.name => app }

  zone_id = data.cloudflare_zone.this.id
  name    = each.key
  type    = "CNAME"
  ttl     = 1
  proxied = true
  content = local.tunnel_cname
}
