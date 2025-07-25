resource "azurerm_log_analytics_workspace" "log_workspace" {
  name                = var.log_analytics_workspace_name
  location            = var.location
  resource_group_name = var.log_analytics_workspace_rg
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_monitor_diagnostic_setting" "diagnostic" {
  for_each            = toset(var.resource_ids_to_monitor)
  name                = "diag-${replace(each.value, "/", "-")}"
  target_resource_id  = each.value
  log_analytics_workspace_id = azurerm_log_analytics_workspace.log_workspace.id

  dynamic "log" {
    for_each = ["AuditLogs", "SignInLogs", "Administrative"] # Add others if needed
    content {
      category = log.value
      enabled  = true

      retention_policy {
        enabled = false
        days    = 0
      }
    }
  }

  dynamic "metric" {
    for_each = ["AllMetrics"]
    content {
      category = metric.value
      enabled  = true

    }
  }
}
