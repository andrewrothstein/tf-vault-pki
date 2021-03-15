* Run a development minio server:
```
arothste@DESKTOP-H8GHQ6M:~/git/github.com/andrewrothstein/tf-vault-pki$ make launch-dev-minio
mkdir -p $MINIO_DATA_DIR
minio server $MINIO_DATA_DIR
Endpoint: http://172.23.182.103:9000  http://127.0.0.1:9000     

Browser Access:
   http://172.23.182.103:9000  http://127.0.0.1:9000    

Object API (Amazon S3 compatible):
   Go:         https://docs.min.io/docs/golang-client-quickstart-guide
   Java:       https://docs.min.io/docs/java-client-quickstart-guide
   Python:     https://docs.min.io/docs/python-client-quickstart-guide
   JavaScript: https://docs.min.io/docs/javascript-client-quickstart-guide
   .NET:       https://docs.min.io/docs/dotnet-client-quickstart-guide
IAM initialization complete
metacacheManager was initialized in non-erasure mode, skipping save
```
* Run a development vault server:
```
arothste@DESKTOP-H8GHQ6M:~/git/github.com/andrewrothstein/tf-vault-pki$ make launch-dev-vault
vault server -dev
==> Vault server configuration:

             Api Address: http://127.0.0.1:8200
                     Cgo: disabled
         Cluster Address: https://127.0.0.1:8201
              Go Version: go1.15.7
              Listener 1: tcp (addr: "127.0.0.1:8200", cluster address: "127.0.0.1:8201", max_request_duration: "1m30s", max_request_size: "33554432", tls: "disabled")
               Log Level: info
                   Mlock: supported: true, enabled: false
           Recovery Mode: false
                 Storage: inmem
                 Version: Vault v1.6.3
             Version Sha: b540be4b7ec48d0dd7512c8d8df9399d6bf84d76

==> Vault server started! Log data will stream in below:

2021-03-14T23:20:55.671-0400 [INFO]  proxy environment: http_proxy= https_proxy= no_proxy=
2021-03-14T23:20:55.674-0400 [WARN]  no `api_addr` value specified in config or in VAULT_API_ADDR; falling back to detection if possible, but this value should be manually set
2021-03-14T23:20:55.691-0400 [INFO]  core: security barrier not initialized
2021-03-14T23:20:55.691-0400 [INFO]  core: security barrier initialized: stored=1 shares=1 threshold=1
...
```
* Ensure connectivity:
```
arothste@DESKTOP-H8GHQ6M:~/git/github.com/andrewrothstein/tf-vault-pki$ make vault-status
vault status
Key             Value
---             -----
Seal Type       shamir
Initialized     true
Sealed          false
Total Shares    1
Threshold       1
Version         1.6.3
Storage Type    inmem
Cluster Name    vault-cluster-dd7a7f5a
Cluster ID      7d443af0-2343-5fa7-587c-205977ce570d
HA Enabled      false

```
* Create Terragrunt remote state bucket in Minio
```
arothste@DESKTOP-H8GHQ6M:~/git/github.com/andrewrothstein/tf-vault-pki$ make mc-create-bucket
mc alias set local-minio $MINIO_URL $MINIO_ROOT_USER $MINIO_ROOT_PASSWORD
Added `local-minio` successfully.
mc mb local-minio/$TG_BUCKET
Bucket created successfully `local-minio/terragrunt-dev-bucket`.
```
* Terragrunt init
```
arothste@DESKTOP-H8GHQ6M:~/git/github.com/andrewrothstein/tf-vault-pki$ terraform --version
Terraform v0.14.8
arothste@DESKTOP-H8GHQ6M:~/git/github.com/andrewrothstein/tf-vault-pki$ terragrunt --version
terragrunt version v0.28.10
arothste@DESKTOP-H8GHQ6M:~/git/github.com/andrewrothstein/tf-vault-pki$ make versions tg-init
vault --version
Vault v1.6.3 (b540be4b7ec48d0dd7512c8d8df9399d6bf84d76)
terraform --version
Terraform v0.14.8
terragrunt --version
terragrunt version v0.28.10
terragrunt run-all init
INFO[0000] Stack at /home/arothste/git/github.com/andrewrothstein/tf-vault-pki:
  => Module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/managed_subdomain (excluded: false, dependencies: [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca])
  => Module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/policy (excluded: false, dependencies: [])
  => Module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca (excluded: false, dependencies: [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/policy])
  => Module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca (excluded: false, dependencies: [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca]) 

Initializing the backend...

Initializing provider plugins...
- Reusing previous version of hashicorp/vault from the dependency lock file
- Using previously-installed hashicorp/vault v2.18.0

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.

Initializing the backend...

Initializing provider plugins...
- Reusing previous version of hashicorp/vault from the dependency lock file
- Using previously-installed hashicorp/vault v2.18.0

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.

Initializing the backend...

Initializing provider plugins...
- Reusing previous version of hashicorp/vault from the dependency lock file
- Using previously-installed hashicorp/vault v2.18.0

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.

Initializing the backend...

Initializing provider plugins...
- Reusing previous version of hashicorp/vault from the dependency lock file
- Using previously-installed hashicorp/vault v2.18.0

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```
* Terragrunt validate
```
arothste@DESKTOP-H8GHQ6M:~/git/github.com/andrewrothstein/tf-vault-pki$ make tg-validate
terragrunt run-all validate
INFO[0000] Stack at /home/arothste/git/github.com/andrewrothstein/tf-vault-pki:
  => Module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/managed_subdomain (excluded: false, dependencies: [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca])
  => Module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/policy (excluded: false, dependencies: [])
  => Module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca (excluded: false, dependencies: [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/policy])
  => Module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca (excluded: false, dependencies: [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca]) 
Success! The configuration is valid.

Success! The configuration is valid.

Success! The configuration is valid.

Success! The configuration is valid.

```
* Terragrunt plan
```
arothste@DESKTOP-H8GHQ6M:~/git/github.com/andrewrothstein/tf-vault-pki$ make tg-plan
terragrunt run-all plan
INFO[0000] Stack at /home/arothste/git/github.com/andrewrothstein/tf-vault-pki:
  => Module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/managed_subdomain (excluded: false, dependencies: [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca])
  => Module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/policy (excluded: false, dependencies: [])
  => Module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca (excluded: false, dependencies: [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/policy])
  => Module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca (excluded: false, dependencies: [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca]) 

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # vault_policy.policies["pki-admin"] will be created
  + resource "vault_policy" "policies" {
      + id     = (known after apply)
      + name   = "pki-admin"
      + policy = <<-EOT
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

Plan: 1 to add, 0 to change, 0 to destroy.

------------------------------------------------------------------------

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.


An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # vault_mount.pki_root will be created
  + resource "vault_mount" "pki_root" {
      + accessor                  = (known after apply)
      + default_lease_ttl_seconds = 3600
      + external_entropy_access   = false
      + id                        = (known after apply)
      + max_lease_ttl_seconds     = 86400
      + path                      = "pki/drewfus_org_nj_root"
      + seal_wrap                 = (known after apply)
      + type                      = "pki"
    }

  # vault_pki_secret_backend_root_cert.pki_root will be created
  + resource "vault_pki_secret_backend_root_cert" "pki_root" {
      + backend              = "pki/drewfus_org_nj_root"
      + certificate          = (known after apply)
      + common_name          = "root-ca.nj.drewfus.org"
      + exclude_cn_from_sans = true
      + format               = "pem"
      + id                   = (known after apply)
      + issuing_ca           = (known after apply)
      + key_bits             = 4096
      + key_type             = "rsa"
      + max_path_length      = -1
      + organization         = "nj.drewfus.org"
      + private_key_format   = "der"
      + serial               = (known after apply)
      + ttl                  = "87600h"
      + type                 = "internal"
    }

Plan: 2 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + pki_root_path = "pki/drewfus_org_nj_root"

------------------------------------------------------------------------

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.


An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # vault_mount.pki_intermediate will be created
  + resource "vault_mount" "pki_intermediate" {
      + accessor                  = (known after apply)
      + default_lease_ttl_seconds = 3600
      + external_entropy_access   = false
      + id                        = (known after apply)
      + max_lease_ttl_seconds     = 86400
      + path                      = "pki/drewfus_org_nj_intermediate"
      + seal_wrap                 = (known after apply)
      + type                      = "pki"
    }

  # vault_pki_secret_backend_intermediate_cert_request.pki_intermediate will be created
  + resource "vault_pki_secret_backend_intermediate_cert_request" "pki_intermediate" {
      + backend              = "pki/drewfus_org_nj_intermediate"
      + common_name          = "intermediate-ca.nj.drewfus.org"
      + csr                  = (known after apply)
      + exclude_cn_from_sans = true
      + format               = "pem"
      + id                   = (known after apply)
      + key_bits             = 4096
      + key_type             = "rsa"
      + organization         = "nj.drewfus.org"
      + private_key          = (sensitive value)
      + private_key_format   = "der"
      + private_key_type     = (known after apply)
      + type                 = "internal"
    }

  # vault_pki_secret_backend_intermediate_set_signed.pki_root_sign_intermediate will be created
  + resource "vault_pki_secret_backend_intermediate_set_signed" "pki_root_sign_intermediate" {
      + backend     = "pki/drewfus_org_nj_intermediate"
      + certificate = (known after apply)
      + id          = (known after apply)
    }

  # vault_pki_secret_backend_root_sign_intermediate.pki_root_sign_intermediate will be created
  + resource "vault_pki_secret_backend_root_sign_intermediate" "pki_root_sign_intermediate" {
      + backend         = "/root/pki"
      + ca_chain        = (known after apply)
      + certificate     = (known after apply)
      + common_name     = "intermediate-ca.nj.drewfus.org"
      + csr             = (known after apply)
      + format          = "pem"
      + id              = (known after apply)
      + issuing_ca      = (known after apply)
      + max_path_length = -1
      + serial          = (known after apply)
      + ttl             = "157680000"
      + use_csr_values  = true
    }

Plan: 4 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + pki_intermediate_path = "pki/drewfus_org_nj_intermediate"

------------------------------------------------------------------------

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.


An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # vault_pki_secret_backend_cert.vault will be created
  + resource "vault_pki_secret_backend_cert" "vault" {
      + auto_renew            = false
      + backend               = "temporary-pki-intermediate-path"
      + ca_chain              = (known after apply)
      + certificate           = (known after apply)
      + common_name           = "vault.dev.nj.drewfus.org"
      + expiration            = (known after apply)
      + format                = "pem"
      + id                    = (known after apply)
      + issuing_ca            = (known after apply)
      + min_seconds_remaining = 604800
      + name                  = "drewfus_org_nj_dev_admin"
      + private_key           = (sensitive value)
      + private_key_format    = "der"
      + private_key_type      = (known after apply)
      + serial_number         = (known after apply)
      + ttl                   = "3600"
    }

  # vault_pki_secret_backend_role.pki_intermediate_subdomain_admin will be created
  + resource "vault_pki_secret_backend_role" "pki_intermediate_subdomain_admin" {
      + allow_any_name                     = false
      + allow_bare_domains                 = false
      + allow_glob_domains                 = true
      + allow_ip_sans                      = true
      + allow_localhost                    = true
      + allow_subdomains                   = false
      + allowed_domains                    = [
          + "*.dev.nj.drewfus.org",
        ]
      + backend                            = "temporary-pki-intermediate-path"
      + basic_constraints_valid_for_non_ca = false
      + client_flag                        = true
      + code_signing_flag                  = false
      + email_protection_flag              = false
      + enforce_hostnames                  = true
      + generate_lease                     = false
      + id                                 = (known after apply)
      + key_bits                           = 2048
      + key_type                           = "rsa"
      + name                               = "drewfus_org_nj_dev_admin"
      + no_store                           = false
      + not_before_duration                = (known after apply)
      + require_cn                         = true
      + server_flag                        = true
      + ttl                                = "3600"
      + use_csr_common_name                = true
      + use_csr_sans                       = true
    }

Plan: 2 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + vault_certificate = (known after apply)
  + vault_keypair     = (sensitive value)

------------------------------------------------------------------------

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.

```
* Terragrunt apply
```
arothste@DESKTOP-H8GHQ6M:~/git/github.com/andrewrothstein/tf-vault-pki$ make tg-apply
terragrunt run-all apply
INFO[0000] Stack at /home/arothste/git/github.com/andrewrothstein/tf-vault-pki:
  => Module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/managed_subdomain (excluded: false, dependencies: [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca])
  => Module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/policy (excluded: false, dependencies: [])
  => Module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca (excluded: false, dependencies: [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/policy])
  => Module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca (excluded: false, dependencies: [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca]) 
WARN[0000] Encryption is not enabled on the S3 remote state bucket terragrunt-dev-bucket. Terraform state files may contain secrets, so we STRONGLY recommend enabling encryption!  prefix=[/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/policy] 
WARN[0000] Versioning is not enabled for the remote state S3 bucket terragrunt-dev-bucket. We recommend enabling versioning so that you can roll back to previous versions of your Terraform state in case of error.  prefix=[/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/policy] 

Initializing the backend...
Backend configuration changed!

Terraform has detected that the configuration specified for the backend
has changed. Terraform will now check for existing state in the backends.



Successfully configured the backend "s3"! Terraform will automatically
use this backend unless the backend configuration changes.

Initializing provider plugins...
- Reusing previous version of hashicorp/vault from the dependency lock file
- Using previously-installed hashicorp/vault v2.18.0

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
vault_policy.policies["pki-admin"]: Creating...
vault_policy.policies["pki-admin"]: Creation complete after 0s [id=pki-admin]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
WARN[0001] Encryption is not enabled on the S3 remote state bucket terragrunt-dev-bucket. Terraform state files may contain secrets, so we STRONGLY recommend enabling encryption!  prefix=[/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca] 
WARN[0001] Versioning is not enabled for the remote state S3 bucket terragrunt-dev-bucket. We recommend enabling versioning so that you can roll back to previous versions of your Terraform state in case of error.  prefix=[/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca] 

Initializing the backend...
Backend configuration changed!

Terraform has detected that the configuration specified for the backend
has changed. Terraform will now check for existing state in the backends.



Successfully configured the backend "s3"! Terraform will automatically
use this backend unless the backend configuration changes.

Initializing provider plugins...
- Reusing previous version of hashicorp/vault from the dependency lock file
- Using previously-installed hashicorp/vault v2.18.0

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
vault_mount.pki_root: Creating...
vault_mount.pki_root: Creation complete after 0s [id=pki/drewfus_org_nj_root]
vault_pki_secret_backend_root_cert.pki_root: Creating...
vault_pki_secret_backend_root_cert.pki_root: Creation complete after 1s [id=pki/drewfus_org_nj_root/root/generate/internal]

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

Outputs:

pki_root_path = "pki/drewfus_org_nj_root"
WARN[0004] Encryption is not enabled on the S3 remote state bucket terragrunt-dev-bucket. Terraform state files may contain secrets, so we STRONGLY recommend enabling encryption!  prefix=[/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca] 
WARN[0004] Versioning is not enabled for the remote state S3 bucket terragrunt-dev-bucket. We recommend enabling versioning so that you can roll back to previous versions of your Terraform state in case of error.  prefix=[/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca] 

Initializing the backend...
Backend configuration changed!

Terraform has detected that the configuration specified for the backend
has changed. Terraform will now check for existing state in the backends.



Successfully configured the backend "s3"! Terraform will automatically
use this backend unless the backend configuration changes.

Initializing provider plugins...
- Reusing previous version of hashicorp/vault from the dependency lock file
- Using previously-installed hashicorp/vault v2.18.0

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
vault_mount.pki_intermediate: Creating...
vault_mount.pki_intermediate: Creation complete after 0s [id=pki/drewfus_org_nj_intermediate]
vault_pki_secret_backend_intermediate_cert_request.pki_intermediate: Creating...
vault_pki_secret_backend_intermediate_cert_request.pki_intermediate: Creation complete after 1s [id=pki/drewfus_org_nj_intermediate/intermediate/generate/internal]
vault_pki_secret_backend_root_sign_intermediate.pki_root_sign_intermediate: Creating...
vault_pki_secret_backend_root_sign_intermediate.pki_root_sign_intermediate: Creation complete after 0s [id=pki/drewfus_org_nj_root/intermediate-ca.nj.drewfus.org]
vault_pki_secret_backend_intermediate_set_signed.pki_root_sign_intermediate: Creating...
vault_pki_secret_backend_intermediate_set_signed.pki_root_sign_intermediate: Creation complete after 0s [id=pki/drewfus_org_nj_intermediate/intermediate/set-signed]

Apply complete! Resources: 4 added, 0 changed, 0 destroyed.

Outputs:

pki_intermediate_path = "pki/drewfus_org_nj_intermediate"
WARN[0006] Encryption is not enabled on the S3 remote state bucket terragrunt-dev-bucket. Terraform state files may contain secrets, so we STRONGLY recommend enabling encryption!  prefix=[/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/managed_subdomain] 
WARN[0006] Versioning is not enabled for the remote state S3 bucket terragrunt-dev-bucket. We recommend enabling versioning so that you can roll back to previous versions of your Terraform state in case of error.  prefix=[/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/managed_subdomain] 

Initializing the backend...
Backend configuration changed!

Terraform has detected that the configuration specified for the backend
has changed. Terraform will now check for existing state in the backends.



Successfully configured the backend "s3"! Terraform will automatically
use this backend unless the backend configuration changes.

Initializing provider plugins...
- Reusing previous version of hashicorp/vault from the dependency lock file
- Using previously-installed hashicorp/vault v2.18.0

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
vault_pki_secret_backend_role.pki_intermediate_subdomain_admin: Creating...
vault_pki_secret_backend_role.pki_intermediate_subdomain_admin: Creation complete after 0s [id=pki/drewfus_org_nj_intermediate/roles/drewfus_org_nj_dev_admin]
vault_pki_secret_backend_cert.vault: Creating...
vault_pki_secret_backend_cert.vault: Creation complete after 0s [id=pki/drewfus_org_nj_intermediate/drewfus_org_nj_dev_admin/vault.dev.nj.drewfus.org]

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

Outputs:

vault_certificate = <<EOT
-----BEGIN CERTIFICATE-----
MIIEizCCAnOgAwIBAgIUbh0R8cQywAOVJa3V+5fG0Wch1IIwDQYJKoZIhvcNAQEL
BQAwQjEXMBUGA1UEChMObmouZHJld2Z1cy5vcmcxJzAlBgNVBAMTHmludGVybWVk
aWF0ZS1jYS5uai5kcmV3ZnVzLm9yZzAeFw0yMTAzMTUwNDM2MjRaFw0yMTAzMTUw
NTM2NTNaMCMxITAfBgNVBAMTGHZhdWx0LmRldi5uai5kcmV3ZnVzLm9yZzCCASIw
DQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMCpHJyuPJaFQ2Bwf2HRWmVeaWjY
oFKGhijSNMMG7qLFlwWi99Z5uyVcQoxT3hM/ropL4OP6cy+G4WxAxILv9IglJ2IU
NXQp9FDLGk+crBG0BYmTq2Z22emyrxN/k4pKgjDJj9tN8VnfJg7BJXokcwWwORah
snxkDQW8ekOXxVR1V34E+B9wgILFZKnIUw4IW6mEaPMr+JNxF0QpUxzvKPJxHkg3
FX2ma8lj0GvYJk4b6XxofZJu3SR2J7elzOqbzRKh+qybs8+6Tc7FvPjP+LXYqhX9
ZjsGsmBboCNqBwrGT/tuXPX2GdgXUcXynIb9o1Grvj4J7+0xYqmq9UCtMpkCAwEA
AaOBlzCBlDAOBgNVHQ8BAf8EBAMCA6gwHQYDVR0lBBYwFAYIKwYBBQUHAwEGCCsG
AQUFBwMCMB0GA1UdDgQWBBTo/759XtZYB2Z6tGVhG8uBJV6RjzAfBgNVHSMEGDAW
gBTBPYxmK9hB7JMxNzVaZ8ZwwgzrDjAjBgNVHREEHDAaghh2YXVsdC5kZXYubmou
ZHJld2Z1cy5vcmcwDQYJKoZIhvcNAQELBQADggIBALflWh/z96nMTUdQXD9TUom2
nX5OK6Qp9XKYrWp9y4IFNLNQ2qn4kVYQ5CZex8UB3f5WzL6M7oALZ6+p0I7KOMyA
de6NuB3R0h42PlJQGdJnqZEq6ibVlMpOm/5zzYAGVUci5OR968IDIzQm/t0RiI1J
KgV3uwZIiumK1N1nnAwHkgUxk+cbbU2umtKq64AsJRCJQMzmtcm/K1D1gWIYqeHO
MsFLpJ9p0IMJp1TMjuLralgbCLnWI31DqKzJ6CHb7Vkcz9ayTkOu8ZgEd5yG90Nb
xntXqPE+PMiK4Dtq+MhPpBt9OsFg63dfvE8mrmkelgzzmaR8beHXmFUBg5GvLBqs
xoAsy4UNlcK9kCZ31hSxGjgVmLa4wvEnLpQ+O1GhrQrenb8F6rzNeJeUilMKeB4Y
DsRrmyChK4cfY1rkeCPwwdtqlKwM3DX3sFsA3+hXw2GsbDWgFzyQ7WprdCdUF0Zl
UtqYQqbre3Oq1ZQFJChLcelVqHW/b2LQO/NhBC/QXobB2HwL2j55ps4rdZeMkn6i
zm0D2KKHtW4GOF4sC3WQUGx+n2KxEkBqi5ya4qzoyMd8uTqbm4nde5NlGh+wLa9y
03FLY+xlZKGbZ0trTfV6N+1XB8+Gopmu6ZeKWOp4/7vmo6DBb36aua2iI8YfS5Cm
V+LtnDtupL+LDkTOroPe
-----END CERTIFICATE-----
EOT
vault_keypair = <sensitive>
```
