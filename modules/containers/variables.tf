variable "location" {
  description = "Location for the resources"
  type        = string
  default     = ""
}
variable "name-prefix" {
  description = "Prefix for resource names"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags to apply"
  type        = map(string)
  default     = {}
}

variable "container_apps" {
  description = "List of container app configurations"
  type = list(object({
    name                      = string
    resource_group_name       = string
    environment_id            = string
    revision_mode             = string
    container_name            = string
    image                     = string
    cpu                       = number
    memory                    = string
    min_replicas              = number
    max_replicas              = number
    target_port               = number
    external_enabled          = bool
    env_vars                  = list(object({ name = string, value = string }))
    create_identity           = optional(bool)
    create_storage_account    = optional(bool)
  }))
}

variable "container_app_environments" {
  description = "List of container app environment configurations"
  type = list(object({
    name                            = string
    resource_group_name             = string
    infrastructure_subnet_id       = string
    internal_load_balancer_enabled = bool
    # app_logs = object({
    #   destination = string
    #   log_analytics = object({
    #     customer_id = string
    #     shared_key  = string
    #   })
    # })
    tags = map(string)
  }))
}
