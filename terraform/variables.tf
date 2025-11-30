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

### DNS records ###
variable "hosts" {
  description = "List of homelab hosts and their IPs"
  type = list(object({
    name = string
    ip   = string
  }))
}

variable "services" {
  description = "List of services and the host each one should CNAME to"
  type = list(object({
    name  = string
    cname = string
  }))
}
