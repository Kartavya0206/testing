variable "log_analytics_workspace_name" {
    description = "The name of the Log Analytics workspace"
}
variable "log_analytics_workspace_rg" {
    description = "The resource group of the Log Analytics workspace"
}
variable "resource_ids_to_monitor" {
  type = list(string)
}
variable "location" {
    description = "The location of the resources"
}
