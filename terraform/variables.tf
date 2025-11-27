### Configuration ###
variable "domain" {
  description = "Homelab domain"
  type        = string
}

variable "proxy_host" {
  description = "Nombre FQDN (o IP) del proxy interno"
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

### DNS records ###
variable "oberon_ip" {
  description = "IP address of the oberon server"
  type        = string
}

variable "titan_ip" {
  description = "IP address of the titan server"
  type        = string
}

variable "calisto_ip" {
  description = "IP address of the calisto server"
  type        = string
}

variable "atlas_ip" {
  description = "IP address of the atlas server"
  type        = string
}

variable "iapetus_ip" {
  description = "IP address of the iapetus server"
  type        = string
}

variable "services" {
  description = "List of service names exposed through the proxy"
  type        = list(string)
}
