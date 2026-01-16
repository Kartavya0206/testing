resource "azurerm_resource_group" "WebApp_rg" {
  for_each = { for app in var.app_services : app.name => app }

  name     = "${var.name-prefix}-${each.value.resource_group_name}"
  location = var.location
}

resource "azurerm_windows_web_app" "apps" {
  for_each = {
    for app in var.app_services : app.name => app
    if lookup(app, "kind", "Windows") == "Windows"
  }

  name                = "${var.name-prefix}-${each.value.name}"
  location            = var.location
  resource_group_name = azurerm_resource_group.WebApp_rg[each.key].name
  service_plan_id     = azurerm_service_plan.app_service_plan[
    each.value.app_service_plan_name
  ].id

  site_config {
    always_on = true
  }

  app_settings = each.value.app_settings
}
