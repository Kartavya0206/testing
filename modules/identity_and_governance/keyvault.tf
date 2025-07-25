resource "azurerm_resource_group" "rg" {
  name     = var.comm_service_resource_group_name
  location = var.location
}

resource "azurerm_key_vault" "kv" {
  name                        = var.key_vault_name
  location                    = var.location
  resource_group_name         = azurerm_resource_group.rg.name
  tenant_id                   = var.tenant_id
  sku_name                    = "standard"

  #soft_delete_enabled         = true
  purge_protection_enabled    = false

  access_policy {
    tenant_id = var.tenant_id
    object_id = var.object_id

    key_permissions    = ["get", "list"]
    secret_permissions = ["get", "list"]
  }
}

resource "azurerm_storage_account" "sa1" {
  name                     = var.storage_account_1_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
}

resource "azurerm_storage_account" "sa2" {
  name                     = var.storage_account_2_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
}