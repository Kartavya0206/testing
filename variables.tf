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


variable "resource_group_name" {
  type        = string
  description = "Resource group name"
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


variable "app_service_plans" {
  description = "List of app service plans to create"
  type = list(object({
    name                = string
    resource_group_name = string
    sku_tier            = string
    sku_size            = string
    sku_capacity        = number
    kind                = string
    per_site_scaling    = optional(bool, false)
    is_xenon            = optional(bool, false)
    reserved            = optional(bool, false) # for Linux
  }))
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

#------Containers------

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


#--------------Data----------
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


#--------identity and governance---------



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
variable "vault_resource_group_name" {
  description = "Name of the resource group for the Key Vault"
  type        = string
}

variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
  
}
variable "environment" {
  description = "Deployment environment (e.g., dev, prod)"
  type        = string
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  
}
variable "aks_resource_group_name" {
  description = "Name of the resource group for AKS"
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

#------- Monitoring--------
variable "log_analytics_workspace_name" {
    description = "The name of the Log Analytics workspace"
}
variable "log_analytics_workspace_rg" {
    description = "The resource group of the Log Analytics workspace"
}
variable "log_analytics_resource_group_name" {
  description = "The resource group name for Log Analytics"
  type        = string
  
}
variable "resource_ids_to_monitor" {
  type = list(string)
}

#----------network-----------
variable "vnets" {
  type = map(object({
    name          = string
    rg_name       = string
    address_space = list(string)
    subnets       = map(object({
      cidr = string
    }))
    tags = map(string)
  }))
  description = "Map of VNet configurations including RG, address space and subnets"
}

variable "date_created" {
  type    = string
  default = ""  # Optional: you can set "" or some fallback
}

variable "vnet_scope_key" {
  type = string
}

variable "vnet_atlas_key" {
  type = string
}

variable "vnet_hub_key" {
  type = string
}

variable "hub_subnet_name" {
  type = string
}

variable "hub_vnet_rg" {
  type = string
}

variable "appgw_rg_name" {
  type = string
}

variable "appgw_pip_name" {
  type = string
}

variable "app_gateway_name" {
  type = string
}

variable "enable_nat_gateway" {
  type    = bool
  default = true
}

variable "natgw_lb_rg_name" {
  type = string
}

variable "nat_gateway_name" {
  type = string
}

variable "subnets_to_attach_nat" {
  type = set(string)
}

variable "natgw_pip_name" {
  type = string
}

variable "lb_pip_name" {
  type = string
}
variable "load_balancer_name" {
  type = string
}
variable "lb_backend_pool_name" {
  type = string
}
variable "lb_probe_name" {
  type = string
}
variable "lb_rule_name" {
  type = string
}

variable "preexisting_subnet_names" {
  description = "Map of pre-existing subnet names to their VNet and RG info"
  type = map(object({
    vnet_name           = string
    resource_group_name = string
  }))
}

variable "lb_frontend_config_name" {
  type = string
}
variable "cname_record"{
  type = string
}
variable "dns_rg_name"{
  type = string
} 
variable "cname_name" {
  type = string
}
variable "a_name" {
  type = string
}
variable "dns_name" {
  type = string
}

variable "a_record" {
  type = string
}

variable "allocation_method" {
  type = string
}
variable "network_interfaces" {
  type = list(object({
    name            = string
    nic_rg_name     = string
    subnet_name     = string
    # optionally override defaults if needed
    location        = optional(string)
    vnet_name       = optional(string)
    allocation_method = optional(string)
    tags            = optional(map(string))
  }))
}

variable "dns_vnet_links" {
  type = list(object({
    name             = string
    private_dns_zone = string
    vnetlink_rg      = string
    vnet_name        = string
    registration     = bool
    tags             = map(string)  # <-- Add this line
  }))
}
# Front Door Configuration
variable "frontdoor_name" {
  description = "The name of the Azure Front Door profile"
  type        = string
}

variable "frontdoor_resource_group_name" {
  description = "The resource group to deploy the Azure Front Door profile"
  type        = string
}

variable "backend_host" {
  description = "The backend hostname for origin"
  type        = string
}

variable "backend_address" {
  description = "The backend address for origin (optional, only needed if not using backend_host as DNS)"
  type        = string
  default     = ""
}


########### NSG Variables ##############
variable "network_resource_group_name" {
  description = "Name of the resource group for network resources"
  type        = string
}
variable "tags" {
  description = "Tags to be applied to resources"
  type        = map(string)
  default     = {}
}
variable "create_new_resources" {
  description = "Flag to determine if new resources should be created"
  type        = bool
  default     = true
}
variable "nsg_rules" {
  description = "List of NSG rules to create"
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  default = []
}

############# Public IP Variables ##############
variable "public_ips" {
  description = "A map of Public IP configurations."
  type = map(object({
    resource_group_name   = string
    public_ip_name        = string
    allocation_method     = string
    sku_name              = string
    ip_version            = string
    zones                 = list(string)
  }))
}
variable "project_name" {
  description = "The name of the project."
  type        = string
}
variable "environment" {
  description = "The deployment environment (e.g., dev, prod)."
  type        = string
}
