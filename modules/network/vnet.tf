locals {
  
  subnets = flatten([
    for vnet_key, vnet in var.vnets : [
      for subnet_name, subnet in vnet.subnets : {
        vnet_key     = vnet_key
        vnet_name    = vnet.name
        subnet_name  = subnet_name
        cidr         = subnet.cidr
        rg_name      = vnet.rg_name
      }
    ]
  ])
}

locals {
  vnet_scope = var.vnets[var.vnet_scope_key]
  vnet_atlas = var.vnets[var.vnet_atlas_key]
}

resource "azurerm_resource_group" "vnet-rg" {
  for_each = {
    for vnet_key, vnet in var.vnets : vnet.rg_name => vnet
  }
  name     = each.value.rg_name
  location = var.location
  tags = merge(
    each.value.tags,
   
  )
}

resource "azurerm_virtual_network" "vnet" {
  for_each = var.vnets

  name                = each.value.name
  location            = var.location
  resource_group_name = azurerm_resource_group.vnet-rg[each.value.rg_name].name
  address_space       = each.value.address_space
  ddos_protection_plan {
    id     = azurerm_network_ddos_protection_plan.ddos.id
    enable = true
  }

  tags = merge(
    each.value.tags,

  )
}

resource "azurerm_subnet" "subnet" {
  for_each = {
    for s in local.subnets : "${s.vnet_key}.${s.subnet_name}" => s
  }

  name                 = each.value.subnet_name
  resource_group_name  = azurerm_resource_group.vnet-rg[each.value.rg_name].name
  virtual_network_name = azurerm_virtual_network.vnet[each.value.vnet_key].name
  address_prefixes     = [each.value.cidr]
}
