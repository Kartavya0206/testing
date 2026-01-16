resource "azurerm_resource_group" "rg-sql" {
  name     = var.sql_resource_group_name
  location = var.location
}

resource "azurerm_mssql_server" "sql_server" {
  name                         = var.sql_server_name
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  version                      = var.sql_server_version
  administrator_login          = var.sql_admin_login
  administrator_login_password = var.sql_admin_password

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

resource "azurerm_mssql_database" "sql_db" {
  for_each = { for db in var.sql_databases : db.name => db }

  name               = each.value.name
  server_id          = azurerm_mssql_server.sql_server.id
  sku_name           = each.value.sku_name
  max_size_gb        = each.value.max_size_gb
  collation          = "SQL_Latin1_General_CP1_CI_AS"
  zone_redundant     = false
  read_scale         = false
  tags               = var.tags
}
