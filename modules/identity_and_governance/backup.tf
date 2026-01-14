# Resource Group for Recovery Services Vault
resource "azurerm_resource_group" "vault" {
  name     = var.vault_resource_group_name
  location = var.location
  tags     = var.tags
}

# Recovery Services Vault for backup
resource "azurerm_recovery_services_vault" "vault" {
  name                = "rsv-${var.project_name}-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.vault.name
  sku                 = "Standard"

  soft_delete_enabled = true

  tags = var.tags
}

# Backup policy for AKS
resource "azurerm_backup_policy_vm" "aks_policy" {
  name                = "backup-policy-aks-${var.environment}"
  resource_group_name = azurerm_resource_group.vault.name
  recovery_vault_name = azurerm_recovery_services_vault.vault.name

  backup {
    frequency = "Daily"
    time      = "03:00"
  }

  retention_daily {
    count = 7
  }

  retention_weekly {
    count    = 4
    weekdays = ["Sunday"]
  }
}

# Backup policy for databases
resource "azurerm_backup_policy_vm" "postgresql_policy" {
  name                = "backup-policy-postgresql-${var.environment}"
  resource_group_name = azurerm_resource_group.vault.name
  recovery_vault_name = azurerm_recovery_services_vault.vault.name

  backup {
    frequency = "Daily"
    time      = "02:00"
  }

  retention_daily {
    count = 30
  }

  retention_weekly {
    count    = 8
    weekdays = ["Sunday"]
  }
}
