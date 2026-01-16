resource "azurerm_resource_group" "rg-service-bus" {
  name     = "${var.name-prefix}-${var.servicebus_resource_group_name}"
  location = var.location
}


resource "azurerm_servicebus_namespace" "servicebus"{
  name                = var.name-prefix
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = var.sku
  capacity            = var.servicebus_capacity
  tags                = var.tags
}

resource "azurerm_monitor_autoscale_setting" "autoscale"{
  name                = var.autoscale_setting_name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  target_resource_id  = azurerm_servicebus_namespace.servicebus.id

  profile {
    name = "AutoScaleProfile"

    capacity {
      default = var.autoscale_default_capacity
      minimum = var.autoscale_minimum_capacity
      maximum = var.autoscale_maximum_capacity
    }

    rule {
      metric_trigger {
        metric_name        = "IncomingMessages"
        metric_resource_id = azurerm_servicebus_namespace.servicebus.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = var.autoscale_incoming_threshold
        metric_namespace   = "Microsoft.ServiceBus/namespaces"
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT5M"
      }
    }

    rule {
      metric_trigger {
        metric_name        = "IncomingMessages"
        metric_resource_id = azurerm_servicebus_namespace.servicebus.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = var.autoscale_incoming_threshold
        metric_namespace   = "Microsoft.ServiceBus/namespaces"
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT10M"
      }
    }
  }

  notification {
    email {
      send_to_subscription_administrator    = true
      send_to_subscription_co_administrator = false
    }
  }

  enabled = true
  tags    = var.tags
}
