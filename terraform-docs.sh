#!/bin/bash

terraform-docs markdown table --output-file README.md --output-mode inject './Entregáveis/terraform/'

modules=("ansible" "bastion" "efs" "eks" "network" "rds" "s3" "secrets")

for v in "${modules[@]}"; do
    terraform-docs markdown table --output-file README.md --output-mode inject "./Entregáveis/terraform/modules/${v}"
done

terraform-docs markdown table --output-file README.md --output-mode inject './Entregáveis/validate_certificate'
