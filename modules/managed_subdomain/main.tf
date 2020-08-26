locals {
    fq_domain = "${var.domain}.${var.tld}"
    tld_underbar = replace(var.tld,".","_")
    fq_domain_underbar = "${local.tld_underbar}_${var.domain}"
}

resource "vault_pki_secret_backend_role" "pki_intermediate_subdomain_admin" {
    backend = var.pki_intermediate_path
    name = "${local.fq_domain_underbar}_${var.subdomain}_admin"
    allowed_domains = ["*.${var.subdomain}.${local.fq_domain}"]
    allow_glob_domains = true
    ttl = 3600
}

# create the cert for the vault
resource "vault_pki_secret_backend_cert" "vault" {
    depends_on = [vault_pki_secret_backend_role.pki_intermediate_subdomain_admin]
    backend = var.pki_intermediate_path
    name = vault_pki_secret_backend_role.pki_intermediate_subdomain_admin.name
    common_name = "vault.${var.subdomain}.${local.fq_domain}"
    ttl = 3600
}

output "vault_certificate" {
    value = vault_pki_secret_backend_cert.vault.certificate
}

output "vault_keypair" {
  value = vault_pki_secret_backend_cert.vault.private_key
  sensitive = true
}
