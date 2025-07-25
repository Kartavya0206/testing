resource "azurerm_resource_group" "rg" {
  name     = var.redis_resource_group_name
  location = var.location
}
resource "azurerm_redis_enterprise_cluster" "redis_cluster" {
  name                = var.redis_name
  location            = var.location
  resource_group_name = var.redis_resource_group_name
  sku_name            = var.redis_sku_name
  minimum_tls_version = "1.2"
  zones               = var.zones
}

resource "azurerm_network_interface" "redis_nic" {
  name                = var.nic_name
  location            = var.location
  resource_group_name = var.redis_resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.redis_subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_private_dns_zone" "redis_dns" {
  name                = var.private_dns_zone_name
  resource_group_name = var.redis_resource_group_name
}

resource "azurerm_private_endpoint" "redis_pe" {
  name                = var.pe_name
  location            = var.location
  resource_group_name = var.redis_resource_group_name
  subnet_id           = var.redis_subnet_id

  private_service_connection {
    name                           = "redis-pe-connection"
    private_connection_resource_id = azurerm_redis_enterprise_cluster.redis_cluster.id
    subresource_names              = ["redisEnterprise"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "redis-dns-zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.redis_dns.id]
  }
}

resource "azurerm_private_dns_zone_virtual_network_link" "redis_vnet_link" {
  name                  = "${var.redis_name}-vnet-link"
  resource_group_name   = var.redis_resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.redis_dns.name
  virtual_network_id    = var.redis_vnet_id
  registration_enabled  = false
}
