resource "cloudflare_dns_record" "this" {
  for_each = { for app in var.ingress : app.name => app }

  zone_id = var.zone_id
  name    = each.key
  type    = "CNAME"
  ttl     = 1
  proxied = true
  content = local.tunnel_cname
}
