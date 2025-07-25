output "sql_server_fqdn" {
  value = azurerm_mssql_server.sql_server.fully_qualified_domain_name
}

output "sql_databases" {
  value = {
    for db in azurerm_mssql_database.sql_db :
    db.name => {
      id          = db.id
      sku_name    = db.sku_name
      max_size_gb = db.max_size_gb
    }
  }
}

output "data_factory_id" {
  value = azurerm_data_factory.data_factory.id
}

output "df_identity_id" {
  value = azurerm_user_assigned_identity.df_identity.id
}

output "storage_account_id" {
  value = azurerm_storage_account.df_storage.id
}

output "vm_id" {
  value = azurerm_virtual_machine.df_vm.id
}

output "private_endpoint_id" {
  value = azurerm_private_endpoint.df_private_endpoint.id
}

output "redis_cluster_id" {
  value = azurerm_redis_enterprise_cluster.redis_cluster.id
}

output "redis_private_endpoint_ip" {
  value = azurerm_private_endpoint.redis_pe.private_service_connection[0].private_ip_address
}

output "private_dns_zone_id" {
  value = azurerm_private_dns_zone.redis_dns.id
}
