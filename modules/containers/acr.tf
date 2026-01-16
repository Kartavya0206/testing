# Azure Container Registry
resource "azurerm_container_registry" "main" {
  name                = "${var.prefix}-acr"
  location            = var.location
  resource_group_name = var.aks_resource_group_name
  admin_enabled       = false
  sku                 = var.acr_sku

  network_rule_bypass_option    = "AzureServices"
  public_network_access_enabled = true

  tags = var.tags
}

# Role Assignment for AKS to pull images from ACR
resource "azurerm_role_assignment" "aks_acr_pull" {
  scope              = azurerm_container_registry.main.id
  role_definition_name = "AcrPull"
  principal_id       = azurerm_kubernetes_cluster.main.kubelet_identity[0].object_id

  depends_on = [azurerm_kubernetes_cluster.main]
}
