# scheduled-batch-job

Convenience wrapper module for a complete scheduled AWS Batch Fargate job flow:

```text
EventBridge Scheduler -> Step Functions -> AWS Batch Fargate Job
```

This module composes:

- `modules/aws/batch-fargate`
- `modules/aws/stepfunctions-batch-submit`
- `modules/aws/eventbridge-scheduler-sfn`

## When To Use This Wrapper

Use this wrapper when you want the standard scheduled Batch job architecture with a compact input interface.

Use the building-block modules directly when you need separate lifecycle management, custom Step Functions definitions, multiple schedules per state machine, shared Batch compute environments, or more advanced IAM and networking composition.

## Basic Usage

```hcl
module "scheduled_batch_job" {
  source = "../../modules/aws/scheduled-batch-job"

  name            = "daily-report"
  vpc_id          = "vpc-0123456789abcdef0"
  subnet_ids      = ["subnet-0123456789abcdef0", "subnet-abcdef01234567890"]
  container_image = "public.ecr.aws/docker/library/alpine:latest"

  schedule_expression = "cron(0 3 * * ? *)"
  schedule_timezone   = "Europe/Belgrade"

  tags = {
    Project = "multicloud-scheduled-jobs"
  }
}
```

## Command Override From Scheduler Input

Set `enable_command_override_from_scheduler_input = true` when the scheduler input should provide the AWS Batch container command.

```hcl
module "scheduled_batch_job" {
  source = "../../modules/aws/scheduled-batch-job"

  name            = "daily-report"
  vpc_id          = "vpc-0123456789abcdef0"
  subnet_ids      = ["subnet-0123456789abcdef0"]
  container_image = "public.ecr.aws/docker/library/alpine:latest"

  enable_command_override_from_scheduler_input = true

  scheduler_target_input = {
    command = ["sh", "-c", "echo scheduled run; date; env"]
  }
}
```

When command override is enabled, `scheduler_target_input` should contain the key `command`. The `command` value must be a list of strings, matching the AWS Batch container command format.

## Network Options

- Private subnet with NAT Gateway: keep `assign_public_ip = false`; Fargate uses NAT for ECR, CloudWatch Logs, and other outbound traffic.
- Private subnet with VPC endpoints: keep `assign_public_ip = false`; pair this wrapper with `modules/aws/vpc-endpoints-fargate` so Fargate can reach ECR, CloudWatch Logs, and S3 privately.
- Public subnet with public IP: set `assign_public_ip = true`; use only when public subnet routing and security controls are appropriate.

## Outputs

The wrapper exposes the primary Batch, Step Functions, and Scheduler identifiers, including the Batch compute environment, job queue, job definition, roles, log group, task security group, state machine ARN, and schedule ARN.
