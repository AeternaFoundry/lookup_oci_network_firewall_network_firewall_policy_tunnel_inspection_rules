data "oci_network_firewall_network_firewall_policy_tunnel_inspection_rules" "network_firewall_network_firewall_policy_tunnel_inspection_rules_lookup" {
  for_each = var.network_firewall_network_firewall_policy_tunnel_inspection_rules_lookup

  network_firewall_policy_id            = each.value.network_firewall_policy_id
  display_name                          = each.value.display_name
  tunnel_inspection_rule_priority_order = each.value.tunnel_inspection_rule_priority_order

  dynamic "filter" {
    for_each = each.value.filter != null ? each.value.filter : []
    content {
      name   = filter.value.name
      regex  = filter.value.regex
      values = filter.value.values
    }
  }
}

