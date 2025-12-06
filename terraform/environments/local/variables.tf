variable "domain" {
  type        = string
  description = "Base domain for public-facing services"
}

variable "domain_demos" {
  type        = string
  description = "Domain used for public demo services"
}

variable "internal_domain" {
  type        = string
  description = "Internal domain used for host records"
}

variable "hosts" {
  type = list(object({
    name = string
    ip   = string
  }))
  description = "List of hosts managed in AdGuard"
}

variable "services" {
  type = list(object({
    name           = string
    public         = bool
    tunnel_service = optional(string)
  }))
  description = "Services that should CNAME to the proxy host and optionally be published via tunnel"
}

variable "proxy_host" {
  type        = string
  description = "FQDN or IP of the proxy target for service records"
}
