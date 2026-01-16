# === Compute Modules ===
module "compute" {
  source = "./modules/compute"
  location                = var.location
  ai_resource_group_name  = var.ai_resource_group_name
  ai_foundry_name         = var.ai_foundry_name
  ai_foundry_project_name = var.ai_foundry_project_name
  app_service_plans       = var.app_service_plans
  app_services            = var.app_services
  function_apps           = var.function_apps
  vms                     = var.vms
  tags                    = var.tags
  vmss                    = var.vmss
  avd                     = var.avd
  
 
}

# === Containers Modules ===
module "containers" {
  source = "./modules/containers"
  location                     = var.location
  container_app_environments   = var.container_app_environments
  container_apps               = var.container_apps
  tags                         = var.tags
  aks_resource_group_name      = var.aks_resource_group_name
  prefix                       = var.prefix
  default_node_pool_config      = var.default_node_pool_config
  subnet_id                    = var.subnet_id
}

# === Data Modules ===
module "datafactory" {
  source                     = "./modules/data"
  location                   = var.location
  df_resource_group_name     = var.df_resource_group_name
  data_factory_name          = var.data_factory_name
  storage_account_name       = var.storage_account_name
  df_identity_name           = var.df_identity_name
  admin_username             = var.admin_username
  admin_password             = var.admin_password
  df_subnet_id               = var.df_subnet_id
  df_vnet_id                 = var.df_vnet_id
  df_pe_name                 = var.df_pe_name
  df_nic_name                = var.df_nic_name
  df_nsg_name                = var.df_nsg_name
  df_public_ip_name          = var.df_public_ip_name
  df_vm_name                 = var.df_vm_name
  df_size                    = var.df_size
  redis_resource_group_name  = var.redis_resource_group_name
  redis_name                 = var.redis_name
  redis_sku_name             = var.redis_sku_name
  zones                      = var.zones
  nic_name                   = var.nic_name
  private_dns_zone_name      = var.private_dns_zone_name
  pe_name                    = var.pe_name
  redis_subnet_id            = var.redis_subnet_id
  redis_vnet_id              = var.redis_vnet_id
  sql_resource_group_name    = var.sql_resource_group_name
  sql_server_name            = var.sql_server_name
  sql_server_version         = var.sql_server_version
  sql_admin_login            = var.sql_admin_login
  sql_admin_password         = var.sql_admin_password
  sql_databases              = var.sql_databases
  tags                       = var.tags
}

# === Identity & Governance Modules ===
module "automation_account" {
  source                         = "./modules/identity_and_governance"
  location                       = var.location
  automation_account_name        = var.automation_account_name
  automation_sku_name            = var.automation_sku_name
  runbook_name                   = var.runbook_name
  runbook_type                   = var.runbook_type
  runbook_log_verbose            = var.runbook_log_verbose
  runbook_log_progress           = var.runbook_log_progress
  runbook_file_path              = var.runbook_file_path
  runbook_content_uri            = var.runbook_content_uri
  bing_resource_group_name       = var.bing_resource_group_name
  bing_grounding_search_name     = var.bing_grounding_search_name
  bing_sku_name                   = var.bing_sku_name
  tags                           = var.tags
  identity_name                  = var.identity_name
  eventgrid_topic_name           = var.eventgrid_topic_name
  eventgrid_source_id            = var.eventgrid_source_id
  eventgrid_topic_type           = var.eventgrid_topic_type
  resource_group_name            = var.resource_group_name
  communication_data_location    = var.communication_data_location
  storage_account_1_name         = var.storage_account_1_name
  storage_account_2_name         = var.storage_account_2_name
  communication_service_name     = var.communication_service_name
  selected_vm_name               = var.selected_vm_name
  comm_service_resource_group_name = var.comm_service_resource_group_name
  key_vault_name                 = var.key_vault_name
  tenant_id                      = var.tenant_id
  object_id                      = var.object_id
  servicebus_resource_group_name  = var.servicebus_resource_group_name
  servicebus_namespace_name       = var.servicebus_namespace_name
  servicebus_capacity             = var.servicebus_capacity
  autoscale_setting_name          = var.autoscale_setting_name
  autoscale_minimum_capacity      = var.autoscale_minimum_capacity
  autoscale_default_capacity      = var.autoscale_default_capacity
  autoscale_maximum_capacity      = var.autoscale_maximum_capacity
  autoscale_incoming_threshold    = var.autoscale_incoming_threshold
  sku                             = var.sku
  create_new_resources           = var.create_new_resources
  vault_resource_group_name       = var.vault_resource_group_name
  subscription_id                = var.subscription_id
  environment                   = var.environment
  project_name                   = var.project_name
  aks_resource_group_name        = var.aks_resource_group_name

}


# === Monitoring Module ===
module "monitor" {
  source                        = "./modules/monitoring"
  log_analytics_workspace_name  = var.log_analytics_workspace_name
  log_analytics_workspace_rg    = var.log_analytics_workspace_rg
  resource_ids_to_monitor       = var.resource_ids_to_monitor
  location                      = var.location
  log_analytics_resource_group_name = var.log_analytics_resource_group_name
  environment                   = var.environment
  project_name                  = var.project_name
  subscription_id                 = var.subscription_id
  tags =       var.tags
 
}

# === Network Modules ===
module "network" {
  source                   = "./modules/network"
  appgw_rg_name            = var.appgw_rg_name
  appgw_pip_name           = var.appgw_pip_name
  app_gateway_name         = var.app_gateway_name
  natgw_lb_rg_name         = var.natgw_lb_rg_name
  nat_gateway_name         = var.nat_gateway_name
  subnets_to_attach_nat    = var.subnets_to_attach_nat
  natgw_pip_name           = var.natgw_pip_name
  lb_pip_name              = var.lb_pip_name
  load_balancer_name       = var.load_balancer_name
  lb_backend_pool_name     = var.lb_backend_pool_name
  lb_probe_name            = var.lb_probe_name
  lb_rule_name             = var.lb_rule_name
  lb_frontend_config_name  = var.lb_frontend_config_name
  network_interfaces       = var.network_interfaces
  vnet_scope_key           = var.vnet_scope_key
  vnet_atlas_key           = var.vnet_atlas_key
  vnet_hub_key             = var.vnet_hub_key
  hub_subnet_name          = var.hub_subnet_name
  hub_vnet_rg              = var.hub_vnet_rg
  dns_name                 = var.dns_name
  dns_rg_name              = var.dns_rg_name
  a_record                 = var.a_record
  a_name                   = var.a_name
  cname_name               = var.cname_name
  cname_record             = var.cname_record
  vnets                    = var.vnets
  preexisting_subnet_names = var.preexisting_subnet_names
  dns_vnet_links           = var.dns_vnet_links
  location                 = var.location
  allocation_method        = var.allocation_method
  date_created             = var.date_created
  network_resource_group_name = var.network_resource_group_name
  backend_host             = var.backend_host
  frontdoor_name           = var.frontdoor_name
  frontdoor_resource_group_name = var.frontdoor_resource_group_name
  
}

