# GCP basic example

Skeleton example for the GCP scheduled Batch job wrapper.

Target flow:

```text
Cloud Scheduler -> Google Workflows -> GCP Batch Job
```

## Usage

```bash
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform fmt -recursive
terraform validate
```

## TODO

- Implement the GCP wrapper module resources.
- Add apply instructions once the module is complete.
