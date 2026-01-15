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

variable "location" {
  type        = string
  description = "Azure Region"
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

############ NSG Variables ##############
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
variable "create_role_assignments" {
  description = "flag to  control creation of role assignments"
  type        = bool
  default     = true
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
