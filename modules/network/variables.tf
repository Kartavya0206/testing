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