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

######## managed identities variables ##########

variable "create_new_resources" {
  description = "Flag to create new managed identities and resource groups"
  type        = bool
  default     = true
}
variable "managed_identities" {
  description = "List of managed identities to create"
  type = list(object({
    name                   = string
    mi_resource_group_name = string
    location               = string
  }))
  default = []
}

variable "aks_resource_group_name" {
  description = "Name of the resource group where AKS is created"
  type        = string
}

variable "location" {
  description = "Azure region for resources"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
}

variable "project_name" {
  description = "Project name for resource naming"
  type        = string
}

variable "region_code" {
  description = "Azure region code for naming (e.g., uan for UAE North)"
  type        = string
  default     = "uan"
}

variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}
variable "enable_defender_for_servers" {
  description = "Enable Defender for Servers"
  type        = bool
  default     = true
}

variable "enable_defender_for_containers" {
  description = "Enable Defender for Containers"
  type        = bool
  default     = true
}

variable "enable_defender_for_key_vault" {
  description = "Enable Defender for Key Vault"
  type        = bool
  default     = true
}

variable "enable_defender_for_app_services" {
  description = "Enable Defender for App Services"
  type        = bool
  default     = true
}

variable "enable_defender_for_storage" {
  description = "Enable Defender for Storage"
  type        = bool
  default     = true
}

variable "enable_defender_for_databases" {
  description = "Enable Defender for SQL Databases"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to be applied to all resources"
  type        = map(string)
  default     = {}
}
variable "vault_resource_group_name" {
  description = "Name of the resource group for Recovery Services Vault"
  type        = string
}

