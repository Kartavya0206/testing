############## Resource Group for Monitoring ###############
resource "azurerm_resource_group" "monitoring_rg" {
  name     = var.log_analytics_resource_group_name
  location = var.location
  tags     = var.tags
}
############# Data Collection Endpoint ###################
resource "azurerm_monitor_data_collection_endpoint" "dce" {
  name                = "dce-prod-demo-cind"
  location            = var.location
  resource_group_name = azurerm_resource_group.monitoring_rg.name
  public_network_access_enabled = false

  tags = var.tags
}

############# Data Collection Rule ###################
resource "azurerm_monitor_data_collection_rule" "dcr" {
  name                = "dcr-prod-demo-cind"
  location            = var.location
  resource_group_name = azurerm_resource_group.monitoring_rg.name
  data_collection_endpoint_id = azurerm_monitor_data_collection_endpoint.dce.id

  destinations {
    log_analytics {
      workspace_resource_id = azurerm_log_analytics_workspace.workspace.id
      name                  = "LogAnalyticsDestination"
    }
  }

  data_flow {
    streams       = ["Microsoft-Syslog", "Microsoft-Perf"]
    destinations  = ["LogAnalyticsDestination"]
  }

  tags = var.tags
}

############## Application Insights ##################
resource "azurerm_application_insights" "app_insights" {
  name                = "appinsights-${var.project_name}-${var.environment}-${var.region_code}"
  location            = var.location
  resource_group_name = azurerm_resource_group.monitoring_rg.name
  workspace_id        = azurerm_log_analytics_workspace.workspace.id
  application_type    = "web"
  retention_in_days   = 30  # 730 hours approximately 30 days

  tags = var.tags
}

############ Azure Monitor Workspace ###############
resource "azurerm_monitor_workspace" "monitor_workspace" {
  name                = "monitor-workspace-prod-demo-cind"
  location            = var.location
  resource_group_name = azurerm_resource_group.monitoring_rg.name

  tags = var.tags
}
############ Log Analytics Workspace ###############
resource "azurerm_log_analytics_workspace" "log_workspace" {
  name                = var.log_analytics_workspace_name
  location            = var.location
  resource_group_name = var.log_analytics_workspace_rg
  sku                 = "PerGB2018"
  retention_in_days   = 30
}
############ Diagnostic Settings for Resources ###############

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
