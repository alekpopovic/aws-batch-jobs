CLOUD ?= aws
DIR := examples/multicloud-switcher
TFVARS := $(CLOUD).tfvars

ifeq ($(filter $(CLOUD),aws gcp azure),)
$(error CLOUD must be aws, gcp, or azure, got "$(CLOUD)")
endif

.PHONY: fmt init validate plan apply destroy

fmt:
	terraform fmt -recursive

init:
	cd $(DIR) && terraform init

validate:
	cd $(DIR) && terraform validate

plan:
	cd $(DIR) && terraform plan -var-file=$(TFVARS)

apply:
	cd $(DIR) && terraform apply -var-file=$(TFVARS)

destroy:
	cd $(DIR) && terraform destroy -var-file=$(TFVARS)
