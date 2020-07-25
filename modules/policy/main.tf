locals {
    policies = fileset(path.module, "policies/*.hcl")
    roles = {for p in local.policies : regex("^policies/([^.]+).hcl", p)[0] => p }
}

resource "vault_policy" "policies" {
    for_each = local.roles
    name = each.key
    policy = file(each.value)
}

