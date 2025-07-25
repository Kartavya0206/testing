#Resource Group 
resource "azurerm_resource_group" "funcapp_rg" {
  for_each = {
    for app in var.function_apps : app.name => app
  }

  name     = "${var.name-prefix}-${each.value.resource_group_name}"
  location = var.location
}


# Storage Account for Function Apps
resource "azurerm_storage_account" "func_storage" {
  for_each = {
    for app in var.function_apps : app.name => app
  }

  name                     = each.value.storage_account_name
  resource_group_name      = azurerm_resource_group.funcapp_rg[each.key].name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  access_tier              = "Hot"
}

# Windows Function Apps
resource "azurerm_windows_function_app" "windows_function_apps" {
  for_each = {
    for app in var.function_apps : app.name => app
    if lower(app.os_type) == "windows"
  }

  name                       = "${var.name-prefix}-${each.value.name}"
  location                   = var.location
  resource_group_name        = azurerm_resource_group.funcapp_rg[each.key].name
  service_plan_id            = azurerm_app_service_plan.plans[each.value.app_service_plan_name].id
  storage_account_name       = azurerm_storage_account.func_storage[each.key].name
  storage_account_access_key = azurerm_storage_account.func_storage[each.key].primary_access_key
  functions_extension_version = "~4"

  site_config {
    always_on = true
  }

  app_settings = merge({
    "FUNCTIONS_WORKER_RUNTIME"     = each.value.runtime_stack
    "WEBSITE_RUN_FROM_PACKAGE"     = "1"
    "WEBSITE_CONTENTAZUREFILECONNECTIONSTRING" = "DefaultEndpointsProtocol=https;AccountName=${azurerm_storage_account.func_storage[each.key].name};AccountKey=${azurerm_storage_account.func_storage[each.key].primary_access_key};EndpointSuffix=core.windows.net"
  }, each.value.app_settings)

  depends_on = [
    azurerm_app_service_plan.plans,
    azurerm_storage_account.func_storage
  ]
}

# Function App Slots
resource "azurerm_function_app_slot" "slots" {
  for_each = merge([
    for app in var.function_apps : 
    lower(app.os_type) == "windows" && length(app.slot_names) > 0 ?
    {
      for slot_name in app.slot_names : 
      "${app.name}-${slot_name}" => {
        app        = app
        slot_name  = slot_name
      }
    } : {}
  ]...)

  name                       = each.value.slot_name
  function_app_name          = azurerm_windows_function_app.windows_function_apps[each.value.app.name].name
  resource_group_name        = azurerm_resource_group.funcapp_rg[each.value.app.name].name
  location                   = var.location
  storage_account_name       = azurerm_storage_account.func_storage[each.value.app.name].name
  storage_account_access_key = azurerm_storage_account.func_storage[each.value.app.name].primary_access_key
  app_service_plan_id        = azurerm_app_service_plan.plans[each.value.app.app_service_plan_name].id

  site_config {
    always_on = true
  }

  app_settings = merge({
    "FUNCTIONS_WORKER_RUNTIME" = each.value.app.runtime_stack
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
  }, each.value.app.app_settings)

  depends_on = [
    azurerm_windows_function_app.windows_function_apps
  ]
}
