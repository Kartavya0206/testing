resource "azurerm_resource_group" "ASP_rg" {
  for_each = { for plan in var.app_service_plans : plan.name => plan }

  name     = "${var.name-prefix}-${each.value.resource_group_name}"
  location = var.location
}


# App Service Plans
resource "azurerm_app_service_plan" "plans" {
  for_each = { for plan in var.app_service_plans : plan.name => plan }

  name                = "${var.name-prefix}-${each.value.name}"
  location            = var.location
  resource_group_name = "${var.name-prefix}-${each.value.resource_group_name}"
  kind                = each.value.kind
  reserved            = each.value.reserved
  per_site_scaling    = each.value.per_site_scaling
  is_xenon            = each.value.is_xenon

  sku {
    tier     = each.value.sku_tier
    size     = each.value.sku_size
    capacity = each.value.sku_capacity
  }

  depends_on = [azurerm_resource_group.ASP_rg]
}