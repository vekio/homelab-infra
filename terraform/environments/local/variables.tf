variable "domain" {
  type        = string
  description = "Base domain for public-facing services"
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
  type        = list(string)
  description = "Service names that should CNAME to the proxy host"
}

variable "proxy_host" {
  type        = string
  description = "FQDN or IP of the proxy target for service records"
}
