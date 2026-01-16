resource "azurerm_resource_group" "app_plan_rg" {
  name     = var.app_service_plan_resource_group_name
  location = var.location
}

resource "azurerm_service_plan" "app_service_plan" {
  for_each = {
    for app in var.app_services :
    app.app_service_plan_name => app
  }

  name                = each.key
  resource_group_name = azurerm_resource_group.app_plan_rg.name
  location            = azurerm_resource_group.app_plan_rg.location
  os_type             = var.os_type
  sku_name            = var.sku_name
}
