terraform {
  source = "../../modules//policy"
}

include {
  path = find_in_parent_folders()
}
