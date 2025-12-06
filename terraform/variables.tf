### Configuration ###
variable "domain" {
  description = "Homelab domain"
  type        = string
}

variable "internal_domain" {
  description = "Internal domain used for host records"
  type        = string
  default     = "home.local"
}

variable "domain_demos" {
  description = "Public demo domain for externally exposed services"
  type        = string
}

### AdGuard provider configuration ###
variable "adguard_host" {
  description = "Address of your AdGuard Home server"
  type        = string
}

variable "adguard_username" {
  description = "Username for authentication in AdGuard Home"
  type        = string
}

variable "adguard_password" {
  description = "Password for authentication in AdGuard Home"
  type        = string
  sensitive   = true
}

variable "adguard_scheme" {
  description = "Scheme used for authentication in AdGuard Home"
  type        = string
}

### Cloudflare ###
variable "cloudflare_api_token" {
  type      = string
  sensitive = true
}

variable "cloudflare_zone_name" {
  type        = string
  description = "Nombre de la zona de Cloudflare (ej: tudominio.com)"
}

variable "cloudflare_account_id" {
  description = "Account ID for your Cloudflare account"
  type        = string
  sensitive   = true
}

variable "cloudflare_tunnel_name" {
  description = "Friendly name for the tunnel"
  type        = string
}

### DNS records ###
variable "hosts" {
  description = "List of homelab hosts and their IPs"
  type = list(object({
    name = string
    ip   = string
  }))
}

variable "services" {
  description = "List of services with visibility flags"
  type = list(object({
    name           = string
    public         = bool
    tunnel_service = optional(string)
  }))
}

variable "proxy_host" {
  description = "Nombre FQDN (o IP) del proxy interno"
  type        = string
}
