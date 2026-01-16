location = "Central India"
name-prefix = "zynbit-strateu"
sql_resource_group_name = "default-sql-centralindia"


#NETWORK
# ---------------------------------------------
#  Application Gateway Configuration

appgw_rg_name     = "ZYNBIT-PROD-RESOURCE-GROUP"
appgw_pip_name    = "zynbit-appgw-pip"
app_gateway_name  = "zynbit-prod-application-gateway-waf-v2"

# ---------------------------------------------
# NAT Gateway Configuration

natgw_lb_rg_name      = "ZYNBIT-STARTEU-PRODUCTION"
nat_gateway_name      = "zynbit-strateu-production"
natgw_pip_name        = "zynbit-natgw-pip"
subnets_to_attach_nat = ["subnet1", "subnet2"]  # NAT will be attached to these

# ---------------------------------------------
#  Load Balancer Configuration

load_balancer_name         = "zynbit_starteu-production"
lb_pip_name                = "lb_public_ip"
lb_backend_pool_name       = "lb_backend_pool"
lb_rule_name               = "lb_rule"
lb_frontend_config_name    = "lb_frontend_config"
lb_probe_name              = "lb_probe"

# ---------------------------------------------
#  DNS Records

dns_rg_name     = "dns_rg"
dns_name        = "example.com"               # DNS Zone name
cname_name      = "app"                       # Subdomain for CNAME
cname_record    = "www.example.com"           # CNAME target
a_name          = "www"                       # A record subdomain
a_record        = "10.0.0.1"                  # A record IP (✅ FIXED: Removed brackets)

# ---------------------------------------------
#  Network Interfaces (NICs)

network_interfaces = [
  {
    name        = "zynbit-strateu-bastion"
    nic_rg_name = "ZYNBIT-STRATEU-BASTION"
    subnet_name = "subnet3"
  },
  {
    name        = "strateu-data-factory.nic.251792aa-e007-4db8-a70e-87e5ef994687"
    nic_rg_name = "ZYNBIT-STRATEU-DATA-FACTORY"
    subnet_name = "subnet4"
  },
  {
    name        = "stratus-df-integrated-runtime"
    nic_rg_name = "ZYNBIT-STRATEU-DATA-FACTORY"
    subnet_name = "subnet5"
  },
  {
    name        = "stratus.nic.8cb56f21-75e4-4d70-8c43-6ffa129cd4d6"
    nic_rg_name = "ZYNBIT-STRATEU-REDIS-ENTERPRISE"
    subnet_name = "subnet6"
  }
]

# --------------------------------------------
#  Existing Subnets

preexisting_subnet_names = {
  "subnet3" = {
    vnet_name           = "zynbit-prod-scope-vnet"
    resource_group_name = "ZYNBIT-PROD-SCOPE-RG"
  },
  "subnet4" = {
    vnet_name           = "zynbit-prod-scope-vnet"
    resource_group_name = "ZYNBIT-PROD-SCOPE-RG"
  },
  "subnet5" = {
    vnet_name           = "zynbit-prod-scope-vnet"
    resource_group_name = "ZYNBIT-PROD-SCOPE-RG"
  },
  "subnet6" = {
    vnet_name           = "zynbit-prod-scope-vnet"
    resource_group_name = "ZYNBIT-PROD-SCOPE-RG"
  }
}

# ---------------------------------------------
# Private DNS VNet Links

