.PHONY: launch-dev-vault launch-dev-minio tg-init tg-validate clean

.EXPORT_ALL_VARIABLES:
MINIO_ROOT_USER=admin
AWS_ACCESS_KEY_ID=admin
MINIO_ROOT_PASSWORD=password
AWS_SECRET_ACCESS_KEY=password
MINIO_DATA_DIR=.minio-data

launch-dev-vault:
	vault server -dev

launch-dev-minio:
	mkdir -p $$MINIO_DATA_DIR
	minio server $$MINIO_DATA_DIR

tg-init:
	terragrunt run-all init

tg-validate:
	terragrunt run-all validate

clean-tf-locks:
	find . -name '.terraform.lock.hcl' | xargs rm -f

clean:
	find . -name '.terragrunt-cache' | xargs rm -rf
	find . -name '.terraform' | xargs rm -rf

