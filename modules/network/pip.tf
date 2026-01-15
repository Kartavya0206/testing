resource "azurerm_public_ip" "public_ips" {
  for_each = var.public_ips
  name                = "pip-${each.key}-${var.project_name}-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.vnet_rg["vnet1"].name
  allocation_method   = each.value.allocation_method
  sku                 = each.value.sku_name
  ip_version          = each.value.ip_version
  zones               = each.value.zones

  tags = var.tags
}

resource "azurerm_public_ip" "bastion" {
  for_each = var.vnets
  name                = "pip-bastion-${each.key}-${var.project_name}-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.vnet_rg[each.key].name
  allocation_method   = "Static"
  sku                 = "Standard"
  ip_version          = "IPv4"
  zones               = []

  tags = var.tags
}
