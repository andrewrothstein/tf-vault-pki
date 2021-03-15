remote_state {
  backend = "s3"

  config = {
    access_key = "admin"
    secret_key = "password"
    encrypt = true
    endpoint = "http://127.0.0.1:9000"
    force_path_style = true
    skip_credentials_validation = true
    region = "us-east-2"
    bucket = "terragrunt-dev-bucket"
    key = "${path_relative_to_include()}/terraform.tfstate"
  }
}
