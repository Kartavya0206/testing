resource "azurerm_public_ip" "lb" {
  name                = var.lb_pip_name
  location            = var.location
  resource_group_name = var.natgw_lb_rg_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_lb" "lb" {
  name                = var.load_balancer_name
  location            = var.location
  resource_group_name = var.natgw_lb_rg_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = var.lb_frontend_config_name
    public_ip_address_id = azurerm_public_ip.lb.id
  }
}

resource "azurerm_lb_backend_address_pool" "backend_pool" {
  name            = var.lb_backend_pool_name
  loadbalancer_id = azurerm_lb.lb.id
}

resource "azurerm_lb_probe" "probe" {
  name            = var.lb_probe_name
  loadbalancer_id = azurerm_lb.lb.id
  protocol        = "Tcp"
  port            = 80
  interval_in_seconds = 5
  number_of_probes    = 2
}

resource "azurerm_lb_rule" "rule" {
  name                           = var.lb_rule_name
  loadbalancer_id                = azurerm_lb.lb.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = var.lb_frontend_config_name
  probe_id                       = azurerm_lb_probe.probe.id
}
