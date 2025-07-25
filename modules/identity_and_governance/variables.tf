variable "location" {
  description = "Location for the resources"
  type        = string
  default     = ""
}
variable "name-prefix" {
  description = "Prefix for resource names"
  type        = string
  default     = ""
}

variable "comm_service_resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "communication_service_name" {
  description = "Name of the Communication Service"
  type        = string
}

variable "communication_data_location" {
  description = "Data location for Communication Service"
  type        = string
}

variable "eventgrid_topic_name" {
  description = "Name of the Event Grid System Topic"
  type        = string
}

variable "eventgrid_source_id" {
  description = "Source ARM resource ID for Event Grid"
  type        = string
}

variable "eventgrid_topic_type" {
  description = "Topic type for Event Grid"
  type        = string
}

variable "identity_name" {
  description = "Name of the Managed Identity"
  type        = string
}

variable "storage_account_1_name" {
  description = "Name of the first storage account"
  type        = string
}

variable "storage_account_2_name" {
  description = "Name of the second storage account"
  type        = string
}



variable "tenant_id" {
  description = "The tenant ID of the Azure AD"
  type        = string
}

variable "object_id" {
  description = "The object ID of the user/service principal"
  type        = string
}

variable "key_vault_name" {
  description = "Name of the Key Vault"
  type        = string
}


variable "servicebus_namespace_name" {
  type        = string
  description = "Service Bus Namespace name"
}

variable "servicebus_capacity" {
  type        = number
  description = "Capacity for the Service Bus namespace"
}

variable "autoscale_setting_name" {
  type        = string
  description = "Name of the autoscale setting"
}

variable "autoscale_minimum_capacity" {
  type        = string
  description = "Minimum instance count for autoscale"
}

variable "autoscale_default_capacity" {
  type        = string
  description = "Default instance count for autoscale"
}

variable "autoscale_maximum_capacity" {
  type        = string
  description = "Maximum instance count for autoscale"
}

variable "autoscale_incoming_threshold" {
  type        = number
  description = "Threshold for incoming messages to trigger autoscale"
}

variable "tags" {
  type        = map(string)
  description = "Tags for resources"
  default     = {}
}

variable "servicebus_resource_group_name" {
  type        = string
  description = "Resource group name"
}



variable "sku"{
  type        = string
  description = "SKU for the Service Bus namespace"
}
variable "selected_vm_name" {
  type        = string
  description = "The key of the VM for which the resource group should be used by automation"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the Resource Group"
}

variable "automation_account_name" {
  type        = string
  description = "Automation Account name"
}

variable "automation_sku_name" {
  type        = string
  description = "SKU for the Automation Account (e.g., 'Basic')"
  default     = "Basic"
}

variable "runbook_name" {
  type        = string
  description = "Name of the runbook"
}

variable "runbook_type" {
  type        = string
  description = "Type of the runbook (e.g., PowerShell, Python2)"
  default     = "PowerShell"
}

variable "runbook_log_verbose" {
  type        = bool
  description = "Enable verbose logging for the runbook"
  default     = true
}

variable "runbook_log_progress" {
  type        = bool
  description = "Enable progress logging for the runbook"
  default     = true
}

variable "runbook_file_path" {
  type        = string
  description = "Path to the local file containing runbook content"
}

variable "runbook_content_uri" {
  type        = string
  description = "URI for publishing runbook content"
}

variable "bing_resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "bing_grounding_search_name" {
  description = "Name of the Bing Grounding Search resource"
  type        = string
}

variable "bing_sku_name" {
  description = "SKU of Bing Grounding Search (e.g., F0, S1)"
  type        = string
}


