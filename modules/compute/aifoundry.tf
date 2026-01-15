resource "azurerm_resource_group" "ai_rg" {
  name     = "${var.name-prefix}-${var.ai_resource_group_name}"
  location = var.location
}

resource "azurerm_ai_foundry" "ai_foundry" {
  name                = var.ai_foundry_name
  location            = var.location
  resource_group_name = azurerm_resource_group.ai_rg.name
  
  identity {
    type = "SystemAssigned, UserAssigned"
    identity_ids = [azurerm_resource_group.ai_rg.id]
     }
  storage_account_id = azurerm_storage_account.ai_foundry_storage.id
  key_vault_id        = azurerm_key_vault.ai_foundry_key_vault.id
  tags                = var.tags
}


resource "azurerm_ai_foundry_project" "project" {
  name                  = var.ai_foundry_project_name
  location              = var.location
  description           = var.ai_foundry_project_description
  ai_services_hub_id     = azurerm_ai_foundry.ai_foundry.ai_services_hub_id
  tags                  = var.tags
}
