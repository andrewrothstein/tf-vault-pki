provider "vault" {
}

resource "vault_policy" "pki-admin" {
  name = "pki-admin"
  policy = <<EOT
# from https://learn.hashicorp.com/vault/secrets-management/sm-pki-engine
# Enable secrets engine
path "sys/mounts/*" {
  capabilities = [ "create", "read", "update", "delete", "list" ]
}

# List enabled secrets engine
path "sys/mounts" {
  capabilities = [ "read", "list" ]
}

# Work with pki secrets engine
path "pki*" {
  capabilities = [ "create", "read", "update", "delete", "list", "sudo" ]
}
EOT
}

locals {
    tld = "org"
    domain = "drewfus"
}

resource "vault_mount" "pki_root" {
    path = "pki/${local.tld}_${local.domain}_root"
    type = "pki"
    default_lease_ttl_seconds = 60 * 60 # 1h
    max_lease_ttl_seconds = 60 * 60 * 24 # 1d
}

# self signed root CA
resource "vault_pki_secret_backend_root_cert" "pki_root" {
  depends_on = [ vault_mount.pki_root ]
  backend = vault_mount.pki_root.path
  type = "internal"
  common_name = "root-ca.${local.domain}.${local.tld}"
  ttl = "87600h"
  format = "pem"
  private_key_format = "der"
  key_type = "rsa"
  key_bits = 4096
  exclude_cn_from_sans = true
  organization = "${local.domain}.${local.tld}"
}

resource "vault_mount" "pki_intermediate" {
    path = "pki/${local.tld}_${local.domain}_intermediate"
    type = "pki"
    default_lease_ttl_seconds = 3600
    max_lease_ttl_seconds = 86400
}

resource "vault_pki_secret_backend_intermediate_cert_request" "pki_intermediate" {
  depends_on = [ vault_mount.pki_intermediate ]
  backend = vault_mount.pki_intermediate.path
  type = "internal"
  common_name = "intermediate-ca.${local.domain}.${local.tld}"
  format = "pem"
  private_key_format = "der"
  key_type = "rsa"
  key_bits = 4096
  exclude_cn_from_sans = true
  organization = "${local.domain}.${local.tld}"
}

resource "vault_pki_secret_backend_root_sign_intermediate" "pki_root_sign_intermediate" {
  depends_on = [ vault_pki_secret_backend_intermediate_cert_request.pki_intermediate, vault_mount.pki_root ]
  backend = vault_mount.pki_root.path
  common_name = vault_pki_secret_backend_intermediate_cert_request.pki_intermediate.common_name
  csr = vault_pki_secret_backend_intermediate_cert_request.pki_intermediate.csr
  use_csr_values = true
  ttl = 157680000   
}

resource "vault_pki_secret_backend_intermediate_set_signed" "pki_root_sign_intermediate" { 
  backend = vault_mount.pki_intermediate.path
  certificate = vault_pki_secret_backend_root_sign_intermediate.pki_root_sign_intermediate.certificate
}

locals {
    subdomain = "nj"
}

resource "vault_pki_secret_backend_role" "pki_intermediate_subdomain_admin" {
    depends_on = [ vault_mount.pki_intermediate ]
    backend = vault_mount.pki_intermediate.path
    name = "${local.tld}_${local.domain}_${local.subdomain}_admin"
    allowed_domains = ["*.${local.subdomain}.${local.domain}.${local.tld}"]
    allow_glob_domains = true
    ttl = 3600
}

# create the cert for the vault
resource "vault_pki_secret_backend_cert" "vault" {
    depends_on = [vault_mount.pki_intermediate, vault_pki_secret_backend_role.pki_intermediate_subdomain_admin]
    backend = vault_mount.pki_intermediate.path
    name = vault_pki_secret_backend_role.pki_intermediate_subdomain_admin.name
    common_name = "vault.${local.subdomain}.${local.domain}.${local.tld}"
    ttl = 3600
}

output "vault_certificate" {
    value = vault_pki_secret_backend_cert.vault.certificate
}