#output for acr and aks if used

output "cluster_id" {
  description = "ID of the AKS cluster"
  value       = azurerm_kubernetes_cluster.main.id
}

output "cluster_name" {
  description = "Name of the AKS cluster"
  value       = azurerm_kubernetes_cluster.main.name
}

output "cluster_fqdn" {
  description = "FQDN of the AKS cluster"
  value       = azurerm_kubernetes_cluster.main.fqdn
}

output "kube_config" {
  description = "Kubeconfig for the AKS cluster"
  value       = azurerm_kubernetes_cluster.main.kube_config_raw
  sensitive   = true
}

output "cluster_ca_certificate" {
  description = "CA certificate of the AKS cluster"
  value       = azurerm_kubernetes_cluster.main.kube_config.0.cluster_ca_certificate
  sensitive   = true
}

output "cluster_username" {
  description = "Username for the AKS cluster"
  value       = azurerm_kubernetes_cluster.main.kube_config.0.username
  sensitive   = true
}

output "cluster_password" {
  description = "Password for the AKS cluster"
  value       = azurerm_kubernetes_cluster.main.kube_config.0.password
  sensitive   = true
}

output "host" {
  description = "Host endpoint for the AKS cluster"
  value       = azurerm_kubernetes_cluster.main.kube_config.0.host
  sensitive   = true
}

output "node_resource_group" {
  description = "Name of the node resource group"
  value       = azurerm_kubernetes_cluster.main.node_resource_group
}

output "private_fqdn" {
  description = "Private FQDN of the AKS cluster (for private cluster)"
  value       = azurerm_kubernetes_cluster.main.private_fqdn
}

output "is_private_cluster" {
  description = "Indicates if the AKS cluster is private"
  value       = azurerm_kubernetes_cluster.main.private_cluster_enabled
}

output "oidc_issuer_url" {
  description = "The URL on the AKS cluster OIDC issuer - retrieve via: az aks show -g <rg> -n <cluster> --query oidcIssuerProfile.issuerUrl"
  value       = ""
}

output "workload_identity_enabled" {
  description = "Indicates if workload identity is enabled"
  value       = azurerm_kubernetes_cluster.main.workload_identity_enabled
}

output "azure_rbac_enabled" {
  description = "Indicates if Azure RBAC is enabled"
  value       = length(azurerm_kubernetes_cluster.main.azure_active_directory_role_based_access_control) > 0 ? azurerm_kubernetes_cluster.main.azure_active_directory_role_based_access_control[0].azure_rbac_enabled : false
}

output "kubelet_identity" {
  description = "The identity of the kubelet"
  value       = {
    client_id       = azurerm_kubernetes_cluster.main.kubelet_identity[0].client_id
    object_id       = azurerm_kubernetes_cluster.main.kubelet_identity[0].object_id
    user_assigned_identity_id = azurerm_kubernetes_cluster.main.kubelet_identity[0].user_assigned_identity_id
  }
}

output "principal_id" {
  description = "Principal ID of the AKS cluster system-assigned identity"
  value       = azurerm_kubernetes_cluster.main.identity[0].principal_id
}