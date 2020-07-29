# Terraform Vault PKI

## Summary

Terraform Module that leverages Vault's PKI secrets engine to create a Certificate Authority (CA) and dynamically generate X.509 certificates on demand. 

## Code Examples

```hcl
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

```

## Getting Started

1. Install terragrunt 

```bash
# Windows: You can install Terragrunt on Windows using Chocolatey
choco install terragrunt
```

```bash
# macOS: You can install Terragrunt on macOS using Homebrew
brew install terragrunt
```

```bash
# Linux: Most Linux users can use Homebrew
brew install terragrunt
```

> Arch Linux users can either use the pre-built binaries from `aur/terragrunt-bin` or build Terragrunt from source from `aur/terragrunt`.

2. Run terragrunt

3. Bootstrap from localhost to incept a PKI in powershell

```bash
$env:VAULT_ADDR = "http://localhost:8200"
vault status

```
