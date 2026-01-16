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

#vms
variable "vms" {
  description = "List of virtual machines to create"
  type = list(object({
    name           = string
    resource_group = string
    subnet_id      = string
    os_type        = string # "Windows" or "Linux"
    size           = string
    admin_username = string
    admin_password = string
    identity_name  = optional(string, null)
    computer_name  = optional(string)
    version = string # Only required for Windows VMs
    os_disk = object({
      disk_type     = string
      disk_size_gb  = number
    })

    data_disks = optional(list(object({
      disk_type     = string
      disk_size_gb  = number
    })))
  }))
}

#apps service plans and apps


variable "app_service_plan_resource_group_name" {
  description = "Resource group name for the App Service Plan"
  type        = string
  default     = "app-service-rg"
}
variable "app_service_plan_name" {
  description = "Name of the App Service Plan"
  type        = string
  default     = "app-service-plan"
}
variable "os_type"{
  description = "Operating system type for App Service Plan"
  type        = string
  default     = "Windows"
}
variable "sku_name" {
  description = "SKU name for App Service Plan"
  type        = string
  default     = "S1"
}

variable "app_services" {
  description = "List of App Services and their slots"
  type = list(object({
    name                  = string
    resource_group_name   = string
    app_service_plan_name = string
    site_config           = optional(map(string), {})
    app_settings          = optional(map(string), {})
    slots = optional(list(object({
      name         = string
      app_settings = optional(map(string), {})
    })), [])
  }))
}

variable "function_apps" {
  description = "List of Function Apps"
  type = list(object({
    name                  = string
    resource_group_name   = string
    os_type               = string
    runtime_stack         = string
    app_service_plan_name = string
    app_settings          = map(string)
    storage_account_name  = string
    storage_account_type  = string
    slot_names            = list(string)
  }))
}


variable "ai_resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "ai_foundry_name" {
  description = "Name of the AI Foundry"
  type        = string
}

variable "ai_foundry_project_name" {
  description = "Name of the AI Foundry Project"
  type        = string
}

variable "ai_foundry_project_description" {
  description = "Description for the project"
  type        = string
  default     = "AI Foundry Project for experimentation"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

#variables for VMSS#
variable "vmss" {
  description = "Map of Virtual Machine Scale Sets to create"
  type = map(object({
    resource_group = string
    name           = string
    sku            = string
    admin_username = string
    admin_password = string
    offer          = string
    image_sku      = string
    os_disk = object({
      disk_type = string
      disk_size_gb = number
    })
  }))
}
variable "capacity" {
  description = "Default capacity for VMSS autoscaling"
  type        = number
  default     = 2
}

#varible for AVD
variable "rg_name" {
description = "resource group for avd"
type = string
default = "avd-rg"
}
variable "workspace" {
description = "avd workspace name"
type = string
default = "avd-workspace"
}
variable "prefix" {
description = "prefix for avd resources"
type = string
default = "avd"
}
variable "hostpool"{
description = "avd hostpool name"
type = string
default = "avd-hostpool" 
}
variable "dag" {
description = "avd dag name"  
type = string
default = "avd-dag"
}

