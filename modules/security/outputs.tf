output "jit_policy_names" {
  value = [for p in var.jit_policies : p.name]
}
