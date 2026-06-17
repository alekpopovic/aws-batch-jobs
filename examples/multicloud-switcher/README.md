# Multicloud switcher example

Skeleton example for the future multicloud scheduled batch job switcher.

## Usage

```bash
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform fmt -recursive
terraform validate
```

## TODO

- Implement provider-specific switcher behavior in `modules/multicloud/scheduled-batch-job`.
