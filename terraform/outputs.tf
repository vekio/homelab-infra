output "cloudflare_tunnel_token" {
  value     = module.cloudflare.tunnel_token
  sensitive = true
  description = "Token that cloudflared needs to run the Zero Trust tunnel"
}
