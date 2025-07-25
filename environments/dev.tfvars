#VMS

vms = [
  {
    name             = "zynbit-strateu-bastion"
    os_type          = "Linux"
    resource_group   = "ZYNBIT-STRATEU-BASTION"
    subnet_id        = "/subscriptions/f5929557-6d14-46cb-b403-19ca764f6560/resourceGroups/test/providers/Microsoft.Network/virtualNetworks/hubvnet/subnets/default"
    size             = "Standard_B2s"
    admin_username   = "azureuser"
    admin_password   = "P@ssword123!"
    version          = "0001-com-ubuntu-server-jammy:22_04-lts"

    os_disk = {
      disk_type     = "StandardSSD_LRS"
      disk_size_gb  = 64
    }
    
  },
  {
    name             = "strateu-automation-worker"
    os_type          = "Windows"
    resource_group   = "ZYNBIT-STRATUEU-AUTOMATION"
    subnet_id        = "/subscriptions/f5929557-6d14-46cb-b403-19ca764f6560/resourceGroups/test/providers/Microsoft.Network/virtualNetworks/hubvnet/subnets/default"
    size             = "Standard_B2s_v2"
    identity_name    = "automation"
    admin_username   = "adminuser"
    admin_password   = "P@ssword123!"
    version          = "WindowsServer:2022-Datacenter"
    computer_name    = "AutomationWork"
    os_disk = {
      disk_type     = "Premium_LRS"
      disk_size_gb  = 127
    }

    data_disks = [
      {
        disk_type     = "Premium_LRS"
        disk_size_gb  = 32
      }
    ]
  }

]

# App Services and plans
app_service_plans = [
  {
    name                = "production"
    resource_group_name = "production"
    sku_tier            = "PremiumV2"
    sku_size            = "P1v2"
    sku_capacity        = 1
    kind                = "Windows"
    reserved            = false
    per_site_scaling    = false
    is_xenon            = false
  },
  {
    name                = "reply-tracking"
    resource_group_name = "replytracking"
    sku_tier            = "PremiumV3"
    sku_size            = "P1v3"
    sku_capacity        = 2
    kind                = "Windows"
    reserved            = false
    per_site_scaling    = false
    is_xenon            = false
  }
]

app_services = [

  {
    name                  = "calendarapp"
    resource_group_name   = "calendarapp"
    app_service_plan_name = "production"
    kind                  = "Windows"
    site_config = {
      windows_fx_version = "DOTNET|6.0"
    }
    app_settings = {
      SCM_DO_BUILD_DURING_DEPLOYMENT = "true"
    }
    slots = [
      {
        name         = "staging"
        app_settings = {
          "SLOT_SETTING" = "value"
        }
      },
    ]
  },
  {
    name                  = "data"
    resource_group_name   = "data"
    app_service_plan_name = "production"
    kind                  = "Windows"
    site_config = {
      windows_fx_version = "DOTNET|6.0"
    }
    app_settings = {
      SCM_DO_BUILD_DURING_DEPLOYMENT = "true"
    }
    slots = [
      {
        name         = "staging"
        app_settings = {
          "SLOT_SETTING" = "value"
        }
      },
    ]
  },
  {
    name                  = "developer"
    resource_group_name   = "developer"
    app_service_plan_name = "production"
    kind                  = "Windows"
    site_config = {
      windows_fx_version = "DOTNET|6.0"
    }
    app_settings = {
      SCM_DO_BUILD_DURING_DEPLOYMENT = "true"
    }
    slots = [
      {
        name         = "staging"
        app_settings = {
          "SLOT_SETTING" = "value"
        }
      },
    ]
  },
  {
    name                  = "signals"
    resource_group_name   = "signals"
    app_service_plan_name = "production"
    kind                  = "Windows"
    site_config = {
      windows_fx_version = "DOTNET|6.0"
    }
    app_settings = {
      SCM_DO_BUILD_DURING_DEPLOYMENT = "true"
    }
    slots = [
      {
        name         = "staging"
        app_settings = {
          "SLOT_SETTING" = "value"
        }
      },
    ]
  },
  {
    name                  = "research-ai"
    resource_group_name   = "research-ai"
    app_service_plan_name = "production"
    kind                  = "Windows"
    site_config = {
      windows_fx_version = "DOTNET|6.0"
    }
    app_settings = {
      SCM_DO_BUILD_DURING_DEPLOYMENT = "true"
    }
    slots = [
      {
        name         = "staging"
        app_settings = {
          "SLOT_SETTING" = "value"
        }
      },
    ]
  },
  {
    name                  = "webportal"
    resource_group_name   = "webportal"
    app_service_plan_name = "production"
    kind                  = "Windows"
    site_config = {
      windows_fx_version = "DOTNET|6.0"
    }
    app_settings = {
      SCM_DO_BUILD_DURING_DEPLOYMENT = "true"
    }
    slots = [
      {
        name         = "staging"
        app_settings = {
          "SLOT_SETTING" = "value"
        }
      },
    ]
  }
]

