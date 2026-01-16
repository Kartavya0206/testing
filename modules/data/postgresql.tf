resource "azurerm_resource_group" "psg_rg" {
  name     = var.psg_rg_name
  location = var.location
}

resource "azurerm_postgresql_flexible_server" "psg" {
  name                   = var.psg_server_name
  resource_group_name    = azurerm_resource_group.psg_rg.name
  location               = azurerm_resource_group.psg_rg.location
  version                = "12"
  administrator_login    = var.psg_admin_login
  administrator_password = var.psg_admin_password
  storage_mb             = 32768
  sku_name               = var.psg_sku_name
  backup_retention_days = "7"
}

resource "azurerm_postgresql_flexible_server_database" "psg_db" {
  name      = var.psg_database_name
  server_id = azurerm_postgresql_flexible_server.psg.id
  collation = "en_US.utf8"
  charset   = "UTF8"

  # prevent the possibility of accidental data loss
  lifecycle {
    prevent_destroy = true
  }
}
