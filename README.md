* Run a development vault server:
```
arothste@DESKTOP-H8GHQ6M:~/git/github.com/andrewrothstein/tf-vault-pki$ vault server -dev
==> Vault server configuration:

             Api Address: http://127.0.0.1:8200
                     Cgo: disabled
         Cluster Address: https://127.0.0.1:8201
              Go Version: go1.14.4
              Listener 1: tcp (addr: "127.0.0.1:8200", cluster address: "127.0.0.1:8201", max_request_duration: "1m30s", max_request_size: "33554432", tls: "disabled")
               Log Level: info
                   Mlock: supported: true, enabled: false
           Recovery Mode: false
                 Storage: inmem
                 Version: Vault v1.5.0
...
2020-08-25T17:33:59.980-0400 [INFO]  rollback: starting rollback manager
2020-08-25T17:33:59.980-0400 [INFO]  identity: entities restored
2020-08-25T17:33:59.980-0400 [INFO]  identity: groups restored
2020-08-25T17:33:59.980-0400 [INFO]  expiration: lease restore complete
2020-08-25T17:33:59.980-0400 [INFO]  core: post-unseal setup complete
2020-08-25T17:33:59.980-0400 [INFO]  core: vault is unsealed
2020-08-25T17:33:59.983-0400 [INFO]  core: successful mount: namespace= path=secret/ type=kv
2020-08-25T17:33:59.993-0400 [INFO]  secrets.kv.kv_e70728dc: collecting keys to upgrade
2020-08-25T17:33:59.993-0400 [INFO]  secrets.kv.kv_e70728dc: done collecting keys: num_keys=1
2020-08-25T17:33:59.993-0400 [INFO]  secrets.kv.kv_e70728dc: upgrading keys finished
...
```
* Ensure connectivity:
```
arothste@DESKTOP-H8GHQ6M:~/git/github.com/andrewrothstein/tf-vault-pki$ ./dev-vault-env.sh
Key             Value
---             -----
Seal Type       shamir
Initialized     true
Sealed          false
Total Shares    1
Threshold       1
Version         1.5.0
Cluster Name    vault-cluster-8d3f1b29
Cluster ID      7f5daa1c-cece-78e4-d16d-0961c5125d3c
HA Enabled      false
```
* Terragrunt away...
```
arothste@DESKTOP-H8GHQ6M:~/git/github.com/andrewrothstein/tf-vault-pki$ terraform --version
Terraform v0.13.0
arothste@DESKTOP-H8GHQ6M:~/git/github.com/andrewrothstein/tf-vault-pki$ terragrunt --version
terragrunt version v0.23.35
arothste@DESKTOP-H8GHQ6M:~/git/github.com/andrewrothstein/tf-vault-pki$ terragrunt apply-all
[terragrunt] 2020/08/26 00:08:42 Setting download directory for module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/managed_subdomain to /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/managed_subdomain/.terragrunt-cache
[terragrunt] 2020/08/26 00:08:42 Setting download directory for module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/policy to /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/policy/.terragrunt-cache
[terragrunt] 2020/08/26 00:08:42 Setting download directory for module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca to /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca/.terragrunt-cache
[terragrunt] 2020/08/26 00:08:42 Setting download directory for module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca to /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca/.terragrunt-cache
[terragrunt] 2020/08/26 00:08:42 Stack at /home/arothste/git/github.com/andrewrothstein/tf-vault-pki:
  => Module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/managed_subdomain (excluded: false, dependencies: [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca])
  => Module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/policy (excluded: false, dependencies: [])
  => Module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca (excluded: false, dependencies: [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/policy])
  => Module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca (excluded: false, dependencies: [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca])
[terragrunt] 2020/08/26 00:08:42 [terragrunt]  Are you sure you want to run 'terragrunt apply' in each folder of the stack described above? (y/n) 
y
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca] 2020/08/26 00:08:45 Module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca must wait for 1 dependencies to finish
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/policy] 2020/08/26 00:08:45 Module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/policy must wait for 0 dependencies to finish
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca] 2020/08/26 00:08:45 Module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca must wait for 1 dependencies to finish
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/policy] 2020/08/26 00:08:45 Running module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/policy now
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/managed_subdomain] 2020/08/26 00:08:45 Module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/managed_subdomain must wait for 1 dependencies to finish
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/policy] 2020/08/26 00:08:45 Running command: terraform --version
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/policy] 2020/08/26 00:08:45 Terraform version: 0.13.0
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/policy] 2020/08/26 00:08:45 Reading Terragrunt config file at /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/policy/terragrunt.hcl
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/policy] 2020/08/26 00:08:45 Downloading Terraform configurations from file:///home/arothste/git/github.com/andrewrothstein/tf-vault-pki/modules into /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/policy/.terragrunt-cache/Q8T4hjcnD1H8_9sSV2m3pQn6EhY/VsJusX_F7BukPQNGNPkFXIUIWmY
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/policy] 2020/08/26 00:08:45 Copying files from /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/policy into /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/policy/.terragrunt-cache/Q8T4hjcnD1H8_9sSV2m3pQn6EhY/VsJusX_F7BukPQNGNPkFXIUIWmY/policy
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/policy] 2020/08/26 00:08:45 Setting working directory to /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/policy/.terragrunt-cache/Q8T4hjcnD1H8_9sSV2m3pQn6EhY/VsJusX_F7BukPQNGNPkFXIUIWmY/policy
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/policy] 2020/08/26 00:08:45 Running command: terraform init

Initializing the backend...

Initializing provider plugins...
- Finding hashicorp/vault versions matching "~> 2.12.2"...
- Installing hashicorp/vault v2.12.2...
- Installed hashicorp/vault v2.12.2 (signed by HashiCorp)

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/policy] 2020/08/26 00:08:47 Running command: terraform apply -input=false -auto-approve
vault_policy.policies["pki-admin"]: Creating...
vault_policy.policies["pki-admin"]: Creation complete after 0s [id=pki-admin]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/policy] 2020/08/26 00:08:47 Module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/policy has finished successfully!
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca] 2020/08/26 00:08:47 Dependency /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/policy of module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca just finished successfully. Module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca must wait on 0 more dependencies.
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca] 2020/08/26 00:08:47 Running module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca now
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca] 2020/08/26 00:08:47 Running command: terraform --version
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca] 2020/08/26 00:08:47 Terraform version: 0.13.0
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca] 2020/08/26 00:08:47 Reading Terragrunt config file at /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca/terragrunt.hcl
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca] 2020/08/26 00:08:47 Downloading Terraform configurations from file:///home/arothste/git/github.com/andrewrothstein/tf-vault-pki/modules into /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca/.terragrunt-cache/Wbfugx_ebUVIqq3UPU-u_cFLRSw/VsJusX_F7BukPQNGNPkFXIUIWmY
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca] 2020/08/26 00:08:47 Copying files from /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca into /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca/.terragrunt-cache/Wbfugx_ebUVIqq3UPU-u_cFLRSw/VsJusX_F7BukPQNGNPkFXIUIWmY/rootca
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca] 2020/08/26 00:08:47 Setting working directory to /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca/.terragrunt-cache/Wbfugx_ebUVIqq3UPU-u_cFLRSw/VsJusX_F7BukPQNGNPkFXIUIWmY/rootca
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca] 2020/08/26 00:08:47 Running command: terraform init

Initializing the backend...

Initializing provider plugins...
- Finding hashicorp/vault versions matching "~> 2.12.2"...
- Installing hashicorp/vault v2.12.2...
- Installed hashicorp/vault v2.12.2 (signed by HashiCorp)

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca] 2020/08/26 00:08:49 Running command: terraform apply -input=false -auto-approve
vault_mount.pki_root: Creating...
vault_mount.pki_root: Creation complete after 0s [id=pki/dev_drewfus.org_root]
vault_pki_secret_backend_root_cert.pki_root: Creating...
vault_pki_secret_backend_root_cert.pki_root: Creation complete after 3s [id=pki/dev_drewfus.org_root/root/generate/internal]

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

Outputs:

pki_root_path = pki/dev_drewfus.org_root
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca] 2020/08/26 00:08:52 Module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca has finished successfully!
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca] 2020/08/26 00:08:52 Dependency /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca of module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca just finished successfully. Module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca must wait on 0 more dependencies.
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca] 2020/08/26 00:08:52 Running module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca now
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca] 2020/08/26 00:08:52 Running command: terraform --version
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca] 2020/08/26 00:08:52 Terraform version: 0.13.0
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca] 2020/08/26 00:08:52 Reading Terragrunt config file at /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca/terragrunt.hcl
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca] 2020/08/26 00:08:52 WARNING: Could not parse remote_state block from target config /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca/terragrunt.hcl
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca] 2020/08/26 00:08:52 WARNING: Falling back to terragrunt output.
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca] 2020/08/26 00:08:52 Running command: terraform --version
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca] 2020/08/26 00:08:52 Terraform version: 0.13.0
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca] 2020/08/26 00:08:52 Reading Terragrunt config file at /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca/terragrunt.hcl
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca] 2020/08/26 00:08:52 Downloading Terraform configurations from file:///home/arothste/git/github.com/andrewrothstein/tf-vault-pki/modules into /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca/.terragrunt-cache/Wbfugx_ebUVIqq3UPU-u_cFLRSw/VsJusX_F7BukPQNGNPkFXIUIWmY
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca] 2020/08/26 00:08:52 Copying files from /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca into /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca/.terragrunt-cache/Wbfugx_ebUVIqq3UPU-u_cFLRSw/VsJusX_F7BukPQNGNPkFXIUIWmY/rootca
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca] 2020/08/26 00:08:52 Setting working directory to /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca/.terragrunt-cache/Wbfugx_ebUVIqq3UPU-u_cFLRSw/VsJusX_F7BukPQNGNPkFXIUIWmY/rootca
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca] 2020/08/26 00:08:52 Running command: terraform output -json
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca] 2020/08/26 00:08:52 Downloading Terraform configurations from file:///home/arothste/git/github.com/andrewrothstein/tf-vault-pki/modules into /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca/.terragrunt-cache/9qGBpCSRY899Tj5PuLtT2MlGfzo/VsJusX_F7BukPQNGNPkFXIUIWmY
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca] 2020/08/26 00:08:52 Copying files from /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca into /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca/.terragrunt-cache/9qGBpCSRY899Tj5PuLtT2MlGfzo/VsJusX_F7BukPQNGNPkFXIUIWmY/subca
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca] 2020/08/26 00:08:52 Setting working directory to /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca/.terragrunt-cache/9qGBpCSRY899Tj5PuLtT2MlGfzo/VsJusX_F7BukPQNGNPkFXIUIWmY/subca
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca] 2020/08/26 00:08:52 Running command: terraform init

Initializing the backend...

Initializing provider plugins...
- Finding hashicorp/vault versions matching "~> 2.12.2"...
- Installing hashicorp/vault v2.12.2...
- Installed hashicorp/vault v2.12.2 (signed by HashiCorp)

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca] 2020/08/26 00:08:54 Running command: terraform apply -input=false -auto-approve
vault_mount.pki_intermediate: Creating...
vault_mount.pki_intermediate: Creation complete after 0s [id=pki/dev_drewfus.org_intermediate]
vault_pki_secret_backend_intermediate_cert_request.pki_intermediate: Creating...
vault_pki_secret_backend_intermediate_cert_request.pki_intermediate: Creation complete after 1s [id=pki/dev_drewfus.org_intermediate/intermediate/generate/internal]
vault_pki_secret_backend_root_sign_intermediate.pki_root_sign_intermediate: Creating...
vault_pki_secret_backend_root_sign_intermediate.pki_root_sign_intermediate: Creation complete after 0s [id=pki/dev_drewfus.org_root/intermediate-ca.drewfus.org.dev]
vault_pki_secret_backend_intermediate_set_signed.pki_root_sign_intermediate: Creating...
vault_pki_secret_backend_intermediate_set_signed.pki_root_sign_intermediate: Creation complete after 0s [id=pki/dev_drewfus.org_intermediate/intermediate/set-signed]

Apply complete! Resources: 4 added, 0 changed, 0 destroyed.

Outputs:

pki_intermediate_path = pki/dev_drewfus.org_intermediate
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca] 2020/08/26 00:08:56 Module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca has finished successfully!
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/managed_subdomain] 2020/08/26 00:08:56 Dependency /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca of module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/managed_subdomain just finished successfully. Module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/managed_subdomain must wait on 0 more dependencies.
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/managed_subdomain] 2020/08/26 00:08:56 Running module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/managed_subdomain now
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/managed_subdomain] 2020/08/26 00:08:56 Running command: terraform --version
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/managed_subdomain] 2020/08/26 00:08:56 Terraform version: 0.13.0
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/managed_subdomain] 2020/08/26 00:08:56 Reading Terragrunt config file at /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/managed_subdomain/terragrunt.hcl
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/managed_subdomain] 2020/08/26 00:08:56 WARNING: Could not parse remote_state block from target config /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca/terragrunt.hcl
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/managed_subdomain] 2020/08/26 00:08:56 WARNING: Falling back to terragrunt output.
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca] 2020/08/26 00:08:56 Running command: terraform --version
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca] 2020/08/26 00:08:56 Terraform version: 0.13.0
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca] 2020/08/26 00:08:56 Reading Terragrunt config file at /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca/terragrunt.hcl
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca] 2020/08/26 00:08:56 Downloading Terraform configurations from file:///home/arothste/git/github.com/andrewrothstein/tf-vault-pki/modules into /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca/.terragrunt-cache/9qGBpCSRY899Tj5PuLtT2MlGfzo/VsJusX_F7BukPQNGNPkFXIUIWmY
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca] 2020/08/26 00:08:56 Copying files from /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca into /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca/.terragrunt-cache/9qGBpCSRY899Tj5PuLtT2MlGfzo/VsJusX_F7BukPQNGNPkFXIUIWmY/subca
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca] 2020/08/26 00:08:56 Setting working directory to /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca/.terragrunt-cache/9qGBpCSRY899Tj5PuLtT2MlGfzo/VsJusX_F7BukPQNGNPkFXIUIWmY/subca
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca] 2020/08/26 00:08:56 Running command: terraform output -json
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/managed_subdomain] 2020/08/26 00:08:56 Downloading Terraform configurations from file:///home/arothste/git/github.com/andrewrothstein/tf-vault-pki/modules into /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/managed_subdomain/.terragrunt-cache/8txLRE27dDXxBTQGFFBVXWG1t38/VsJusX_F7BukPQNGNPkFXIUIWmY
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/managed_subdomain] 2020/08/26 00:08:56 Copying files from /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/managed_subdomain into /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/managed_subdomain/.terragrunt-cache/8txLRE27dDXxBTQGFFBVXWG1t38/VsJusX_F7BukPQNGNPkFXIUIWmY/managed_subdomain
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/managed_subdomain] 2020/08/26 00:08:56 Setting working directory to /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/managed_subdomain/.terragrunt-cache/8txLRE27dDXxBTQGFFBVXWG1t38/VsJusX_F7BukPQNGNPkFXIUIWmY/managed_subdomain
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/managed_subdomain] 2020/08/26 00:08:56 Running command: terraform init

Initializing the backend...

Initializing provider plugins...
- Finding hashicorp/vault versions matching "~> 2.12.2"...
- Installing hashicorp/vault v2.12.2...
- Installed hashicorp/vault v2.12.2 (signed by HashiCorp)

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/managed_subdomain] 2020/08/26 00:08:58 Running command: terraform apply -input=false -auto-approve
vault_pki_secret_backend_role.pki_intermediate_subdomain_admin: Creating...
vault_pki_secret_backend_role.pki_intermediate_subdomain_admin: Creation complete after 0s [id=pki/dev_drewfus.org_intermediate/roles/dev_drewfus.org_nj_admin]
vault_pki_secret_backend_cert.vault: Creating...
vault_pki_secret_backend_cert.vault: Creation complete after 0s [id=pki/dev_drewfus.org_intermediate/dev_drewfus.org_nj_admin/vault.nj.drewfus.org.dev]

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

Outputs:

vault_certificate = -----BEGIN CERTIFICATE-----
MIIEjTCCAnWgAwIBAgIUUZXujQMNhex1steNhBSDe67ybh0wDQYJKoZIhvcNAQEL
BQAwRDEYMBYGA1UEChMPZHJld2Z1cy5vcmcuZGV2MSgwJgYDVQQDEx9pbnRlcm1l
ZGlhdGUtY2EuZHJld2Z1cy5vcmcuZGV2MB4XDTIwMDgyNjA0MDgyOVoXDTIwMDgy
NjA1MDg1OFowIzEhMB8GA1UEAxMYdmF1bHQubmouZHJld2Z1cy5vcmcuZGV2MIIB
IjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAy28A4m70xER6gZu50TbU+iGV
rYE669wz11m33wxf6kvpRw7X3+OyQP7UU5RyhWzAnhDijBSvlZTfqhD5jR4U0ami
5eWGdbCTSpd1X7aW30J0g1p9WoG05eH+fReSlJugR2sSomjZN6tsL0+9TYLrw/o1
mO9Z7922mn6yCiTjXcyJNLYF9ZRd4WLLOp2fBoV6MItjEpkKCk6Ra1gg2/le17dF
Zsu4q3cpE1vEnE4YduFPdG/69ayoHwTYrkCz9qG/u0xyZsHiowAgoOv91lGZ0DAI
sNKafH0GqYGDvb8CaFk37s8Kge+Du8EFizWjbqdhgwt68n4Mo1XjdhaVTgXjfQID
AQABo4GXMIGUMA4GA1UdDwEB/wQEAwIDqDAdBgNVHSUEFjAUBggrBgEFBQcDAQYI
KwYBBQUHAwIwHQYDVR0OBBYEFG7PFNZsKzXSFg0KoKFMKhRQf2WqMB8GA1UdIwQY
MBaAFAiPo0gpsPLRfyB6V/2EXFahFBeCMCMGA1UdEQQcMBqCGHZhdWx0Lm5qLmRy
ZXdmdXMub3JnLmRldjANBgkqhkiG9w0BAQsFAAOCAgEAarU6EaOHpxljQ21AKPya
ahzO40RjFj0lvp2N+oBHxRPGP2hkfpM6jyg3r7CH8roAU+8jfNhhgyI18OFu/NTT
XGJwlo6NlAq1kaYjb6kadGtlq1dfmJ8yTNMHj8gugZjwTNxB5f/e/gwjne95jMgQ
uI7GL1voKrmaWdaikJggX7xWWjPG+4ku8Z7eZ1EOhr9x9fmQkBZj4tITuWo5Gstm
lG2/emyDm3DPmoaiNDL1cOiqjasCkvHzskb4w2Zf9UaajeBMejU9lcIEsO1LWDn3
XzsRgDB4QocXH1sBjuTXgBJuFDAKOuTAWfGUDa2TvvOcEixiNXHINQ7cdiS56aEg
DZWVODhpbjF4qWfSHHIHPo5EP+HqHPG90xLMEtokKPrsu14okqjA/kYVH18ijd2Z
jLpEzbtqO6ORTTwT0aEW5US/qyTkKxwL3k4+EQAaD8pWyimQfLao1svCu7/BsTmp
tCptNI47JNUv7Ue5KvWknLFQMM92TkLbnhoJifShGty80mgibaREotBnGNxcL5H0
xKUzyT4JumAqR/pCZUsO75ltoJXcq5HSVPQZQrxTRA77vcyUt1uDeWNvcsfUiSY/
xkP2s+xA5aS/5Skmz/YqM8YIfoUx02WsjIoSy3pzEO8fPMexVw5Sxhd1VMYOp9FD
DT5XMHersduugRRYYZ+5hC0=
-----END CERTIFICATE-----
vault_keypair = <sensitive>
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/managed_subdomain] 2020/08/26 00:08:59 Module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/managed_subdomain has finished successfully!
arothste@DESKTOP-H8GHQ6M:~/git/github.com/andrewrothstein/tf-vault-pki$ 
```
