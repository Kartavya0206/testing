resource "azurerm_private_dns_zone_virtual_network_link" "vnet_links" {
  for_each = { for link in var.dns_vnet_links : link.name => link }

  name                  = each.value.name
  resource_group_name   = each.value.vnetlink_rg
  private_dns_zone_name = each.value.private_dns_zone
  virtual_network_id    = azurerm_virtual_network.vnet[each.value.vnet_name].id
  registration_enabled  = each.value.registration
  tags = merge(
    each.value.tags,
   
  )
}