resource "azurerm_resource_group" "vm_rg" {
  for_each = { for vm in var.vms : vm.name => vm }

  name     = each.value.resource_group
  location = var.location
}

resource "azurerm_network_interface" "vm_nic" {
  for_each = { for vm in var.vms : vm.name => vm }

  name                = "${each.value.name}-nic"
  location            = var.location
  resource_group_name = each.value.resource_group

  ip_configuration {
    name                          = "internal"
    subnet_id                     = each.value.subnet_id
    private_ip_address_allocation = "Dynamic"
  }

  depends_on = [
    azurerm_resource_group.vm_rg
  ]
}

resource "azurerm_public_ip" "vm_pip" {
  for_each = { for vm in var.vms : vm.name => vm }

  name                = "${each.value.name}-pip"
  location            = var.location
  resource_group_name = azurerm_resource_group.vm_rg[each.key].name
  allocation_method   = "Static"
  sku                 = "Standard"
}

locals {
  flattened_data_disks = merge([
    for vm in var.vms : (
      vm.data_disks != null ? {
        for idx, disk in vm.data_disks :
        "${vm.name}-datadisk-${idx}" => {
          vm_name        = vm.name
          location       = var.location
          resource_group = vm.resource_group
          disk_type      = disk.disk_type
          disk_size_gb   = disk.disk_size_gb
          lun            = idx
          os_type        = vm.os_type
        }
      } : {}
    )
  ]...)
}

resource "azurerm_managed_disk" "data_disks" {
  for_each = local.flattened_data_disks

  name                 = each.key
  location             = var.location
  resource_group_name  = each.value.resource_group
  storage_account_type = each.value.disk_type
  create_option        = "Empty"
  disk_size_gb         = each.value.disk_size_gb
}

resource "azurerm_windows_virtual_machine" "windows_vm" {
  for_each = {
    for vm in var.vms : vm.name => vm if vm.os_type == "Windows"
  }

  name                  = each.value.name
  resource_group_name   = each.value.resource_group
  location              = var.location
  size                  = each.value.size
  admin_username        = each.value.admin_username
  admin_password        = each.value.admin_password
  computer_name         = each.value.computer_name
  network_interface_ids = [azurerm_network_interface.vm_nic[each.key].id]

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

resource "azurerm_linux_virtual_machine" "linux_vm" {
  for_each = {
    for vm in var.vms : vm.name => vm if vm.os_type == "Linux"
  }

  name                            = each.value.name
  resource_group_name             = each.value.resource_group
  location                        = var.location
  size                            = each.value.size
  admin_username                  = each.value.admin_username
  admin_password                  = each.value.admin_password
  disable_password_authentication = false
  network_interface_ids           = [azurerm_network_interface.vm_nic[each.key].id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = each.value.os_disk.disk_type
    name                 = "${each.value.name}-osdisk"
    disk_size_gb         = each.value.os_disk.disk_size_gb
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = split(":", each.value.version)[0]
    sku       = split(":", each.value.version)[1]
    version   = "latest"
  }
}

resource "azurerm_virtual_machine_data_disk_attachment" "disk_attach" {
  for_each = local.flattened_data_disks

  managed_disk_id    = azurerm_managed_disk.data_disks[each.key].id
  virtual_machine_id = (
    each.value.os_type == "Windows" ?
    azurerm_windows_virtual_machine.windows_vm[each.value.vm_name].id :
    azurerm_linux_virtual_machine.linux_vm[each.value.vm_name].id
  )

  lun     = each.value.lun
  caching = "ReadWrite"
}

resource "azurerm_user_assigned_identity" "identity" {
  for_each = {
    for vm in var.vms : vm.name => vm if vm.identity_name != null
  }

  name                = "${var.name-prefix}-${each.value.identity_name}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
}
