output "rg" {
  value = [
    for rg in azurerm_resource_group.vnet-rg :
    rg.name
  ]
}

output "vnet" {
  value = {
    for vnet_key, vnet in azurerm_virtual_network.vnet :
    vnet_key => vnet.id
  }
}

output "subnet" {
  value = {
    for subnet_key, subnet in azurerm_subnet.subnet :
    subnet_key => subnet.id
  }
}

output "vnet_scope_to_atlas" {
  value = try(azurerm_virtual_network_peering.vnet_scope_to_atlas.id, null)
}

output "vnet_atlas_to_scope" {
  value = try(azurerm_virtual_network_peering.vnet_atlas_to_scope.id, null)
}

output "nat_gateway_ids" {
  value = [for ngw in azurerm_nat_gateway.nat_gateway : ngw.id]
}

output "nat_gateway_public_ip" {
  value = azurerm_public_ip.nat_gateway_pip.ip_address
}

output "nat_gateway_associated_subnets" {
  value = {
    for key, assoc in azurerm_subnet_nat_gateway_association.nat_gateway_association :
    key => assoc.subnet_id
  }
}

output "express_route_ids" {
  value = [for er in azurerm_express_route_circuit.erc : er.id]
}

