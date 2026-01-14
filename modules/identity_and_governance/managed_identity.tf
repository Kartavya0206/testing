resource "azurerm_resource_group" "mi_rg" {
  for_each = var.create_new_resources ? { for mi in var.managed_identities : mi.name => mi } : {}
  name     = each.value.mi_resource_group_name
  location = var.location
  tags     = var.tags
}

resource "azurerm_user_assigned_identity" "managed_identity" {
  for_each            = var.create_new_resources ? { for mi in var.managed_identities : mi.name => mi } : {}
  name                = each.value.name
  resource_group_name = azurerm_resource_group.mi_rg[each.key].name
  location            = each.value.location

}

