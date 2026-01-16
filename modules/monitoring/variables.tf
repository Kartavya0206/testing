variable "log_analytics_resource_group_name" {
  description = "Name of the resource group for Log Analytics Workspace"
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

variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
}
variable "region_code" {
  description = "Azure region code for naming  conventions"
  type        = string
  default     = "uan"
}
variable "log_analytics_workspace_name" {
    description = "The name of the Log Analytics workspace"
}
variable "log_analytics_workspace_rg" {
    description = "The resource group of the Log Analytics workspace"
}
variable "resource_ids_to_monitor" {
  type = list(string)
}
