# scheduled-batch-job

Switcher wrapper for creating a scheduled container Batch job on either AWS or GCP through a shared interface.

Supported flows:

```text
AWS: EventBridge Scheduler -> Step Functions -> AWS Batch Fargate Job
GCP: Cloud Scheduler -> Workflows -> Cloud Batch container job
```

This module does not duplicate AWS or GCP resources. It only calls the provider-specific wrapper modules:

- `../../aws/scheduled-batch-job`
- `../../gcp/scheduled-batch-job`

Terraform module sources cannot be dynamic, so the switcher uses two static module blocks with `count`. `cloud_provider = "aws"` enables the AWS module, and `cloud_provider = "gcp"` enables the GCP module.

## Schedule Formats

`schedule_expression` is provider-specific:

- AWS uses EventBridge Scheduler syntax, for example `cron(0 3 * * ? *)`.
- GCP uses unix cron syntax, for example `0 3 * * *`.

When `schedule_expression = null`, the module uses the correct default for the selected provider.

## Provider Config

Use `aws_config` only when `cloud_provider = "aws"`. AWS requires `aws_config.vpc_id` and at least one `aws_config.subnet_ids` entry.

Use `gcp_config` only when `cloud_provider = "gcp"`. GCP requires `gcp_config.project_id`.

`tags` are passed directly to AWS. For GCP, the same map is converted into lowercase labels with GCP-compatible characters.

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
  container_image = "europe-docker.pkg.dev/my-project/jobs/my-job:latest"

  gcp_config = {
    project_id = "my-project"
    region     = "europe-west1"
  }

  container_command = ["sh", "-c", "echo hello from Cloud Batch; date"]

  tags = {
    project = "multicloud-scheduled-jobs"
    env     = "dev"
  }
}
```

## Scheduler Input And Command Override

Use `scheduler_input` to pass provider scheduler input through the selected implementation. Set `enable_command_override_from_scheduler_input = true` when the input includes a command override.

```hcl
scheduler_input = {
  command = ["sh", "-c", "echo scheduled run; date; env"]
}
```

For production, provider-specific examples are often clearer because AWS and GCP have different networking, schedule formats, IAM models, and operational details. This switcher is useful when you want one uniform Terraform interface.
