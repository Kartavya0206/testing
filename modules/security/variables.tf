variable "jit_policies" {
  type = list(object({
    name                = string
    resource_group_name = string
    asc_location        = string
    vms = list(object({
      vm_id = string
      ports = list(object({
        number                        = number
        protocol                      = string
        allowed_source_address_prefix = string
        max_request_access_duration   = string
      }))
    }))
  }))
}