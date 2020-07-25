terraform {
    source = "../../modules//managed_domain"
}

dependency "subca" {
    config_path = "../subca"
}

inputs = {
  tld = "dev"
  domain = "drewfus.org"
  subdomain = "nj"
  pki_intermedite_path = dependency.subca.outputs.pki_intermediate_path
}
