# logicapp-batch-submit

Creates an Azure Logic Apps Consumption workflow that submits and monitors Azure Batch container work at runtime.

Azure flow:

```text
Logic App Recurrence -> Logic App workflow -> Azure Batch REST API create job/task -> poll task until completed
```

This module is the Azure equivalent of a synchronous Batch submit workflow. It does not create Azure Batch jobs or tasks in Terraform. Each Logic App run creates a unique Batch job and one container task, polls the task, and returns the final status.

## Authentication

The Logic App uses a system-assigned managed identity. HTTP actions call the Azure Batch REST API with managed identity authentication and audience:

```text
https://batch.core.windows.net/
```

The module assigns `batch_role_definition_name` on the Batch account scope. The default is:

```hcl
batch_role_definition_name = "Azure Batch Job Submitter"
```

If your Batch REST create-task or polling calls require broader data-plane access in your tenant, use the documented fallback role:

```hcl
batch_role_definition_name = "Azure Batch Data Contributor"
```

No service principal secrets, Batch shared keys, callback SAS URLs, or storage account keys are created or output.

## Workflow Behavior

The workflow:

- runs from a Recurrence trigger
- creates a unique Batch job ID using the sanitized module name and `ticks(utcNow())`
- creates task `main`
- polls the task until `state == completed` or `max_poll_attempts` is reached
- fails the workflow on non-zero task exit code
- optionally terminates jobs after task failure
- optionally deletes the job after success

## Command Override

By default, tasks use `container_command_line`.

Set `enable_command_override_from_trigger_body = true` to let `triggerBody().commandLine` override it. When `commandLine` is not present, the workflow falls back to `container_command_line`.

Azure Batch task `commandLine` is a single string. This differs from AWS and GCP examples in this repository, where commands are often represented as `list(string)`.

Example trigger body:

```json
{
  "commandLine": "/bin/sh -c \"echo override from Logic App trigger; date; env\""
}
```

For complex Azure commands, prefer setting `container_command_line` explicitly instead of relying on a generated string from a list.

## Usage

```hcl
module "logicapp_batch_submit" {
  source = "../logicapp-batch-submit"

  subscription_id        = var.subscription_id
  resource_group_name    = module.resource_group.resource_group_name
  location               = module.resource_group.location
  name                   = var.name
  batch_account_id       = module.batch_account_pool.batch_account_id
  batch_account_name     = module.batch_account_pool.batch_account_name
  batch_account_endpoint = module.batch_account_pool.batch_account_endpoint
  batch_pool_name        = module.batch_account_pool.batch_pool_name
  container_image        = var.container_image

  recurrence_frequency = "Day"
  recurrence_interval  = 1
  recurrence_hours     = [3]
  recurrence_minutes   = [0]
}
```

## Notes

The workflow definition is deployed with `azapi_resource` as a full ARM Logic Apps definition. This keeps the recurrence trigger, HTTP actions, polling loop, and failure handling in one deployable workflow.
