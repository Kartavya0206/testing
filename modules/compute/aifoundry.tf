resource "azurerm_resource_group" "ai_rg" {
  name     = "${var.name-prefix}-${var.ai_resource_group_name}"
  location = var.location
}

resource "azurerm_ai_foundry" "ai_foundry" {
  name                = var.ai_foundry_name
  location            = var.location
  resource_group_name = azurerm_resource_group.ai_rg.name
  tags                = var.tags
}

resource "azurerm_ai_foundry_project" "project" {
  name                  = var.ai_foundry_project_name
  resource_group_name   = azurerm_resource_group.ai_rg.name
  location              = var.location
  ai_foundry_id         = azurerm_ai_foundry.ai_foundry.id
  description           = var.ai_foundry_project_description
  tags                  = var.tags
}
