resource "azurerm_express_route_circuit" "erc" {
  for_each = var.express_routes

  name                 = each.value.name
  location             = var.location
  resource_group_name  = var.resource_group_name

  service_provider_name = each.value.service_provider
  peering_location      = each.value.peering_location
  bandwidth_in_mbps     = each.value.bandwidth_in_mbps

  sku {
    tier   = each.value.sku_tier
    family = each.value.sku_family
  }

  allow_classic_operations = each.value.allow_classic_ports
}
