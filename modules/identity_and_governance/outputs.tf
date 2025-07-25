output "eventgrid_system_topic_id" {
  value = azurerm_eventgrid_system_topic.event_grid
}

output "managed_identity_id" {
  value = azurerm_user_assigned_identity.identity.id
}

output "key_vault_id" {
  value = azurerm_key_vault.this.id
}

output "storage_account_1_id" {
  value = azurerm_storage_account.classic1.id
}

output "storage_account_2_id" {
  value = azurerm_storage_account.classic2.id
}
output "servicebus_namespace_id" {
  value = azurerm_servicebus_namespace.servicebus.id
}

output "autoscale_setting_id" {
  value = azurerm_monitor_autoscale_setting.autoscale.id
}

output "bing_grounding_search_id" {
  description = "The ID of the Bing Grounding Search resource"
  value       = azurerm_bing_grounding_search.bing_search.id
}

output "bing_grounding_search_name" {
  description = "The name of the Bing Grounding Search resource"
  value       = azurerm_bing_grounding_search.bing_search.name
}
