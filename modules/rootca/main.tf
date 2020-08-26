locals {
    fq_domain = "${var.domain}.${var.tld}"
    tld_underbar = replace(var.tld,".","_")
    fq_domain_underbar = "${local.tld_underbar}_${var.domain}"
}

resource "vault_mount" "pki_root" {
    path = "pki/${local.fq_domain_underbar}_root"
    type = "pki"
    default_lease_ttl_seconds = 60 * 60 # 1h
    max_lease_ttl_seconds = 60 * 60 * 24 # 1d
}

# self signed root CA
resource "vault_pki_secret_backend_root_cert" "pki_root" {
  depends_on = [ vault_mount.pki_root ]
  backend = vault_mount.pki_root.path
  type = "internal"
  common_name = "root-ca.${local.fq_domain}"
  ttl = "87600h"
  format = "pem"
  private_key_format = "der"
  key_type = "rsa"
  key_bits = 4096
  exclude_cn_from_sans = true
  organization = local.fq_domain
}