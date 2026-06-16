# eventbridge-scheduler-sfn

Terraform module for EventBridge Scheduler invoking a Step Functions state machine with `states:StartExecution`.

## What This Module Creates

- EventBridge Scheduler schedule using `aws_scheduler_schedule`.
- Scheduler execution IAM role.
- Least-privilege inline IAM policy allowing `states:StartExecution` on one state machine.

This module does not create Lambda functions and does not use legacy `aws_cloudwatch_event_rule` resources.

## Basic Usage

```hcl
module "scheduler" {
  source = "../../modules/eventbridge-scheduler-sfn"

  name              = "daily-report"
  state_machine_arn = module.batch_submit_state_machine.state_machine_arn

  schedule_expression = "cron(0 3 * * ? *)"
  schedule_timezone   = "Europe/Belgrade"

  target_input = {
    command = ["sh", "-c", "echo scheduled run"]
  }

  tags = {
    Project = "scheduled-batch-jobs"
  }
}
```

## Schedule Expression and Timezone

`schedule_expression` accepts EventBridge Scheduler expressions such as `rate(1 day)` or `cron(0 3 * * ? *)`.

`schedule_timezone` controls how cron expressions are evaluated. The default is `Europe/Belgrade`.

## Target Input

`target_input` is JSON encoded and sent as the Step Functions execution input. Use it to pass runtime values such as command overrides or job parameters.

## IAM Least Privilege

The Scheduler execution role is trusted by `scheduler.amazonaws.com` only for the calculated schedule ARN and current AWS account. The inline policy allows only `states:StartExecution` on the provided `state_machine_arn`.