#Function app 

function_apps = [
  {
    name                  = "email-blasts"
    resource_group_name   = "emailblasts"
    os_type               = "Windows"
    runtime_stack         = "dotnet"
    app_service_plan_name = "production"
    storage_account_name  = "ifiemailblasts"   
    storage_account_type  = "Standard_LRS"
    app_settings = {
      ENV = "dev"
    }
    slot_names = ["staging"]
  },
  {
    name                  = "reply-tracking"
    resource_group_name   = "replytracking"
    os_type               = "Windows"
    runtime_stack         = "node"
    app_service_plan_name = "reply-tracking"
    storage_account_name  = "ifireplytracking"
    storage_account_type  = "Standard_LRS"
    app_settings = {
      ENV = "prod"
    }
    slot_names = ["staging"]
  }
]

#Container Apps +Environment
tags = {
  environment = "production"
}

container_app_environments = [
  {
    name                            = "external"
    resource_group_name             = "managed-env-external"
    infrastructure_subnet_id       = "/subscriptions/f5929557-6d14-46cb-b403-19ca764f6560/resourceGroups/test/providers/Microsoft.Network/virtualNetworks/hubvnet/subnets/default"
    internal_load_balancer_enabled = true
    # app_logs = {
    #   destination = "log-analytics"
    #   log_analytics = {
    #     customer_id = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
    #     shared_key  = "base64=="
    #   }
    # }
    tags = {
      environment = "dev"
      project     = "app-core"
    }
  },
]


container_apps = [
  {
    name                    = "auto-sync-calendar"
    resource_group_name     = "auto-sync-calendar"
    environment_id          = "external"
    revision_mode           = "Single"
    container_name          = "auto-sync-calendar"
    image                   = "cirruscontainerhub.azurecr.io"
    cpu                     = 0.5
    memory                  = "1.0Gi"
    min_replicas            = 1
    max_replicas            = 3
    target_port             = 80
    external_enabled        = true
    create_identity         = true
    create_storage_account  = true
    env_vars = [
      { name = "ENV", value = "prod" },
      { name = "DEBUG", value = "false" }
    ]
  }
  # {
  #   name                = "auto-sync-email"
  #   resource_group_name = "auto-sync-email"
  #   environment_id      = "ii"
  #   revision_mode       = "Single"
  #   container_name      = "user-service"
  #   image               = "cirruscontainerhub.azurecr.io"
  #   cpu                 = 1.0
  #   memory              = "2.0Gi"
  #   min_replicas        = 1
  #   max_replicas        = 5
  #   target_port         = 8080
  #   external_enabled    = false
  #   env_vars = [
  #     { name = "ENV", value = "staging" }
  #   ]
  # }
  # Add 22 more apps similarly
]

# SQL Databases and server


sql_server_name     = "ifitestcirrus"
sql_server_version  = "12.0"
sql_admin_login     = "sqladminuser"
sql_admin_password  = "P@ssword1234!"  # Use secure secrets handling in production

sql_databases = [
  {
    name        = "efuzionAEzxx4med"
    sku_name    = "S1"
    max_size_gb = 3790
  },
  # {
  #   name        = "master"
  #   sku_name    = "S1"
  #   max_size_gb = 300
  # }
]

tags = {
  environment = "dev"
  project     = "sql-terraform"
}

