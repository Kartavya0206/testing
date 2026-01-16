resource "azurerm_resource_group" "rg-ddos" {
  name     = var.resource_group_name
  location = var.location
}

# Create DDoS Protection Plan
resource "azurerm_network_ddos_protection_plan" "ddos" {
  name                = "ddos-plan-prod"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
}

