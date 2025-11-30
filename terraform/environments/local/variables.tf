variable "domain" {
  type        = string
  description = "Base domain for public-facing services"
}

variable "internal_domain" {
  type        = string
  description = "Internal domain used for host records"
}

variable "services" {
  type = list(object({
    name  = string
    cname = string
  }))
  description = "List of service names and the host they should resolve to"
}

variable "hosts" {
  type = list(object({
    name = string
    ip   = string
  }))
  description = "List of hosts managed in AdGuard"
}
