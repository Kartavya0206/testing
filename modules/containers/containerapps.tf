# Existing container app resource group
resource "azurerm_resource_group" "container_rg" {
  for_each = {
    for app in var.container_apps : app.name => app
  }

  name     = "${var.name-prefix}-${each.value.resource_group_name}"
  location = var.location
}

# Optional managed identity per container app
resource "azurerm_user_assigned_identity" "container_identity" {
  for_each = {
    for app in var.container_apps : app.name => app if lookup(app, "create_identity", false)
  }

  name                = "${each.value.name}-identity"
  resource_group_name = azurerm_resource_group.container_rg[each.key].name
  location            = var.location
}

# Optional storage account per container app
resource "azurerm_storage_account" "container_storage" {
  for_each = {
    for app in var.container_apps : app.name => app if lookup(app, "create_storage_account", false)
  }

  name                     = "${each.value.name}sa"
  resource_group_name      = azurerm_resource_group.container_rg[each.key].name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  tags                     = var.tags
}

# Container App with optional identity
resource "azurerm_container_app" "apps" {
  for_each = {
    for app in var.container_apps : app.name => app
  }

  name                         = each.value.name
  resource_group_name          = azurerm_resource_group.container_rg[each.key].name
  container_app_environment_id = azurerm_container_app_environment.environment[each.value.environment_id].id
  revision_mode                = each.value.revision_mode

  identity {
    type         = lookup(each.value, "create_identity", false) ? "UserAssigned" : "SystemAssigned"
    identity_ids = lookup(each.value, "create_identity", false) ? [azurerm_user_assigned_identity.container_identity[each.key].id] : null
  }

  template {
    container {
      name   = each.value.container_name
      image  = each.value.image
      cpu    = each.value.cpu
      memory = each.value.memory

      dynamic "env" {
        for_each = each.value.env_vars
        content {
          name  = env.value.name
          value = env.value.value
        }
      }
    }

    min_replicas = each.value.min_replicas
    max_replicas = each.value.max_replicas
  }

  tags = var.tags
}
