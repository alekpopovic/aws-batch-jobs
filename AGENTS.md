# Repository Instructions

## Project

This repository contains Terraform modules and examples for scheduled batch jobs across AWS, GCP, and a future multicloud switcher.

Current implemented AWS target architecture:

```text
EventBridge Scheduler -> AWS Step Functions -> AWS Batch SubmitJob -> AWS Batch Fargate Job
```

## Ground Rules

- Keep the root directory free of Terraform resources.
- Put AWS resources in reusable modules under `modules/aws/`.
- Put GCP resources in reusable modules under `modules/gcp/`.
- Put provider switcher abstractions under `modules/multicloud/`.
- Put runnable examples under `examples/`.
- Do not use Lambda.
- Do not use Cloud Functions.
- Do not use Cloud Run jobs.
- Do not use EC2 AWS Batch compute environments.
- AWS Batch compute environments must use Fargate.
- Do not hardcode AWS account IDs.
- Do not hardcode AWS partitions.
- Use `data.aws_caller_identity.current` and `data.aws_partition.current` where account or partition context is needed.
- EventBridge schedules must use `aws_scheduler_schedule`.
- Step Functions Batch integration must use `arn:${data.aws_partition.current.partition}:states:::batch:submitJob.sync`.

## Terraform Standards

- Terraform `required_version` must be `>= 1.5.0`.
- AWS provider version must be `>= 5.0`.
- Run `terraform fmt -recursive` after editing Terraform files.
- Keep examples self-contained and provider-configured through provider-specific region variables.
- Do not commit `*.tfvars`; use `*.tfvars.example` for sample values.
- Do not ignore `.terraform.lock.hcl`.

## Repository Layout

- `modules/aws/batch-fargate`: AWS Batch Fargate resources and IAM.
- `modules/aws/stepfunctions-batch-submit`: Step Functions state machine for synchronous Batch submit jobs.
- `modules/aws/eventbridge-scheduler-sfn`: EventBridge Scheduler invoking Step Functions.
- `modules/aws/vpc-endpoints-fargate`: VPC endpoints for private Fargate workloads.
- `modules/aws/scheduled-batch-job`: AWS composition module for the full scheduled job pattern.
- `modules/gcp/*`: Skeleton GCP modules for the future GCP scheduled Batch implementation.
- `modules/multicloud/scheduled-batch-job`: Skeleton switcher module for AWS/GCP selection.
- `examples/aws/basic`: Minimal AWS usage example.
- `examples/aws/private-subnet-with-vpc-endpoints`: AWS private subnet usage example.
- `examples/gcp/basic`: Skeleton GCP usage example.
- `examples/gcp/private-subnet-private-google-access`: Skeleton GCP private subnet usage example.
- `examples/multicloud-switcher`: Skeleton provider switcher example.

## Validation

Before finishing changes, run:

```bash
terraform fmt -recursive
terraform fmt -check -recursive
```

Add deeper `terraform validate` coverage once module implementations are complete.

## Git Workflow

After each prompt that changes files, run:

```bash
git status --short
git add .
git commit -m "<concise change summary>"
git push
```

Check the staged diff before committing when practical. Do not commit secrets, local `*.tfvars` files, Terraform state, or unrelated user changes.
