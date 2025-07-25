resource "azurerm_resource_group" "bing_rg" {
  name     = var.bing_resource_group_name
  location = var.location
}

resource "azurerm_bing_grounding_search" "bing_search" {
  name                = var.bing_grounding_search_name
  location            = var.location
  resource_group_name = azurerm_resource_group.bing_rg.name
  sku_name            = var.sku_name
  tags                = var.tags
}
