terraform {
    source = "../../modules//rootca"
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
