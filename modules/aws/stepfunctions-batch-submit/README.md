# stepfunctions-batch-submit

Terraform module for a Step Functions state machine that submits AWS Batch jobs through the optimized synchronous service integration.

## What This Module Creates

- Step Functions Standard state machine.
- Step Functions execution IAM role.
- Inline IAM policy for submitting and monitoring AWS Batch jobs.

The state machine uses:

```text
arn:${data.aws_partition.current.partition}:states:::batch:submitJob.sync
```

The `.sync` integration waits for the AWS Batch job to complete before the Step Functions task finishes. This module intentionally does not use Lambda and does not use asynchronous `batch:submitJob`.

## Basic Usage

```hcl
module "batch_submit_state_machine" {
  source = "../../modules/aws/stepfunctions-batch-submit"

  name               = "daily-report"
  job_queue_arn      = module.batch_fargate.job_queue_arn
  job_definition_arn = module.batch_fargate.job_definition_arn

  container_environment_overrides = {
    TRIGGER_SOURCE = "eventbridge-scheduler"
    ENVIRONMENT    = "prod"
  }

  tags = {
    Project = "scheduled-batch-jobs"
  }
}
```

## Dynamic Command Override

Set `command_json_path` when the state machine input should provide a command override:

```hcl
module "batch_submit_state_machine" {
  source = "../../modules/aws/stepfunctions-batch-submit"

  name               = "daily-report"
  job_queue_arn      = module.batch_fargate.job_queue_arn
  job_definition_arn = module.batch_fargate.job_definition_arn
  command_json_path  = "$.command"
}
```

With that setting, an execution input can include:

```json
{
  "command": ["sh", "-c", "echo from step functions"]
}
```

The `command` value must be a list of strings. The module emits this as the ASL key `"Command.$"` inside `ContainerOverrides`.

## IAM Permissions

The module creates an execution role assumed by `states.amazonaws.com`.

The inline policy allows:

- `batch:SubmitJob` on the configured job queue and job definition.
- `batch:DescribeJobs` and `batch:TerminateJob` on `*`, which AWS Step Functions requires for synchronous Batch job monitoring.
- `events:PutTargets`, `events:PutRule`, and `events:DescribeRule` on the partition, region, and account-aware `StepFunctionsGetEventsForBatchJobsRule` EventBridge rule used by the optimized integration.
