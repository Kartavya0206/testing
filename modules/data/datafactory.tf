resource "azurerm_resource_group" "rg" {
  name     = "${var.name-prefix}-${var.df_resource_group_name}"
  location = var.location
}

resource "azurerm_user_assigned_identity" "df_identity" {
  name                = "${var.name-prefix}-${var.df_identity_name}"
  resource_group_name = var.resource_group_name
  location            = var.location
}

resource "azurerm_storage_account" "df_storage" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_data_factory" "data_factory" {
  name                = var.data_factory_name
  location            = var.location
  resource_group_name = var.resource_group_name
  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.df_identity.id]
  }
  tags = var.tags
}

resource "azurerm_network_interface" "df_nic" {
  name                = var.df_nic_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_security_group" "df_nsg" {
  name                = var.df_nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_public_ip" "df_pip" {
  name                = var.df_public_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
}

resource "azurerm_windows_virtual_machine" "df_vm" {

  name                  = var.df_vm_name
  resource_group_name   = var.df_resource_group_name
  location              = var.location
  size                  = var.df_size
  admin_username        = var.admin_username
  admin_password        = var.admin_password
  network_interface_ids = [azurerm_network_interface.df_nic.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = each.value.os_disk.disk_type
    name                 = "${each.value.name}-osdisk"
    disk_size_gb         = each.value.os_disk.disk_size_gb
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = split(":", each.value.version)[0]
    sku       = split(":", each.value.version)[1]
    version   = "latest"
  }
}

resource "azurerm_private_dns_zone" "df_private_dns" {
  name                = "privatelink.datafactory.azure.net"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_endpoint" "df_private_endpoint" {
  name                = var.df_pe_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "dfConnection"
    private_connection_resource_id = azurerm_data_factory.data_factory.id
    subresource_names              = ["dataFactory"]
    is_manual_connection           = false
  }
}

resource "azurerm_private_dns_zone_virtual_network_link" "df_dns_link" {
  name                  = var.name-prefix
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.df_private_dns.name
  virtual_network_id    = var.vnet_id
  registration_enabled  = false
}
