# Get current client configuration
data "azurerm_client_config" "current" {}

###############################
# MICROSOFT DEFENDER SETTINGS
###############################

# Defender for Servers
resource "azurerm_security_center_subscription_pricing" "defender_servers" {
  count         = var.enable_defender_for_servers ? 1 : 0
  tier          = "Standard"
  resource_type = "VirtualMachines"
}

# Defender for Containers (AKS)
resource "azurerm_security_center_subscription_pricing" "defender_containers" {
  count         = var.enable_defender_for_containers ? 1 : 0
  tier          = "Standard"
  resource_type = "Containers"
}

# Defender for Key Vault
resource "azurerm_security_center_subscription_pricing" "defender_key_vault" {
  count         = var.enable_defender_for_key_vault ? 1 : 0
  tier          = "Standard"
  resource_type = "KeyVaults"
}

# Defender for App Services
resource "azurerm_security_center_subscription_pricing" "defender_app_services" {
  count         = var.enable_defender_for_app_services ? 1 : 0
  tier          = "Standard"
  resource_type = "AppServices"
}

# Defender for Storage
# Use only if you import OR subscription is new
resource "azurerm_security_center_subscription_pricing" "defender_storage" {
  count         = var.enable_defender_for_storage ? 1 : 0
  tier          = "Standard"
  resource_type = "StorageAccounts"
}

# Defender for Databases (requires Security Admin role)
resource "azurerm_security_center_subscription_pricing" "defender_databases" {
  count         = var.enable_defender_for_databases ? 1 : 0
  tier          = "Standard"
  resource_type = "SqlServers"
}