# Multicloud Switcher Example

This example shows how to choose AWS or GCP with one variable:

```hcl
cloud_provider = "aws"
```

or:

```hcl
cloud_provider = "gcp"
```

It uses `modules/multicloud/scheduled-batch-job`, which has static AWS and GCP module blocks and enables only the selected implementation with `count`.

The switcher example may install both AWS and Google provider plugins during `terraform init`, but it creates resources only for the selected `cloud_provider`.

## AWS Usage

```bash
cp aws.tfvars.example terraform.tfvars
terraform init
terraform validate
terraform plan
terraform apply
```

AWS uses EventBridge Scheduler expressions, for example:

```hcl
schedule_expression = "cron(0 3 * * ? *)"
```

## GCP Usage

Enable the Service Usage API before managing project services with Terraform:

```bash
gcloud services enable serviceusage.googleapis.com --project PROJECT_ID
```

Then run:

```bash
cp gcp.tfvars.example terraform.tfvars
terraform init
terraform validate
terraform plan
terraform apply
```

GCP uses unix cron format, for example:

```hcl
schedule_expression = "0 3 * * *"
```

## Authentication

Provider credentials come from the standard AWS and GCP authentication mechanisms.

For AWS, use environment variables, shared config profiles, SSO, or instance/role credentials supported by the AWS provider.

For GCP, use Application Default Credentials, workload identity, or other credentials supported by the Google provider.

Do not put credentials or secrets in `*.tfvars` files.

## Inputs

Use `aws_config` when `cloud_provider = "aws"`. At minimum, provide:

- `vpc_id`
- `subnet_ids`

Use `gcp_config` when `cloud_provider = "gcp"`. At minimum, provide:

- `project_id`

The same `container_image`, `container_command`, `environment_variables`, `scheduler_input`, and `tags` variables are passed through the multicloud switcher to the selected provider implementation.
