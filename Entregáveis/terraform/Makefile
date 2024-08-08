SHELL := /bin/bash

.PHONY: all setup start records ansible ssh stop clean

all: setup start records

setup:
	@echo 'Initializing terraform...'
	@terraform init
	@terraform \
		-chdir=../validate_certificate \
		init

start:
	@echo 'Creating certificate...'
	@terraform \
		apply \
		--auto-approve \
		-var-file='development.tfvars' \
		-target=aws_acm_certificate.website_cert
	echo "records=$$(terraform output cert_validation | sed -e '1s/^toset(//' -e '$$s/)$$//')" \
		> ../validate_certificate/records.tfvars
	@echo 'Validating certificate...'
	@terraform \
		-chdir=../validate_certificate \
		apply \
		--auto-approve \
		-var-file='records.tfvars' \
		-var='ingress=""' \
		-target=aws_route53_record.validate_record
	@echo 'Applying terraform...'
	@terraform \
		apply \
		--auto-approve \
		-var-file='development.tfvars' \
		-parallelism=10

records:
	@echo 'Add records...'
	echo "records=$$(terraform output cert_validation | sed -e '1s/^toset(//' -e '$$s/)$$//')" \
		> ../validate_certificate/records.tfvars
	echo "ingress=\"$$(ssh -i ~/.ssh/ec2_aws ubuntu@$$(terraform -chdir=../terraform output bastion_public_ip | sed 's/\"//g') -- kubectl get ingress wordpress -n wordpress -o jsonpath="{.status.loadBalancer.ingress[0].hostname}")\"" \
		>> ../validate_certificate/records.tfvars
	terraform \
		-chdir=../validate_certificate \
		apply \
		--auto-approve \
		-var-file='records.tfvars'

ansible:
	@terraform apply --auto-approve -var-file='development.tfvars' -replace=module.ansible.null_resource.setup_ansible

ssh:
	@echo 'Trying to reach bastion...'
	@ssh -i ~/.ssh/ec2_aws ubuntu@$$(terraform output | grep bastion_public_ip | cut -d ' ' -f 3 | tr -d '"')

stop:
	@echo 'Destroying terraform...'
	@terraform destroy --auto-approve -var-file='development.tfvars'

clean:
	@echo 'Removing terraform files...'
	@rm -r terraform.tfstate terraform.tfstate.backup .terraform.tfstate.lock.info .terraform .terraform.lock.hcl
