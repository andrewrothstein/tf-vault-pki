terraform {
  source = "../../modules//rootca"
}

include {
  path = find_in_parent_folders()
}

dependency "policy" {
  config_path = "../policy"
  skip_outputs = true
}

locals {
  domain_vars = read_terragrunt_config(find_in_parent_folders("domain.hcl"))
}

inputs = {
  tld = local.domain_vars.locals.tld
  domain = local.domain_vars.locals.domain
}
