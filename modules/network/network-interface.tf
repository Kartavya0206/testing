locals {
  subnet_map = {
    for s in azurerm_subnet.subnet : s.name => s.id
  }
}

resource "azurerm_network_interface" "nic" {
  for_each = {
    for nic in var.network_interfaces : nic.name => nic
  }

  name                = each.value.name
  location            = var.location
  resource_group_name = each.value.nic_rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = local.subnet_map[each.value.subnet_name]
    private_ip_address_allocation = var.allocation_method
  }

  tags = lookup(each.value, "tags", null)
}
