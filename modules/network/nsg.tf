resource "azurerm_resource_group" "nsg_rg" {
  count    = var.create_new_resources ? 1 : 0
  name     = var.network_resource_group_name
  location = var.location
  tags     = var.tags

  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_network_security_group" "default" {
  count               = var.create_new_resources ? 1 : 0
  name                = "stratus-eu-nsg"
  location            = var.location
  resource_group_name = azurerm_resource_group.nsg_rg[0].name

  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_network_security_rule" "allow_ssh" {
  count                       = var.create_new_resources ? 1 : 0
  name                        = "Allow-SSH"
  priority                    = 1001
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  network_security_group_name = azurerm_network_security_group.default[0].name
  resource_group_name         = azurerm_resource_group.nsg_rg[0].name
}

resource "azurerm_network_security_rule" "allow_rdp" {
  count                       = var.create_new_resources ? 1 : 0
  name                        = "Allow-RDP"
  priority                    = 1002
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  network_security_group_name = azurerm_network_security_group.default[0].name
  resource_group_name         = azurerm_resource_group.nsg_rg[0].name
}

resource "azurerm_network_security_rule" "allow_http" {
  count                       = var.create_new_resources ? 1 : 0
  name                        = "Allow-HTTP"
  priority                    = 1003
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  network_security_group_name = azurerm_network_security_group.default[0].name
  resource_group_name         = azurerm_resource_group.nsg_rg[0].name
}

resource "azurerm_network_security_rule" "allow_https" {
  count                       = var.create_new_resources ? 1 : 0
  name                        = "Allow-HTTPS"
  priority                    = 1004
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  network_security_group_name = azurerm_network_security_group.default[0].name
  resource_group_name         = azurerm_resource_group.nsg_rg[0].name
}

resource "azurerm_network_security_rule" "allow_internal" {
  count                       = var.create_new_resources ? 1 : 0
  name                        = "Allow-Internal"
  priority                    = 1100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "VirtualNetwork"
  network_security_group_name = azurerm_network_security_group.default[0].name
  resource_group_name         = azurerm_resource_group.nsg_rg[0].name
}

resource "azurerm_network_security_rule" "deny_all_inbound" {
  count                       = var.create_new_resources ? 1 : 0
  name                        = "Deny-All-Inbound"
  priority                    = 4096
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  network_security_group_name = azurerm_network_security_group.default[0].name
  resource_group_name         = azurerm_resource_group.nsg_rg[0].name
}