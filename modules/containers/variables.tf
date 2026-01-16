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

variable "tags" {
  description = "Tags to apply"
  type        = map(string)
  default     = {}
}

variable "container_apps" {
  description = "List of container app configurations"
  type = list(object({
    name                      = string
    resource_group_name       = string
    environment_id            = string
    revision_mode             = string
    container_name            = string
    image                     = string
    cpu                       = number
    memory                    = string
    min_replicas              = number
    max_replicas              = number
    target_port               = number
    external_enabled          = bool
    env_vars                  = list(object({ name = string, value = string }))
    create_identity           = optional(bool)
    create_storage_account    = optional(bool)
  }))
}

variable "container_app_environments" {
  description = "List of container app environment configurations"
  type = list(object({
    name                            = string
    resource_group_name             = string
    infrastructure_subnet_id       = string
    internal_load_balancer_enabled = bool
    # app_logs = object({
    #   destination = string
    #   log_analytics = object({
    #     customer_id = string
    #     shared_key  = string
    #   })
    # })
    tags = map(string)
  }))
}

#acr and aks variable


variable "aks_resource_group_name" {
  description = "Name of the resource group for AKS cluster"
  type        = string
}

variable "location" {
  description = "Azure region for resources"
  type        = string
}

variable "prefix" {
  description = "Prefix for resource names"
  type        = string
  default     = "demo"
}
variable "subnet_id" {
  description = "ID of the subnet where AKS will be deployed"
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version for AKS"
  type        = string
  default     = "1.28"
}

variable "default_node_pool_config" {
  description = "Configuration for AKS default node pool"
  type = object({
    name                = string
    node_count          = number
    min_count           = number
    max_count           = number
    vm_size            = string
    os_disk_size_gb    = number
    os_disk_type       = string
  })
}

variable "backup_cluster_size_gb" {
  description = "AKS cluster size for backup calculation"
  type        = number
  default     = 200
}

variable "backup_namespaces_count" {
  description = "Number of namespaces for AKS backup"
  type        = number
  default     = 5
}

variable "tags" {
  description = "Tags to be applied to all resources"
  type        = map(string)
  default     = {}
}


variable "acr_sku" {
  description = "SKU of the Container Registry (Basic, Standard, Premium)"
  type        = string
  default     = "Standard"
}

variable "aks_principal_id" {
  description = "Principal ID of AKS cluster for ACR pull access (if not provided, uses the principal ID of the AKS cluster created in this module)"
  type        = string
  default     = null
}

variable "aks_admin_object_id" {
  description = "Object ID of Azure AD group for AKS admins"
  type        = string
  default     = ""
}

