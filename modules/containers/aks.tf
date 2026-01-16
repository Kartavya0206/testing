resource "azurerm_resource_group" "aks" {
  name     = var.aks_resource_group_name
  location = var.location
  tags     = var.tags
}

resource "azurerm_kubernetes_cluster" "main" {
  name                = "${var.prefix}-aks"
  location            = var.location
  resource_group_name = azurerm_resource_group.aks.name
  dns_prefix          = "${var.prefix}-aks"
  kubernetes_version  = var.kubernetes_version

  private_cluster_enabled = true
  sku_tier                = "Standard"

  oidc_issuer_enabled       = true
  workload_identity_enabled = true

  default_node_pool {
    name                = var.default_node_pool_config.name
    vm_size             = var.default_node_pool_config.vm_size
    vnet_subnet_id      = var.subnet_id
    os_disk_size_gb     = var.default_node_pool_config.os_disk_size_gb
    os_disk_type        = var.default_node_pool_config.os_disk_type

    # enable_auto_scaling = true
    node_count          = null
    min_count           = var.default_node_pool_config.min_count
    max_count           = var.default_node_pool_config.max_count
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin      = "azure"
    network_plugin_mode = "overlay"
    network_policy      = "azure"
    load_balancer_sku   = "standard"
    service_cidr        = "10.0.0.0/16"
    dns_service_ip      = "10.0.0.10"
  }

  tags = var.tags

  depends_on = [azurerm_container_registry.main]
}
