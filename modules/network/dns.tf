resource "azurerm_dns_zone" "dns" {
  name                = var.dns_name
  resource_group_name = var.dns_rg_name
}

resource "azurerm_dns_a_record" "a_record" {
  name                = var.a_name
  zone_name           = azurerm_dns_zone.dns.name
  resource_group_name = var.dns_rg_name
  ttl                 = 300
  records             = [var.a_record]
}

resource "azurerm_dns_cname_record" "cname" {
  name                = var.cname_name
  zone_name           = azurerm_dns_zone.dns.name
  resource_group_name = var.dns_rg_name
  ttl                 = 300
  record              = var.cname_record
}
