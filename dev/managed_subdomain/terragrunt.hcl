terraform {
    source = "../../modules//managed_subdomain"
}

dependency "subca" {
    config_path = "../subca"
}

locals {
  domain_vars = read_terragrunt_config(find_in_parent_folders("domain.hcl"))
  subdomain = "nj"
}

inputs = {
  tld = local.domain_vars.locals.tld
  domain = local.domain_vars.locals.domain
  subdomain = local.subdomain
  pki_intermediate_path = dependency.subca.outputs.pki_intermediate_path
}
