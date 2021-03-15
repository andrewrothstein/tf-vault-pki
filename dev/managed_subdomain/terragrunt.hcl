terraform {
  source = "../../modules//managed_subdomain"
}

include {
  path = find_in_parent_folders()
}

dependency "subca" {
  config_path = "../subca"
  mock_outputs = {
    pki_intermediate_path = "temporary-pki-intermediate-path"
  }
}

locals {
  domain_vars = read_terragrunt_config(find_in_parent_folders("domain.hcl"))
  subdomain = "dev"
}

inputs = {
  tld = local.domain_vars.locals.tld
  domain = local.domain_vars.locals.domain
  subdomain = local.subdomain
  pki_intermediate_path = dependency.subca.outputs.pki_intermediate_path
}
