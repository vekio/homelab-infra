variable "domain" {
  type        = string
  description = "Base domain for public-facing services"
}

variable "proxy_host" {
  type        = string
  description = "Hostname or IP address that services should resolve to"
}

variable "internal_domain" {
  type        = string
  description = "Internal domain used for host records"
}

variable "services" {
  type        = list(string)
  description = "List of service names exposed via the proxy"
}

variable "hosts" {
  type = list(object({
    name = string
    ip   = string
  }))
  description = "List of hosts managed in AdGuard"
}
