variable "domain" {
  type        = string
  description = "Base domain for public-facing services"
}

variable "proxy_host" {
  type        = string
  description = "Hostname or IP address that services should resolve to"
}

variable "services" {
  type        = list(string)
  description = "List of service names exposed via the proxy"
}

variable "oberon_ip" {
  type        = string
  description = "IP address for the oberon host"
}

variable "titan_ip" {
  type        = string
  description = "IP address for the titan host"
}

variable "calisto_ip" {
  type        = string
  description = "IP address for the calisto host"
}

variable "atlas_ip" {
  type        = string
  description = "IP address for the atlas host"
}

variable "iapetus_ip" {
  type        = string
  description = "IP address for the iapetus host"
}
