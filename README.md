* Run a development vault server:
```
arothste@DESKTOP-H8GHQ6M:~/git/github.com/andrewrothstein/tf-vault-pki$ vault server -dev
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

2021-03-14T20:08:12.454-0400 [INFO]  proxy environment: http_proxy= https_proxy= no_proxy=
2021-03-14T20:08:12.454-0400 [WARN]  no `api_addr` value specified in config or in VAULT_API_ADDR; falling back to detection if possible, but this value should be manually set
2021-03-14T20:08:12.460-0400 [INFO]  core: security barrier not initialized
2021-03-14T20:08:12.460-0400 [INFO]  core: security barrier initialized: stored=1 shares=1 threshold=1
2021-03-14T20:08:12.461-0400 [INFO]  core: post-unseal setup starting
2021-03-14T20:08:12.475-0400 [INFO]  core: loaded wrapping token key
2021-03-14T20:08:12.475-0400 [INFO]  core: successfully setup plugin catalog: plugin-directory=
2021-03-14T20:08:12.475-0400 [INFO]  core: no mounts; adding default mount table
2021-03-14T20:08:12.477-0400 [INFO]  core: successfully mounted backend: type=cubbyhole path=cubbyhole/
2021-03-14T20:08:12.478-0400 [INFO]  core: successfully mounted backend: type=system path=sys/
2021-03-14T20:08:12.478-0400 [INFO]  core: successfully mounted backend: type=identity path=identity/
2021-03-14T20:08:12.480-0400 [INFO]  core: successfully enabled credential backend: type=token path=token/
2021-03-14T20:08:12.480-0400 [INFO]  core: restoring leases
2021-03-14T20:08:12.480-0400 [INFO]  rollback: starting rollback manager
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
Version         1.6.3
Storage Type    inmem
Cluster Name    vault-cluster-028770c3
Cluster ID      f486be92-cd31-9c43-f763-5f555881e9f5
HA Enabled      false
```
* Terragrunt away...
```
arothste@DESKTOP-H8GHQ6M:~/git/github.com/andrewrothstein/tf-vault-pki$ terraform --version
Terraform v0.14.8
arothste@DESKTOP-H8GHQ6M:~/git/github.com/andrewrothstein/tf-vault-pki$ terragrunt --version
terragrunt version v0.28.10
arothste@DESKTOP-H8GHQ6M:~/git/github.com/andrewrothstein/tf-vault-pki$ terragrunt apply-all
[terragrunt] 2020/08/26 00:51:09 Setting download directory for module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/managed_subdomain to /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/managed_subdomain/.terragrunt-cache
[terragrunt] 2020/08/26 00:51:09 Setting download directory for module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/policy to /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/policy/.terragrunt-cache
[terragrunt] 2020/08/26 00:51:09 Setting download directory for module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca to /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca/.terragrunt-cache
[terragrunt] 2020/08/26 00:51:09 Setting download directory for module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca to /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca/.terragrunt-cache
[terragrunt] 2020/08/26 00:51:09 Stack at /home/arothste/git/github.com/andrewrothstein/tf-vault-pki:
  => Module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/managed_subdomain (excluded: false, dependencies: [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca])
  => Module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/policy (excluded: false, dependencies: [])
  => Module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca (excluded: false, dependencies: [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/policy])
  => Module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca (excluded: false, dependencies: [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca])
[terragrunt] 2020/08/26 00:51:09 [terragrunt]  Are you sure you want to run 'terragrunt apply' in each folder of the stack described above? (y/n) 
y
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca] 2020/08/26 00:51:10 Module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca must wait for 1 dependencies to finish
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/managed_subdomain] 2020/08/26 00:51:10 Module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/managed_subdomain must wait for 1 dependencies to finish
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/policy] 2020/08/26 00:51:10 Module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/policy must wait for 0 dependencies to finish
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/policy] 2020/08/26 00:51:10 Running module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/policy now
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca] 2020/08/26 00:51:10 Module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca must wait for 1 dependencies to finish
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/policy] 2020/08/26 00:51:10 Running command: terraform --version
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/policy] 2020/08/26 00:51:10 Terraform version: 0.13.0
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/policy] 2020/08/26 00:51:10 Reading Terragrunt config file at /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/policy/terragrunt.hcl
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/policy] 2020/08/26 00:51:10 Downloading Terraform configurations from file:///home/arothste/git/github.com/andrewrothstein/tf-vault-pki/modules into /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/policy/.terragrunt-cache/Q8T4hjcnD1H8_9sSV2m3pQn6EhY/VsJusX_F7BukPQNGNPkFXIUIWmY
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/policy] 2020/08/26 00:51:10 Copying files from /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/policy into /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/policy/.terragrunt-cache/Q8T4hjcnD1H8_9sSV2m3pQn6EhY/VsJusX_F7BukPQNGNPkFXIUIWmY/policy
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/policy] 2020/08/26 00:51:10 Setting working directory to /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/policy/.terragrunt-cache/Q8T4hjcnD1H8_9sSV2m3pQn6EhY/VsJusX_F7BukPQNGNPkFXIUIWmY/policy
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/policy] 2020/08/26 00:51:10 Running command: terraform apply -input=false -auto-approve
vault_policy.policies["pki-admin"]: Creating...
vault_policy.policies["pki-admin"]: Creation complete after 0s [id=pki-admin]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/policy] 2020/08/26 00:51:11 Module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/policy has finished successfully!
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca] 2020/08/26 00:51:11 Dependency /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/policy of module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca just finished successfully. Module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca must wait on 0 more dependencies.
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca] 2020/08/26 00:51:11 Running module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca now
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca] 2020/08/26 00:51:11 Running command: terraform --version
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca] 2020/08/26 00:51:11 Terraform version: 0.13.0
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca] 2020/08/26 00:51:11 Reading Terragrunt config file at /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca/terragrunt.hcl
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca] 2020/08/26 00:51:11 Downloading Terraform configurations from file:///home/arothste/git/github.com/andrewrothstein/tf-vault-pki/modules into /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca/.terragrunt-cache/Wbfugx_ebUVIqq3UPU-u_cFLRSw/VsJusX_F7BukPQNGNPkFXIUIWmY
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca] 2020/08/26 00:51:11 Copying files from /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca into /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca/.terragrunt-cache/Wbfugx_ebUVIqq3UPU-u_cFLRSw/VsJusX_F7BukPQNGNPkFXIUIWmY/rootca
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca] 2020/08/26 00:51:11 Setting working directory to /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca/.terragrunt-cache/Wbfugx_ebUVIqq3UPU-u_cFLRSw/VsJusX_F7BukPQNGNPkFXIUIWmY/rootca
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca] 2020/08/26 00:51:11 Running command: terraform apply -input=false -auto-approve
vault_mount.pki_root: Creating...
vault_mount.pki_root: Creation complete after 0s [id=pki/drewfus_org_nj_root]
vault_pki_secret_backend_root_cert.pki_root: Creating...
vault_pki_secret_backend_root_cert.pki_root: Creation complete after 1s [id=pki/drewfus_org_nj_root/root/generate/internal]

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

Outputs:

pki_root_path = pki/drewfus_org_nj_root
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca] 2020/08/26 00:51:13 Module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca has finished successfully!
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca] 2020/08/26 00:51:13 Dependency /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca of module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca just finished successfully. Module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca must wait on 0 more dependencies.
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca] 2020/08/26 00:51:13 Running module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca now
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca] 2020/08/26 00:51:13 Running command: terraform --version
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca] 2020/08/26 00:51:13 Terraform version: 0.13.0
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca] 2020/08/26 00:51:13 Reading Terragrunt config file at /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca/terragrunt.hcl
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca] 2020/08/26 00:51:13 WARNING: Could not parse remote_state block from target config /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca/terragrunt.hcl
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca] 2020/08/26 00:51:13 WARNING: Falling back to terragrunt output.
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca] 2020/08/26 00:51:13 Running command: terraform --version
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca] 2020/08/26 00:51:13 Terraform version: 0.13.0
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca] 2020/08/26 00:51:13 Reading Terragrunt config file at /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca/terragrunt.hcl
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca] 2020/08/26 00:51:13 Downloading Terraform configurations from file:///home/arothste/git/github.com/andrewrothstein/tf-vault-pki/modules into /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca/.terragrunt-cache/Wbfugx_ebUVIqq3UPU-u_cFLRSw/VsJusX_F7BukPQNGNPkFXIUIWmY
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca] 2020/08/26 00:51:13 Copying files from /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca into /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca/.terragrunt-cache/Wbfugx_ebUVIqq3UPU-u_cFLRSw/VsJusX_F7BukPQNGNPkFXIUIWmY/rootca
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca] 2020/08/26 00:51:13 Setting working directory to /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca/.terragrunt-cache/Wbfugx_ebUVIqq3UPU-u_cFLRSw/VsJusX_F7BukPQNGNPkFXIUIWmY/rootca
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/rootca] 2020/08/26 00:51:13 Running command: terraform output -json
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca] 2020/08/26 00:51:13 Downloading Terraform configurations from file:///home/arothste/git/github.com/andrewrothstein/tf-vault-pki/modules into /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca/.terragrunt-cache/9qGBpCSRY899Tj5PuLtT2MlGfzo/VsJusX_F7BukPQNGNPkFXIUIWmY
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca] 2020/08/26 00:51:13 Copying files from /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca into /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca/.terragrunt-cache/9qGBpCSRY899Tj5PuLtT2MlGfzo/VsJusX_F7BukPQNGNPkFXIUIWmY/subca
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca] 2020/08/26 00:51:13 Setting working directory to /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca/.terragrunt-cache/9qGBpCSRY899Tj5PuLtT2MlGfzo/VsJusX_F7BukPQNGNPkFXIUIWmY/subca
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca] 2020/08/26 00:51:13 Running command: terraform apply -input=false -auto-approve
vault_mount.pki_intermediate: Creating...
vault_mount.pki_intermediate: Creation complete after 0s [id=pki/drewfus_org_nj_intermediate]
vault_pki_secret_backend_intermediate_cert_request.pki_intermediate: Creating...
vault_pki_secret_backend_intermediate_cert_request.pki_intermediate: Creation complete after 3s [id=pki/drewfus_org_nj_intermediate/intermediate/generate/internal]
vault_pki_secret_backend_root_sign_intermediate.pki_root_sign_intermediate: Creating...
vault_pki_secret_backend_root_sign_intermediate.pki_root_sign_intermediate: Creation complete after 0s [id=pki/drewfus_org_nj_root/intermediate-ca.nj.drewfus.org]
vault_pki_secret_backend_intermediate_set_signed.pki_root_sign_intermediate: Creating...
vault_pki_secret_backend_intermediate_set_signed.pki_root_sign_intermediate: Creation complete after 0s [id=pki/drewfus_org_nj_intermediate/intermediate/set-signed]

Apply complete! Resources: 4 added, 0 changed, 0 destroyed.

Outputs:

pki_intermediate_path = pki/drewfus_org_nj_intermediate
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca] 2020/08/26 00:51:16 Module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca has finished successfully!
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/managed_subdomain] 2020/08/26 00:51:16 Dependency /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca of module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/managed_subdomain just finished successfully. Module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/managed_subdomain must wait on 0 more dependencies.
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/managed_subdomain] 2020/08/26 00:51:16 Running module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/managed_subdomain now
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/managed_subdomain] 2020/08/26 00:51:16 Running command: terraform --version
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/managed_subdomain] 2020/08/26 00:51:16 Terraform version: 0.13.0
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/managed_subdomain] 2020/08/26 00:51:16 Reading Terragrunt config file at /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/managed_subdomain/terragrunt.hcl
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/managed_subdomain] 2020/08/26 00:51:16 WARNING: Could not parse remote_state block from target config /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca/terragrunt.hcl
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/managed_subdomain] 2020/08/26 00:51:16 WARNING: Falling back to terragrunt output.
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca] 2020/08/26 00:51:16 Running command: terraform --version
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca] 2020/08/26 00:51:16 Terraform version: 0.13.0
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca] 2020/08/26 00:51:16 Reading Terragrunt config file at /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca/terragrunt.hcl
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca] 2020/08/26 00:51:16 Downloading Terraform configurations from file:///home/arothste/git/github.com/andrewrothstein/tf-vault-pki/modules into /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca/.terragrunt-cache/9qGBpCSRY899Tj5PuLtT2MlGfzo/VsJusX_F7BukPQNGNPkFXIUIWmY
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca] 2020/08/26 00:51:16 Copying files from /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca into /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca/.terragrunt-cache/9qGBpCSRY899Tj5PuLtT2MlGfzo/VsJusX_F7BukPQNGNPkFXIUIWmY/subca
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca] 2020/08/26 00:51:16 Setting working directory to /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca/.terragrunt-cache/9qGBpCSRY899Tj5PuLtT2MlGfzo/VsJusX_F7BukPQNGNPkFXIUIWmY/subca
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/subca] 2020/08/26 00:51:16 Running command: terraform output -json
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/managed_subdomain] 2020/08/26 00:51:16 Downloading Terraform configurations from file:///home/arothste/git/github.com/andrewrothstein/tf-vault-pki/modules into /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/managed_subdomain/.terragrunt-cache/8txLRE27dDXxBTQGFFBVXWG1t38/VsJusX_F7BukPQNGNPkFXIUIWmY
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/managed_subdomain] 2020/08/26 00:51:16 Copying files from /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/managed_subdomain into /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/managed_subdomain/.terragrunt-cache/8txLRE27dDXxBTQGFFBVXWG1t38/VsJusX_F7BukPQNGNPkFXIUIWmY/managed_subdomain
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/managed_subdomain] 2020/08/26 00:51:16 Setting working directory to /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/managed_subdomain/.terragrunt-cache/8txLRE27dDXxBTQGFFBVXWG1t38/VsJusX_F7BukPQNGNPkFXIUIWmY/managed_subdomain
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/managed_subdomain] 2020/08/26 00:51:16 Running command: terraform apply -input=false -auto-approve
vault_pki_secret_backend_role.pki_intermediate_subdomain_admin: Creating...
vault_pki_secret_backend_role.pki_intermediate_subdomain_admin: Creation complete after 0s [id=pki/drewfus_org_nj_intermediate/roles/drewfus_org_nj_dev_admin]
vault_pki_secret_backend_cert.vault: Creating...
vault_pki_secret_backend_cert.vault: Creation complete after 0s [id=pki/drewfus_org_nj_intermediate/drewfus_org_nj_dev_admin/vault.dev.nj.drewfus.org]

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

Outputs:

vault_certificate = -----BEGIN CERTIFICATE-----
MIIEizCCAnOgAwIBAgIUbn8/yrg3RX6jlcW/Y/1g/ByhgOIwDQYJKoZIhvcNAQEL
BQAwQjEXMBUGA1UEChMObmouZHJld2Z1cy5vcmcxJzAlBgNVBAMTHmludGVybWVk
aWF0ZS1jYS5uai5kcmV3ZnVzLm9yZzAeFw0yMDA4MjYwNDUwNDdaFw0yMDA4MjYw
NTUxMTdaMCMxITAfBgNVBAMTGHZhdWx0LmRldi5uai5kcmV3ZnVzLm9yZzCCASIw
DQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALfIvHFQWQUtTrVPjreBkXkmQnUb
8ZPSmlGPWyzyg+R/9Un7OQH5GItidJb4HFTngpTQM6fQ8XblUpk3myJH+VkoKQ6i
tAdkB8gDzpN9uO47l9EPQm4Kw7RHLATEjHQt8sV/nY0fVUFnrcu9KSkPPzFJlBjv
4IZv/OBIz9reoMG5Xr2M4VdfCSgJ2jksX+ylO9Tk/nEiBEFionz9A4493akVoTiN
fGg5miCSd6NxwJqs8YC/5uf6oJqm8E30ee5j/AY5ZD9LEDqbo6WUZLAk7r92qF+G
Rm8F8rtV3j+ztnboKw2kj2GLrjemsTqtJFC+K10YHEwcddz2vf7oj9ZK5/8CAwEA
AaOBlzCBlDAOBgNVHQ8BAf8EBAMCA6gwHQYDVR0lBBYwFAYIKwYBBQUHAwEGCCsG
AQUFBwMCMB0GA1UdDgQWBBQK6XmdOUvYVtfgihVv5YK0m3/EUjAfBgNVHSMEGDAW
gBRJLYRocvqRo9LaSTUVrAVZqNHBEDAjBgNVHREEHDAaghh2YXVsdC5kZXYubmou
ZHJld2Z1cy5vcmcwDQYJKoZIhvcNAQELBQADggIBAG+RGHTJqZNatDajTDPfPGbV
iOLVJf14dNN7Vvx0HT7mxO882f9hFyS/ouVgRC4bZXYNskuA2B9nZmpj9UVNZ/Ne
gA8XazeYo0r3x2eMxg1HpAjM5m3f49ZT/oBl52GGo9DHQltcCmB1WghqqWN2sDxt
XdViUPrU4GHojMsVSvODT291eNWEkIYNQMwWs53xjNqYUEYDJ02cmIpp2Kum3Ou4
rcNebgV4+XlInI6T+g5S2+l1DjPqNzPA6qpnWM/vmAPw7dCKE2RpcS1061hmqBLd
V2U0auLQrho+CW8uktveU4EyPgGR4OMXqKknqgynphjBMOcctcD+L7eOfttdu8Yw
GfmpBvfQWjRgBpVJ9B9lyaoEo/gyfYAfARJuGkOMU7snYveReAjb0glfJNA0Ow+0
W+ydKGsor/WFFgoTGVm+g3TKh5W2Pi8kG1w1FmyBMuqCo4zzT/RdyaELCzsC8gO1
1tbsJjsgOFepFg4ZGe94bQ32GAV84HB0LIwx15R8Fds+comsT+U5jYYBagj8xjeX
VUZOL7cessn+hj0Nt9ngeJdL6YA9uUAOw6AgVSnAidX/0VK8TMJpMB+h1pXFzeHD
FFo/oFAWygEs1GB6JzN21LCJ8d5eBtZ3mYnh87OLYseCl3+LzW/ohcsGYe36tamZ
xEMHG7z+5ndcS4eQMFpd
-----END CERTIFICATE-----
vault_keypair = <sensitive>
[terragrunt] [/home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/managed_subdomain] 2020/08/26 00:51:17 Module /home/arothste/git/github.com/andrewrothstein/tf-vault-pki/dev/managed_subdomain has finished successfully!
arothste@DESKTOP-H8GHQ6M:~/git/github.com/andrewrothstein/tf-vault-pki$ 
```
