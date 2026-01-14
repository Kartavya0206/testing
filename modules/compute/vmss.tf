resource "azurerm_resource_group" "vmss-rg" {
    # for_each = var.vmss
  name     = each.value.resource_group
  location = var.location
}


resource "azurerm_windows_virtual_machine_scale_set" "vmss" {
    for_each = var.vmss
  name                 = each.value.name
  resource_group_name  = azurerm_resource_group.vmss-rg[each.key].name
  location             = var.location
  sku                  = each.value.sku
  instances            = 1
  admin_password       = each.value.admin_password
  admin_username       = each.value.admin_username
  computer_name_prefix = "vm-"

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = each.value.offer
    sku       = each.value.image_sku
    version   = "latest"
  }

  os_disk {
    storage_account_type = each.value.os_disk.disk_type
    caching              = "ReadWrite"
    disk_size_gb         = each.value.os_disk.disk_size_gb
  }

  network_interface {
    name    = "example"
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = azurerm_subnet.internal.id
    }
  }
}


resource "azurerm_monitor_autoscale_setting" "vmss_autoscale" {
  for_each = var.vmss

  name                = "${each.value.name}-autoscale"
  resource_group_name = azurerm_resource_group.vmss-rg[each.key].name
  location            = var.location
  target_resource_id  = azurerm_windows_virtual_machine_scale_set.vmss[each.key].id

  profile {
    name = "defaultProfile"

    capacity {
      default = var.capacity
      minimum = 1
      maximum = 10
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_windows_virtual_machine_scale_set.vmss[each.key].id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 75
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_windows_virtual_machine_scale_set.vmss[each.key].id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = 25
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }
  }
}
