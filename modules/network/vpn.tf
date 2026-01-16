
resource "azurerm_virtual_network_gateway" "vpn_gateway" {
  name                = var.name
  location            = azurerm_resource_group.vnet-rg.location
  resource_group_name = azurerm_resource_group.vnet-rg.name
  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  enable_bgp    = false
  sku           = "VpnGw1"

  ip_configuration {
    name                          = "${var.name}-ipconfig"
    public_ip_address_id          = azurerm_public_ip.vpn_gateway_pip.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.subnets["GatewaySubnet"].id

  }
  lifecycle {

    prevent_destroy = true

  }
}

resource "azurerm_public_ip" "vpn_gateway_pip" {
  name                = "${var.region_prefix}-vpn-gateway-pip"
  location            = azurerm_resource_group.vnet-rg.location
  resource_group_name = azurerm_resource_group.vnet-rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}
