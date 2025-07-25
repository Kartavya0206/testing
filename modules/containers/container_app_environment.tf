resource "azurerm_resource_group" "container_env_rg" {
  for_each = {
    for env in var.container_app_environments : env.name => env
  }

  name     = "${var.name-prefix}-${each.value.resource_group_name}"
  location = var.location
}

resource "azurerm_container_app_environment" "environment" {
  for_each = {
    for env in var.container_app_environments : env.name => env
  }

  name                            = "${var.name-prefix}-${each.value.name}"
  location                        = var.location
  resource_group_name             = azurerm_resource_group.container_env_rg[each.key].name
  infrastructure_subnet_id        = each.value.infrastructure_subnet_id
  internal_load_balancer_enabled = each.value.internal_load_balancer_enabled

#   dynamic "app_logs" {
#     for_each = lookup(each.value, "app_logs", null) != null ? [1] : []
#     content {
#       destination = each.value.app_logs.destination
#       log_analytics_configuration {
#         customer_id = each.value.app_logs.log_analytics.customer_id
#         shared_key  = each.value.app_logs.log_analytics.shared_key
#       }
#     }
#   }

 lifecycle {
    create_before_destroy = true
  }

  tags = var.tags
}
