.PHONY: launch-dev-vault launch-dev-minio
.PHONY: tg-init tg-validate
.PHONY: mc-login mc-list-buckets mc-create-bucket mc-delete-bucket
.PHONY: clean clean-tf-locks

.EXPORT_ALL_VARIABLES:
MINIO_ROOT_USER=admin
AWS_ACCESS_KEY_ID=admin
MINIO_ROOT_PASSWORD=password
AWS_SECRET_ACCESS_KEY=password
MINIO_DATA_DIR=.minio-data
MINIO_URL=http://localhost:9000
MINIO_REGION=us-east-2
TG_BUCKET=terragrunt-dev-bucket
VAULT_ADDR=http://localhost:8200
TF_INPUT=false

launch-local-vault:
	vault server -dev

launch-local-minio:
	mkdir -p $$MINIO_DATA_DIR
	minio server $$MINIO_DATA_DIR

mc-login:
	mc alias set local-minio $$MINIO_URL $$MINIO_ROOT_USER $$MINIO_ROOT_PASSWORD

mc-list-buckets: mc-login
	mc ls local-minio

mc-create-bucket: mc-login
	mc mb local-minio/$$TG_BUCKET

mc-delete-bucket: mc-login
	mc rb local-minio/$$TG_BUCKET

versions:
	vault --version
	terraform --version
	terragrunt --version

vault-status:
	vault status

tg-init:
	terragrunt run-all init

tg-validate:
	terragrunt run-all validate

tg-plan:
	terragrunt run-all plan

tg-apply:
	terragrunt run-all apply

clean:
	find . -name '.terragrunt-cache' | xargs rm -rf
	find . -name '.terraform' | xargs rm -rf
