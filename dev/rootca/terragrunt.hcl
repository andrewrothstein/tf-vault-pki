terraform {
    source = "../../modules//rootca"
}

dependency "policy" {
  config_path = "../policy"
  skip_outputs = true
}

inputs = {
  tld = "dev"
  domain = "drewfus.org"
}
