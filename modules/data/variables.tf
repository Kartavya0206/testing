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

variable "sql_resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "sql_server_name" {
  type        = string
  description = "Name of the SQL server"
}

variable "sql_server_version" {
  type        = string
  default     = "12.0"
  description = "SQL server version"
}

variable "sql_admin_login" {
  type        = string
  description = "SQL admin login"
}

variable "sql_admin_password" {
  type        = string
  description = "SQL admin password"
  sensitive   = true
}

variable "sql_databases" {
  type = list(object({
    name         = string
    sku_name     = string
    max_size_gb  = number
  }))
  description = "List of SQL databases with individual configs"
}


variable "name-prefix" {
  description = "Prefix for resource names"
  type        = string
  default     = ""
}

variable "df_resource_group_name" {
  type        = string
  description = "The name of the resource group"
}
variable "df_identity_name" {
  description = "The name of the user assigned identity for the Data Factory"
  type        = string
}
variable "storage_account_name" {
  description = "The name of the storage account for the Data Factory"
  type        = string
}
variable "data_factory_name" {
  description = "The name of the Data Factory"
  type        = string
}
variable "df_nic_name" {
  description = "The name of the network interface for the Data Factory"
  type        = string
}
variable "df_nsg_name" {
  description = "The name of the network security group for the Data Factory"
  type        = string
}
variable "df_public_ip_name" {
  description = "The name of the public IP address for the Data Factory"
  type        = string
}
variable "df_vm_name" {
  description = "The name of the virtual machine for the Data Factory"
  type        = string
}
variable "admin_username" {
  description = "The admin username for the virtual machine"
  type        = string
}
variable "admin_password" {
  description = "The admin password for the virtual machine"
  type        = string
}
variable "df_subnet_id" {
  description = "The ID of the subnet for the Data Factory"
  type        = string
}
variable "df_vnet_id" {
  description = "The ID of the virtual network for the Data Factory"
  type        = string
}
variable "df_pe_name" {
  description = "The name of the private endpoint for the Data Factory"
  type        = string
}
variable "df_size" {
  type        = string
  description = "Size of the virtual machine"
  default     = ""
}

variable "tags" {
  type = map(string)
}


variable "redis_resource_group_name" {
  type        = string
  description = "The name of the resource group"
}
variable "redis_name" {
  type        = string
  description = "Name of the Redis Enterprise Cluster"
}

variable "redis_sku_name" {
  type        = string
  description = "SKU name (e.g., 'Enterprise_E10')"
}

variable "zones" {
  type        = list(string)
  description = "Availability zones"
  default     = []
}

variable "nic_name" {
  type        = string
  description = "Name of the network interface"
}

variable "private_dns_zone_name" {
  type        = string
  description = "Private DNS Zone name"
}

variable "pe_name" {
  type        = string
  description = "Name of the Private Endpoint"
}

variable "redis_subnet_id" {
  type        = string
  description = "Subnet ID to attach resources to"
}

variable "redis_vnet_id" {
  type        = string
  description = "Virtual network ID for the VNet link"
}
