resource "vault_pki_secret_backend_role" "pki_intermediate_subdomain_admin" {
    backend = pki_intermediate_path
    name = "${var.tld}_${var.domain}_${var.subdomain}_admin"
    allowed_domains = ["*.${var.subdomain}.${var.domain}.${var.tld}"]
    allow_glob_domains = true
    ttl = 3600
}

# create the cert for the vault
resource "vault_pki_secret_backend_cert" "vault" {
    depends_on = [vault_mount.pki_intermediate, vault_pki_secret_backend_role.pki_intermediate_subdomain_admin]
    backend = pki_intermediate_path
    name = vault_pki_secret_backend_role.pki_intermediate_subdomain_admin.name
    common_name = "vault.${var.subdomain}.${var.domain}.${var.tld}"
    ttl = 3600
}

output "vault_certificate" {
    value = vault_pki_secret_backend_cert.vault.certificate
}