dns_vnet_links = [
  {
    name             = "zynbit-strateu"
    private_dns_zone = "privatelink.datafactory.azure.net"
    vnetlink_rg      = "ZYNBIT-PROD-SCOPE-RG"
    vnet_name        = "zynbit-prod-scope-vnet"
    registration     = false
  },
  {
    name             = "databricks-db5nnghzz7xts"
    private_dns_zone = "mangoplant-34633f33.eastus.azurecontainerapps.io"
    vnetlink_rg      = "ZYNBIT-PROD-SCOPE-RG"
    vnet_name        = "zynbit-prod-scope-vnet"
    registration     = false
  },
  {
    name             = "strateu-app-gateway"
    private_dns_zone = "mangoplant-34633f33.eastus.azurecontainerapps.io"
    vnetlink_rg      = "ZYNBIT-PROD-SCOPE-RG"
    vnet_name        = "zynbit-prod-scope-vnet"
    registration     = false
  },
  {
    name             = "zynbit-strateu-external"
    private_dns_zone = "ashypond-eb42b31b.eastus.azurecontainerapps.io"
    vnetlink_rg      = "ATLAS-RG"
    vnet_name        = "atlas-vnet"
    registration     = false
  },
  {
    name             = "cirrus-stratus-production"
    private_dns_zone = "ashypond-eb42b31b.eastus.azurecontainerapps.io"
    vnetlink_rg      = "ATLAS-RG"
    vnet_name        = "atlas-vnet"
    registration     = false
  },
  {
    name             = "zynbit-prod-virtual-network-waf-v2"
    private_dns_zone = "ashypond-eb42b31b.eastus.azurecontainerapps.io"
    vnetlink_rg      = "ATLAS-RG"
    vnet_name        = "atlas-vnet"
    registration     = false
  },
  {
    name             = "databricks-nrmt7254u4khy"
    private_dns_zone = "calmriver-69697b3c.eastus.azurecontainerapps.io"
    vnetlink_rg      = "ZYNBIT-PROD-SCOPE-RG"
    vnet_name        = "zynbit-prod-scope-vnet"
    registration     = false
  },
  {
    name             = "databricks-bxoogy3dn47ms"
    private_dns_zone = "graymushroom-82e912c3.eastus.azurecontainerapps.io"
    vnetlink_rg      = "ZYNBIT-PROD-SCOPE-RG"
    vnet_name        = "zynbit-prod-scope-vnet"
    registration     = false
  },
  {
    name             = "zynbit-strateu-internal"
    private_dns_zone = "wittydune-34aa2aa8.eastus.azurecontainerapps.io"
    vnetlink_rg      = "ZYNBIT-PROD-SCOPE-RG"
    vnet_name        = "zynbit-prod-scope-vnet"
    registration     = false
  },
  {
    name             = "databricks-ky3ujoswbtu3s"
    private_dns_zone = "purpledune-89db24b8.eastus.azurecontainerapps.io"
    vnetlink_rg      = "ZYNBIT-PROD-SCOPE-RG"
    vnet_name        = "zynbit-prod-scope-vnet"
    registration     = false
  },
  {
    name             = "databricks-zyyctysc74fi6"
    private_dns_zone = "politeriver-c19b9f2d.eastus.azurecontainerapps.io"
    vnetlink_rg      = "ZYNBIT-PROD-SCOPE-RG"
    vnet_name        = "zynbit-prod-scope-vnet"
    registration     = false
  },
  {
    name             = "stratus"
    private_dns_zone = "privatelink.redisenterprise.cache.azure.net"
    vnetlink_rg      = "ZYNBIT-PROD-SCOPE-RG"
    vnet_name        = "zynbit-prod-scope-vnet"
    registration     = false
  }
]

# ---------------------------------------------
# Virtual Networks Definition

vnets = {
  "zynbit-prod-hub-vnet" = {
    name          = "zynbit-prod-hub-vnet"
    rg_name       = "ZYNBIT-PROD-HUB-RG"
    address_space = ["10.1.0.0/16"]
    subnets = {
      appgw_subnet = { cidr = "10.1.1.0/24" }
    }
  }

  "zynbit-prod-scope-vnet" = {
    name          = "zynbit-prod-scope-vnet"
    rg_name       = "ZYNBIT-PROD-SCOPE-RG"
    address_space = ["10.2.0.0/16"]
    subnets = {
      subnet1 = { cidr = "10.2.1.0/24" }
      subnet2 = { cidr = "10.2.2.0/24" }
      subnet3 = { cidr = "10.2.3.0/24" }
      subnet4 = { cidr = "10.2.4.0/24" }
      subnet5 = { cidr = "10.2.5.0/24" }
      subnet6 = { cidr = "10.2.6.0/24" }
      subnet7 = { cidr = "10.2.7.0/24" }
      subnet8 = { cidr = "10.2.8.0/24" }
    }
  }

  "atlas-vnet" = {
    name          = "atlas-vnet"
    rg_name       = "ATLAS-RG"
    address_space = ["10.3.0.0/16"]
    subnets       = {}
  }
}


#----------------------------------------------

#Redis Enterprise
redis_resource_group_name = "strateu-rg"

redis_name              = "cirrus-stratus-redis-enterprise"
sku_name                = "Enterprise_E20-20"
zones                   = ["1"]

