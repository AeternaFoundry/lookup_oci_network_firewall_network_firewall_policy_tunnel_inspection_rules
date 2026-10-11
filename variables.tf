variable "network_firewall_network_firewall_policy_tunnel_inspection_rules_lookup" {
  description = <<EOT
Map of network_firewall_network_firewall_policy_tunnel_inspection_rules_lookup, attributes below
Required:
    - network_firewall_policy_id
Optional:
    - display_name
    - tunnel_inspection_rule_priority_order
    - filter (block):
        - name (required)
        - regex (optional)
        - values (required)
EOT

  type = map(object({
    network_firewall_policy_id            = string
    display_name                          = optional(string)
    tunnel_inspection_rule_priority_order = optional(number)
    filter = optional(list(object({
      name   = string
      regex  = optional(bool)
      values = list(string)
    })))
  }))
  validation {
    condition = alltrue([
      for k, v in var.network_firewall_network_firewall_policy_tunnel_inspection_rules_lookup : (
        alltrue([for item in v.tunnel_inspection_rule_summary_collection : (item.items == null || alltrue([for item in item.items : (item.protocol == null || (contains([for v in ["VXLAN"] : lower(v)], lower(item.protocol))))]))])
      )
    ])
    error_message = "must be one of: \"VXLAN\""
  }
}

