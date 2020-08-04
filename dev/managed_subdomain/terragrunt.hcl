terraform {
    source = "../../modules//managed_subdomain"
}

dependency "subca" {
    config_path = "../subca"
}

inputs = {
  tld = "dev"
  domain = "drewfus.org"
  subdomain = "nj"
  pki_intermediate_path = dependency.subca.outputs.pki_intermediate_path
}