nic_name                = "stratus.nic.8cb56f21-75e4-4d70-8c43-6ffa129cd4d6"
private_dns_zone_name   = "privatelink.redisenterprise.cache.azure.net"
pe_name                 = "stratus"
subnet_id               = "/subscriptions/xxxxx/resourceGroups/strateu-rg/providers/Microsoft.Network/virtualNetworks/strateu-vnet/subnets/redis-subnet"
vnet_id                 = "/subscriptions/xxxxx/resourceGroups/strateu-rg/providers/Microsoft.Network/virtualNetworks/strateu-vnet"

#Data Factory
df_resource_group_name    = "ZYNBIT-STRATUEU-DATA-FACTORY"
df_identity_name          = "data-factory"
storage_account_name      = "strateudf"
os_type                   = "Windows"
version                   = "WindowsServer:2022-Datacenter"
df_nic_name               = "strateu-df-data-factory-nic"
df_nsg_name               = "strateu-df-integrated-runtime-nsg"
df_public_ip_name         = "strateu-df-integrated-runtime-pip"
df_vm_name                = "strateu-df-integrated-runtime"
df_size                   = "Standard_A2_v2"  
admin_username            = "adminuser"
admin_password            = "P@ssword1234!" 
# subnet_id               = "/subscriptions/xxx/resourceGroups/xxx/providers/Microsoft.Network/virtualNetworks/xxx/subnets/xxx"
# vnet_id                 = "/subscriptions/xxx/resourceGroups/xxx/providers/Microsoft.Network/virtualNetworks/xxx"
df_pe_name                = "strateu-data-factory-pe"
    os_disk = {
      disk_type     = "Standard_LRS"
      disk_size_gb  = 127
    }

tags = {
  project     = "df-deployment"
  environment = "dev"
}

#eventgrid
comm_service_resource_group_name = "communication"


communication_service_name    = "comms"
communication_data_location   = "Europe" 

eventgrid_topic_name          = "cirrus-stratus-comms"
eventgrid_source_id           = "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/cirrus-stratus-communication/providers/Microsoft.Communication/communicationServices/cirrus-stratus-comms"
eventgrid_topic_type          = "Microsoft.Communication.CommunicationServices"
identity_name                 = "comms"

#Key vault 
kv_resource_group_name        = "default-storage-northeu"

tenant_id                 = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"  #variable in azure devops
object_id                 = "yyyyyyyy-yyyy-yyyy-yyyy-yyyyyyyyyyyy"  #variable in azure devops

key_vault_name            = "zynbit-keyvault-prod"
storage_account_1_name    = "portalvhds3hdvrg1p0xds4"
storage_account_2_name    = "zynbitproduction"

#Service Bus
servicebus_resource_group_name = "service-bus"


servicebus_capacity           = 1
sku                           = "Premium"
autoscale_setting_name        = "sb-autoscale"
autoscale_minimum_capacity    = "1"
autoscale_default_capacity    = "1"
autoscale_maximum_capacity    = "3"
autoscale_incoming_threshold  = 1000

#network
# ---------------------------------------------
# General Network Configuration

allocation_method = "Dynamic"  # IP allocation method: Dynamic or Static

# Key identifiers for Virtual Networks (used in other resources)
vnet_scope_key = "zynbit-prod-scope-vnet"  # Main app deployment VNet
vnet_hub_key   = "zynbit-prod-hub-vnet"    # Application Gateway VNet
vnet_atlas_key = "atlas-vnet"              # Peering VNet

#frontdoor
frontdoor_name                  = "STRATUS-EU-FRONTDOOR"
frontdoor_resource_group_name   = "STRATUS-EU-FRONTDOOR-RG"
backend_host                    = "stratus-eu-example.azurewebsites.net"
backend_address                 = ""

#NSG 
network_resource_group_name = "Stratus-eu-nsg-rg"



#Automation Account

selected_vm_name = "ZYNBIT-STRATUEU-AUTOMATION"  # should match one key in your var.vms

automation_account_name = "myAutomationAccount"
automation_sku_name     = "Basic"
runbook_name            = "MyRunbook"
runbook_type            = "PowerShell"
runbook_log_verbose     = true
runbook_log_progress    = true
runbook_file_path       = "./runbooks/myscript.ps1"
runbook_content_uri     = "https://raw.githubusercontent.com/myorg/scripts/main/myscript.ps1"

#AI Foundry 
ai_resource_group_name         = "ai"
ai_foundry_name             = "strateu-northeurope2"
ai_foundry_project_name     = "openai"
ai_foundry_project_description = "Demo AI Foundry project created via Terraform"


