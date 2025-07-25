output "container_app_names" {
  value = [for app in azurerm_container_app.apps : app.name]
}

output "container_app_environments" {
  description = "Map of container app environment names and their IDs"
  value = {
    for env in azurerm_container_app_environment.environment :
    env.name => env.id
  }
}
output "container_app_ids" {
  value = [for app in azurerm_container_app.apps : app.id]
}


