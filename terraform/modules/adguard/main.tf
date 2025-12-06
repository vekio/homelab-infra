variable "records" {
  description = "Map of AdGuard rewrites"
  type = map(object({
    domain = string
    answer = string
  }))
}

resource "adguard_rewrite" "this" {
  for_each = var.records

  domain = each.value.domain
  answer = each.value.answer
}