#Bing Grounding Search
bing_resource_group_name       = "rg-bing-grounding"
bing_grounding_search_name     = "bing-grounding-sample"
sku_name_bing                  = "S1"


#Log analytics Workspace
log_analytics_workspace_name = "my-log-workspace"
log_analytics_workspace_rg   = "my-monitor-rg"
resource_ids_to_monitor = [
  "/subscriptions/xxxx/resourceGroups/my-rg/providers/Microsoft.Compute/virtualMachines/vm1",
  "/subscriptions/xxxx/resourceGroups/my-rg/providers/Microsoft.Web/sites/appservice1",
  "/subscriptions/xxxx/resourceGroups/my-rg/providers/Microsoft.Storage/storageAccounts/mystorage1"
]
# Provide a resource group for Log Analytics so it is not blank
log_analytics_resource_group_name = "rg-monitoring-prod-demo-cind"

############ Managed Identities ##################
managed_identities = [
  {
    name                   = "Stratus-eu-auto-sync"
    mi_resource_group_name = "Stratus-eu-auto-sync"
    location               = "North Europe"
  },
  {
    name                   = "Stratus-eu-crm-api"
    mi_resource_group_name = "Stratus-eu-crm-api"
    location               = "North Europe"
  },
   {
    name                   = "Stratus-eu-dataretention"
    mi_resource_group_name = "Stratus-eu-data-retention"
    location               = "North Europe"

  },
  {
    name                   = "Stratus-eu-kv-secret"
    mi_resource_group_name = "Stratus-eu-keyvault2"
    location               = "North Europe"
  },
  {
    name                   = "Stratus-eu-kv"
    mi_resource_group_name = "Stratus-eu-keyvault1"
    location               = "North Europe"
  },
  {
    name                   = "stratus-eu-notifications"
    mi_resource_group_name = "Stratus-eu-notifications"
    location               = "North Europe"
  },
  {
    name                   = "stratus-eu-webhooks"
    mi_resource_group_name = "Stratus-eu-webhooks"
    location               = "North Europe"
  },
  {
    name                   = "stratus-eu-comms"
    mi_resource_group_name = "Stratus-eu-communication"
    location               = "North Europe"
  },
  {
    name                   = "stratus-eu-research-ai"
    mi_resource_group_name = "Stratus-eu-research-ai"
    location               = "North Europe"
  }
]

#######public ip for bastion and lb ##########
public_ips = {
  appgw = {
    resource_group_name = "rg-network-prod-ashoka-cind"
    public_ip_name      = "pip-prod-ashoka-cind"
    allocation_method   = "Static"
    sku_name            = "Standard"
    ip_version          = "IPv4"
    zones               = []

  }
}
######## VPN  ###########################
vpn_gateway_name    = "strateu-vpn-gateway"
resource_group_name = "rg-demo-prod"

s2s_configs = {
#  HC1 = {
#    local_gateway_name = "HC1"
#    local_gateway_ip   = "64.78.185.20"
#    address_space      = ["10.7.0.0/16", "10.15.0.0/16"]
#  }
  HC2 = {
    local_gateway_name = "HC2"
    local_gateway_ip   = "212.83.209.154"
    address_space      = ["10.8.0.0/16", "10.14.0.0/16", "10.80.0.0/16", "10.15.0.0/16","10.7.0.0/16"]
    pfs_group          = "PFS14"
  }
  VPN_US_WEST3 = {
    local_gateway_name = "VPN_US_WEST3"
    local_gateway_ip   = "20.172.18.11"
    address_space      = ["172.16.250.0/24", "172.16.251.0/24"]
    pfs_group          = "PFS24"
  }
  VPN_EU_WESTEUROPE = {
    local_gateway_name = "VPN_EU_WESTEUROPE"
    local_gateway_ip   = "172.201.208.233"
    address_space      = ["172.16.252.0/24", "172.16.253.0/24"]
    pfs_group          = "PFS24"
  }
}
storage_account_id  = ""
log_analytics_workspace_id = "113b9263-d9b8-4fee-9e05-1f2f57d365b9"
log_analytics_resource_id  = "/subscriptions/c99e507d-dd73-4894-8105-2498c63f4708/resourceGroups/westeurope-networkwatcher-logs-rg/providers/Microsoft.OperationalInsights/workspaces/WestEurope-NetworkWatcher-Logs"

        