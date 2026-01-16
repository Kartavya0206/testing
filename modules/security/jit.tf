terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.0.0"
    }
    azapi = {
      source  = "azure/azapi"
      version = ">= 2.0.0"
    }
  }
}

data "azurerm_client_config" "current" {}
locals {
  sub_id = data.azurerm_client_config.current.subscription_id
}

# var.jit_policies expected shape (for reference):
# [
#   {
#     name         = "Stratus-eu-jit"
#     asc_location = "westeurope"
#     vms = [
#       {
#         vm_id = "/subscriptions/.../resourceGroups/.../providers/Microsoft.Compute/virtualMachines/vm1"
#         ports = [
#           {
#             number                      = 22
#             protocol                    = "TCP"
#             allowed_source_address_prefix= "Internet"
#             max_request_access_duration  = "PT3H"
#           }
#         ]
#       }
#     ]
#   }
# ]

resource "azapi_resource" "jit_policy" {
  for_each = {
    for p in var.jit_policies : p.name => p
    if length(try(p.vms, [])) > 0
  }

  type      = "Microsoft.Security/locations/jitNetworkAccessPolicies@2020-01-01"
  name      = each.value.name
  parent_id = "/subscriptions/${local.sub_id}/providers/Microsoft.Security/locations/${each.value.asc_location}"

  # HCL object (NOT json string)
  body = {
    properties = {
      virtualMachines = [
        for v in each.value.vms : {
          id    = v.vm_id
          ports = [
            for pr in v.ports : {
              number                     = pr.number
              protocol                   = pr.protocol
              allowedSourceAddressPrefix = pr.allowed_source_address_prefix
              maxRequestAccessDuration   = pr.max_request_access_duration
            }
          ]
        }
      ]
    }
  }

  lifecycle {
    ignore_changes  = [body]   # Defender may reformat payload
    prevent_destroy = true
  }
}
