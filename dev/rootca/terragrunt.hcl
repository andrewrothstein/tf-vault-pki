terraform {
    source = "../../modules//rootca"
}

dependencies {
    paths = ["../policy"]
}

inputs = {
  tld = "dev"
  domain = "drewfus.org"
}