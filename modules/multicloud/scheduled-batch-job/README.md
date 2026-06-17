# scheduled-batch-job

Switcher wrapper for creating a scheduled container Batch job on AWS, GCP, or Azure through a shared interface.

Supported flows:

```text
AWS:   EventBridge Scheduler -> Step Functions -> AWS Batch Fargate Job
GCP:   Cloud Scheduler -> Workflows -> Cloud Batch container job
Azure: Logic Apps Recurrence Trigger -> Logic App Workflow -> Azure Batch Pool -> Container Task
```

This module does not duplicate provider resources. It only calls the provider-specific wrapper modules:

- `../../aws/scheduled-batch-job`
- `../../gcp/scheduled-batch-job`
- `../../azure/scheduled-batch-job`

Terraform module sources cannot be dynamic, so the switcher uses static module blocks with `count`. `cloud_provider = "aws"` enables the AWS module, `cloud_provider = "gcp"` enables the GCP module, and `cloud_provider = "azure"` enables the Azure module.

## Schedule Formats

`schedule_expression` is provider-specific for AWS and GCP:

- AWS uses EventBridge Scheduler syntax, for example `cron(0 3 * * ? *)`.
- GCP uses unix cron syntax, for example `0 3 * * *`.

When `schedule_expression = null`, the module uses the correct default for the selected AWS or GCP provider.

Azure does not use `schedule_expression`. Azure Logic Apps recurrence is configured through `azure_config.recurrence_frequency`, `azure_config.recurrence_interval`, `azure_config.recurrence_time_zone`, `azure_config.recurrence_hours`, `azure_config.recurrence_minutes`, `azure_config.recurrence_week_days`, and `azure_config.start_time`.

## Provider Config

Use `aws_config` only when `cloud_provider = "aws"`. AWS requires `aws_config.vpc_id` and at least one `aws_config.subnet_ids` entry.

Use `gcp_config` only when `cloud_provider = "gcp"`. GCP requires `gcp_config.project_id`.

Use `azure_config` only when `cloud_provider = "azure"`. Azure requires `azure_config.subscription_id` and `azure_config.resource_group_name`. If `azure_config.public_address_provisioning_type = "NoPublicIPAddresses"`, Azure also requires `azure_config.subnet_id`.

`tags` are passed directly to AWS. For GCP, the same map is converted into lowercase labels with GCP-compatible characters.
For Azure, `tags` are passed directly to the Azure wrapper.

## AWS Usage

```hcl
module "scheduled_job" {
  source = "../../modules/multicloud/scheduled-batch-job"

  cloud_provider  = "aws"
  name            = "scheduled-batch-aws"
  container_image = "<aws-account-id>.dkr.ecr.eu-central-1.amazonaws.com/my-job:latest"

  aws_config = {
    vpc_id     = "vpc-xxxxxxxxxxxxxxxxx"
    subnet_ids = ["subnet-aaaaaaaaaaaaaaaaa", "subnet-bbbbbbbbbbbbbbbbb"]
  }

  environment_variables = {
    APP_ENV = "dev"
  }

  tags = {
    Project = "multicloud-scheduled-jobs"
    Env     = "dev"
  }
}
```

## GCP Usage

```hcl
module "scheduled_job" {
  source = "../../modules/multicloud/scheduled-batch-job"

  cloud_provider  = "gcp"
  name            = "scheduled-batch-gcp"
  container_image = "europe-docker.pkg.dev/<gcp-project-id>/jobs/my-job:latest"

  gcp_config = {
    project_id = "<gcp-project-id>"
    region     = "europe-west1"
  }

  container_command = ["sh", "-c", "echo hello from Cloud Batch; date"]

  tags = {
    project = "multicloud-scheduled-jobs"
    env     = "dev"
  }
}
```

## Azure Usage

```hcl
module "scheduled_job" {
  source = "../../modules/multicloud/scheduled-batch-job"

  cloud_provider  = "azure"
  name            = "scheduled-batch-azure"
  container_image = "mcr.microsoft.com/azure-cli:latest"

  container_command = ["sh", "-c", "echo hello from Azure Batch; date; env"]

  azure_config = {
    subscription_id     = "<azure-subscription-id>"
    resource_group_name = "rg-scheduled-batch"
    location            = "westeurope"

    recurrence_frequency = "Day"
    recurrence_interval  = 1
    recurrence_hours     = [3]
    recurrence_minutes   = [0]
  }

  environment_variables = {
    APP_ENV = "dev"
  }

  tags = {
    project = "multicloud-scheduled-jobs"
    env     = "dev"
  }
}
```

Azure Logic Apps handles both the schedule and the orchestration. The workflow submits jobs to Azure Batch through the Batch REST API and polls task status. For no-public-IP pools, create networking separately and pass `azure_config.subnet_id` with `azure_config.public_address_provisioning_type = "NoPublicIPAddresses"`.

## Scheduler Input And Command Override

Use `scheduler_input` to pass provider scheduler input through the selected implementation. Set `enable_command_override_from_scheduler_input = true` when the input includes a command override.

```hcl
scheduler_input = {
  command = ["sh", "-c", "echo scheduled run; date; env"]
}
```

For production, provider-specific examples are often clearer because AWS, GCP, and Azure have different networking, schedule formats, IAM models, and operational details. This switcher is useful when you want one uniform Terraform interface.

## Credentials And Secrets

Provider credentials come from standard AWS, GCP, and Azure authentication mechanisms. Do not put credentials or secrets in `tfvars`.

Application secrets should live in AWS Secrets Manager, Google Cloud Secret Manager, or Azure Key Vault. Grant access only to the AWS Batch job role, GCP Batch runtime service account, or Azure Batch runtime identity when the container needs those secrets.
