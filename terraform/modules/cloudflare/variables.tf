variable "account_id" {
  description = "Cloudflare account id"
  type        = string
}

variable "zone_name" {
  description = "Human readable zone name (example.com)"
  type        = string
}

variable "tunnel_name" {
  description = "Friendly name for the tunnel"
  type        = string
}

variable "ingress" {
  description = "List of applications to expose via the tunnel"
  type = list(object({
    name    = string
    service = string
  }))
}

variable "catchall" {
  description = "Fallback service"
  type        = string
  default     = "http_status:404"
}
