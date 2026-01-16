output "vm_names" {
  value = [for vm in var.vms : vm.name]
}

output "vm_nic_ids" {
  value = { for k, v in azurerm_network_interface.vm_nic : k => v.id }
}

#app service
output "app_service_plan_ids" {
  description = "App Service Plan IDs"
  value = {
    for name, plan in azurerm_app_service_plan.plans : name => plan.id
  }
}

#Function apps
output "function_app_endpoints" {
  value = merge(
    { for k, app in azurerm_windows_function_app.windows_function_apps : k => app.default_hostname }
  )
}

#AI Foundry
output "ai_foundry_id" {
  value = azurerm_ai_foundry.ai_foundry.id
}

output "ai_foundry_project_id" {
  value = azurerm_ai_foundry_project.project.id
}

#AVD

output "azure_virtual_desktop_host_pool" {
  description = "Name of the Azure Virtual Desktop host pool"
  value       = azurerm_virtual_desktop_host_pool.hostpool.name
}

output "azurerm_virtual_desktop_application_group" {
  description = "Name of the Azure Virtual Desktop DAG"
  value       = azurerm_virtual_desktop_application_group.dag.name
}

output "azurerm_virtual_desktop_workspace" {
  description = "Name of the Azure Virtual Desktop workspace"
  value       = azurerm_virtual_desktop_workspace.workspace.name
}
output "AVD_user_groupname" {
  description = "Azure Active Directory Group for AVD users"
  value       = azuread_group.aad_group.display_name
}

