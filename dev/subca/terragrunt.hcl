terraform {
    source = "../../modules//subca"
}

dependency "rootca" {
    config_path = "../rootca"
}

inputs = {
  tld = "dev"
  domain = "drewfus.org"
  pki_root_path = dependency.rootca.outputs.pki_root_path
}
