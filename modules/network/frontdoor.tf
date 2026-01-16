resource "azurerm_resource_group" "fd_rg" {
  count    = var.create_new_resources ? 1 : 0
  name     = var.frontdoor_resource_group_name
  location = var.location
  tags     = var.tags
}

resource "azurerm_cdn_frontdoor_profile" "fd_profile" {
  count               = var.create_new_resources ? 1 : 0
  name                = var.frontdoor_name
  resource_group_name = azurerm_resource_group.fd_rg[0].name
  sku_name            = "Premium_AzureFrontDoor"   
  tags                = var.tags
}

resource "azurerm_cdn_frontdoor_endpoint" "fd_endpoint" {
  count                     = var.create_new_resources ? 1 : 0
  name                      = "${var.frontdoor_name}-endpoint"
  cdn_frontdoor_profile_id  = azurerm_cdn_frontdoor_profile.fd_profile[0].id
}

resource "azurerm_cdn_frontdoor_origin_group" "fd_origin_group" {
  count                     = var.create_new_resources ? 1 : 0
  name                      = "${var.frontdoor_name}-origin-group"
  cdn_frontdoor_profile_id  = azurerm_cdn_frontdoor_profile.fd_profile[0].id
  session_affinity_enabled  = false

  health_probe {
    interval_in_seconds = 30
    path                = "/"
    protocol            = "Https"
    request_type        = "GET"
  }

  load_balancing {
    sample_size                 = 4
    successful_samples_required = 3
    additional_latency_in_milliseconds = 50
  }
}

resource "azurerm_cdn_frontdoor_origin" "fd_origin" {
  count = var.create_new_resources && var.backend_host != "" ? 1 : 0
  
  name                              = "${var.frontdoor_name}-origin"
  cdn_frontdoor_origin_group_id     = azurerm_cdn_frontdoor_origin_group.fd_origin_group[0].id
  host_name                         = var.backend_host
  http_port                         = 80
  https_port                        = 443
  enabled                           = true
  certificate_name_check_enabled     = true
}

resource "azurerm_cdn_frontdoor_route" "fd_route" {
  count = var.create_new_resources && var.backend_host != "" ? 1 : 0
  
  name                             = "${var.frontdoor_name}-route"
  cdn_frontdoor_endpoint_id        = azurerm_cdn_frontdoor_endpoint.fd_endpoint[0].id
  cdn_frontdoor_origin_group_id    = azurerm_cdn_frontdoor_origin_group.fd_origin_group[0].id
  cdn_frontdoor_origin_ids         = [azurerm_cdn_frontdoor_origin.fd_origin[0].id]
  patterns_to_match                = ["/*"]                # Match all URLs
  supported_protocols              = ["Http", "Https"]
  forwarding_protocol              = "MatchRequest"
  enabled                          = true
}

resource "azurerm_user_assigned_identity" "frontdoor_identity" {
  count               = var.create_new_resources ? 1 : 0
  name                = "${var.frontdoor_name}-identity"
  location            = var.location
  resource_group_name = azurerm_resource_group.fd_rg[0].name
}




# A) (Optional but often useful) Reader on the Front Door resource group
#    This lets the identity read FG resources/metadata in the RG.
resource "azurerm_role_assignment" "fd_identity_rg_reader" {
  count               = var.create_new_resources && var.create_role_assignments ? 1 : 0
  scope                = azurerm_resource_group.fd_rg[0].id
  role_definition_name = "Reader"
  principal_id         = azurerm_user_assigned_identity.frontdoor_identity[0].principal_id

  depends_on = [
    azurerm_user_assigned_identity.frontdoor_identity,
    azurerm_resource_group.fd_rg
  ]
}