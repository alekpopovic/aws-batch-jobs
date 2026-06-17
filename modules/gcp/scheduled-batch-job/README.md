# scheduled-batch-job

Convenience wrapper for the GCP scheduled container job flow:

```text
Cloud Scheduler -> Google Workflows -> Cloud Batch container job
```

The wrapper composes:

- `modules/gcp/batch-runtime-iam`
- `modules/gcp/workflows-batch-submit`
- `modules/gcp/cloud-scheduler-workflows`

It does not create networking resources. Pass `network` and `subnetwork` directly, or create them with `modules/gcp/batch-private-network` in an example or root composition.

## Service Accounts

This flow uses three separate service accounts:

- Scheduler service account: owned by the Scheduler module and used to call the Workflows executions API.
- Workflows service account: owned by the Workflow module and used to create Cloud Batch jobs.
- Batch runtime service account: owned by the runtime IAM module and attached to Batch runtime VMs.

Runtime permissions for the container, such as Secret Manager, Cloud Storage, BigQuery, or other API access, should be added through `additional_runtime_roles`. Do not add those runtime permissions to the Scheduler or Workflows service accounts.

## Private Network Inputs

For private Batch VMs, pass `network`, `subnetwork`, and set:

```hcl
no_external_ip_address = true
```

The subnet should have Private Google Access enabled. Use `modules/gcp/batch-private-network` when you want this repository to create that network for an example composition.

## Command Override

Set `enable_command_override_from_scheduler_argument = true` to let Scheduler input override the default container command.

`scheduler_workflow_argument` must include `command` as a list of strings:

```hcl
scheduler_workflow_argument = {
  source  = "cloud-scheduler"
  command = ["sh", "-c", "echo scheduled run; date; env"]
}
```

## Usage

```hcl
module "scheduled_batch_job" {
  source = "../modules/gcp/scheduled-batch-job"

  project_id      = var.project_id
  region          = var.region
  name            = "scheduled-batch-gcp"
  container_image = "europe-docker.pkg.dev/example/jobs/worker:latest"

  container_commands = ["sh", "-c", "echo hello from Cloud Batch; date"]

  environment_variables = {
    APP_ENV   = "dev"
    LOG_LEVEL = "info"
  }

  schedule  = "0 3 * * *"
  time_zone = "Europe/Belgrade"

  labels = {
    project = "multicloud-scheduled-jobs"
    env     = "dev"
  }
}
```

## Private Network Usage

```hcl
module "private_network" {
  source = "../modules/gcp/batch-private-network"

  project_id = var.project_id
  region     = var.region
  name       = "scheduled-batch-gcp"
}

module "scheduled_batch_job" {
  source = "../modules/gcp/scheduled-batch-job"

  project_id      = var.project_id
  region          = var.region
  name            = "scheduled-batch-gcp"
  container_image = var.container_image

  network                = module.private_network.network_self_link
  subnetwork             = module.private_network.subnetwork_self_link
  no_external_ip_address = true
}
```
