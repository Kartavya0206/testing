locals {
  hub_vnet           = var.vnets[var.vnet_hub_key]
  hub_rg             = local.hub_vnet.rg_name
  hub_vnet_name      = local.hub_vnet.name
  appgw_subnet_name  = keys(local.hub_vnet.subnets)[0]

  appgw_be_pool_name  = "${local.hub_vnet_name}-beap"
  appgw_fe_port_name  = "${local.hub_vnet_name}-feport"
  appgw_fe_ip_name    = "${local.hub_vnet_name}-feip"
  appgw_http_setting  = "${local.hub_vnet_name}-be-htst"
  appgw_listener_name = "${local.hub_vnet_name}-httplstn"
  appgw_rule_name     = "${local.hub_vnet_name}-rqrt"
}

resource "azurerm_resource_group" "appgw" {
  name     = var.appgw_rg_name
  location = var.location
}

resource "azurerm_public_ip" "appgw" {
  name                = var.appgw_pip_name
  resource_group_name = azurerm_resource_group.appgw.name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_application_gateway" "waf" {
  name                = var.app_gateway_name
  resource_group_name = azurerm_resource_group.appgw.name
  location            = var.location

  sku {
    name     = "WAF_v2"
    tier     = "WAF_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "appGwIpConfig"
    subnet_id = azurerm_subnet.subnet["${var.vnet_hub_key}.${local.appgw_subnet_name}"].id
  }

  frontend_port {
    name = local.appgw_fe_port_name
    port = 80
  }

  frontend_ip_configuration {
    name                 = local.appgw_fe_ip_name
    public_ip_address_id = azurerm_public_ip.appgw.id
  }

  backend_address_pool {
    name = local.appgw_be_pool_name
  }

  backend_http_settings {
    name                  = local.appgw_http_setting
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 20
  }

  http_listener {
    name                           = local.appgw_listener_name
    frontend_ip_configuration_name = local.appgw_fe_ip_name
    frontend_port_name             = local.appgw_fe_port_name
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = local.appgw_rule_name
    rule_type                  = "Basic"
    http_listener_name         = local.appgw_listener_name
    backend_address_pool_name  = local.appgw_be_pool_name
    backend_http_settings_name = local.appgw_http_setting
    priority                   = 100
  }

  waf_configuration {
    enabled          = true
    firewall_mode    = "Prevention"
    rule_set_type    = "OWASP"
    rule_set_version = "3.2"
  }
}
