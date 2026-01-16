resource "azurerm_local_network_gateway" "s2s_lng" {
  for_each            = var.s2s_configs
  name                = each.value.local_gateway_name
  location            = azurerm_resource_group.vnet-rg.location
  resource_group_name = azurerm_resource_group.vnet-rg.name
  gateway_address     = each.value.local_gateway_ip
  address_space       = each.value.address_space

  
}

resource "azurerm_virtual_network_gateway_connection" "s2s_connection" {
  for_each                      = var.s2s_configs
  name                          = "s2s-connection-${each.key}"
  location                      = azurerm_resource_group.vnet-rg.location
  resource_group_name           = azurerm_resource_group.vnet-rg.name
  type                          = "IPsec"
  virtual_network_gateway_id    = azurerm_virtual_network_gateway.vpn_gateway.id  # <-- Corrected here
  local_network_gateway_id      = azurerm_local_network_gateway.s2s_lng[each.key].id
  shared_key                    = var.shared_keys[each.key]

  ipsec_policy {
    dh_group         = "DHGroup14"
    ike_encryption   = "AES256"
    ike_integrity    = "SHA256"
    ipsec_encryption = "AES256"
    ipsec_integrity  = "SHA256"
    pfs_group        = each.value.pfs_group
    sa_lifetime      = 27000
  }
    
    lifecycle {
         ignore_changes = [tags]
  }

  depends_on = [azurerm_virtual_network_gateway.vpn_gateway]
}




