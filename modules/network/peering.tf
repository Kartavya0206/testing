
resource "azurerm_virtual_network_peering" "vnet_scope_to_atlas" {
  name                      = "${local.vnet_scope.name}-to-${local.vnet_atlas.name}-peering"
  resource_group_name       = azurerm_resource_group.vnet-rg[local.vnet_scope.rg_name].name
  virtual_network_name      = azurerm_virtual_network.vnet[var.vnet_scope_key].name
  remote_virtual_network_id = azurerm_virtual_network.vnet[var.vnet_atlas_key].id

  allow_forwarded_traffic      = true
  allow_virtual_network_access = true

  depends_on = [
    azurerm_virtual_network.vnet
  ]
}

resource "azurerm_virtual_network_peering" "vnet_atlas_to_scope" {
  name                      = "${local.vnet_scope.name}-to-${local.vnet_atlas.name}-peering"
  resource_group_name       = azurerm_resource_group.vnet-rg[local.vnet_atlas.rg_name].name
  virtual_network_name      = azurerm_virtual_network.vnet[var.vnet_atlas_key].name
  remote_virtual_network_id = azurerm_virtual_network.vnet[var.vnet_scope_key].id

  allow_forwarded_traffic      = true
  allow_virtual_network_access = true

  depends_on = [
    azurerm_virtual_network.vnet
  ]
}
