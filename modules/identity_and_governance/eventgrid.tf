resource "azurerm_resource_group" "rg" {
  name     = "${var.name-prefix}-${var.comm_service_resource_group_name}"
  location = var.location
}


resource "azurerm_communication_service" "comm_Service" {
  name                = "${var.name-prefix}-${var.communication_service_name}"
  resource_group_name = azurerm_resource_group.rg.name
  data_location       = var.communication_data_location
}

resource "azurerm_eventgrid_system_topic" "event_grid" {
  name                   = var.eventgrid_topic_name
  location               = var.location
  resource_group_name    = azurerm_resource_group.rg.name
  source_arm_resource_id = var.eventgrid_source_id
  topic_type             = var.eventgrid_topic_type
}

resource "azurerm_user_assigned_identity" "identity" {
  name                = "${var.name-prefix}-${var.identity_name}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
}
