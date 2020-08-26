terraform {
    source = "../../modules//subca"
}

dependency "rootca" {
    config_path = "../rootca"
}

locals {
  domain_vars = read_terragrunt_config(find_in_parent_folders("domain.hcl"))
}

inputs = {
  tld = local.domain_vars.locals.tld
  domain = local.domain_vars.locals.domain
  pki_root_path = dependency.rootca.outputs.pki_root_path
}
