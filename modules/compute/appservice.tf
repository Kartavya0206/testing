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
  resource_group_name = "${var.name-prefix}-${each.value.resource_group_name}"
  service_plan_id     = azurerm_app_service_plan.plans[each.value.app_service_plan_name].id

  site_config {
    always_on = true
  }

  app_settings = each.value.app_settings

  depends_on = [ azurerm_app_service_plan.plans, azurerm_resource_group.ASP_rg ]
}
resource "azurerm_windows_web_app_slot" "slots" {
  for_each = merge([
    for app in var.app_services : {
      for slot in lookup(app, "slots", []) :
      "${app.name}-${slot.name}" => {
        app_name     = app.name
        slot_name    = slot.name
        app_settings = slot.app_settings
      }
    } if lookup(app, "kind", "Windows") == "Windows"
  ]...)

  name           = each.value.slot_name
  app_service_id = azurerm_windows_web_app.apps[each.value.app_name].id

  site_config {}
  app_settings   = each.value.app_settings

 
}