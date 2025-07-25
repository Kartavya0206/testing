resource "azurerm_automation_account" "aa" {
  name                = var.automation_account_name
  location            = azurerm_resource_group.vm_rg[var.selected_vm_name].location
  resource_group_name = azurerm_resource_group.vm_rg[var.selected_vm_name].name
  sku_name            = var.automation_sku_name

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}


resource "azurerm_automation_runbook" "runbook" {
  name                    = var.runbook_name
  location                = azurerm_automation_account.aa.location
  resource_group_name     = azurerm_automation_account.aa.resource_group_name
  automation_account_name = azurerm_automation_account.aa.name
  log_verbose             = var.runbook_log_verbose
  log_progress            = var.runbook_log_progress
  runbook_type            = var.runbook_type
  content                 = file(var.runbook_file_path)
  publish_content_link {
    uri = var.runbook_content_uri
  }
  tags = var.tags
}
