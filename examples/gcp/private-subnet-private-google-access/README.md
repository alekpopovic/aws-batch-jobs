# GCP private subnet with Private Google Access example

Skeleton example for GCP Batch jobs running from a private subnet with Private Google Access.

## Usage

```bash
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform fmt -recursive
terraform validate
```

## TODO

- Implement private networking behavior in the GCP modules.
- Document apply instructions once the GCP modules are complete.
