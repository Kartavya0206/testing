locals {
  scope_vnet = var.vnets[var.vnet_scope_key]
}

resource "azurerm_resource_group" "natgw" {
  name     = var.natgw_lb_rg_name
  location = var.location
}

resource "azurerm_public_ip" "natgw_pip" {
  name                = var.natgw_pip_name
  resource_group_name = azurerm_resource_group.natgw.name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_nat_gateway" "natgw" {
  count               = var.enable_nat_gateway ? 1 : 0
  name                = var.nat_gateway_name
  location            = var.location
  resource_group_name = azurerm_resource_group.natgw.name
  sku_name            = "Standard"
}

resource "azurerm_subnet_nat_gateway_association" "assoc" {
  for_each = var.enable_nat_gateway ? {
    for subnet_name in var.subnets_to_attach_nat :
    "${var.vnet_scope_key}.${subnet_name}" => azurerm_subnet.subnet["${var.vnet_scope_key}.${subnet_name}"]
  } : {}

  subnet_id      = each.value.id
  nat_gateway_id = azurerm_nat_gateway.natgw[0].id
}
