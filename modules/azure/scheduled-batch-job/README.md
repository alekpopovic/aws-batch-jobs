# Azure Scheduled Batch Job

Convenience wrapper for the Azure scheduled container job flow:

```text
Azure Logic Apps Recurrence Trigger
        |
        v
Logic App Workflow
        |
        v
Azure Batch REST API
        |
        v
Azure Batch Pool
        |
        v
Container Task
```

The wrapper composes:

- `modules/azure/batch-account-pool`
- `modules/azure/logicapp-batch-submit`

It does not create networking. Pass `subnet_id` and `public_address_provisioning_type` when you want to attach the Batch pool to a private subnet created by `modules/azure/batch-private-network`.

## How It Works

Logic Apps handles both scheduling and orchestration. The Recurrence trigger starts the workflow, the workflow submits an Azure Batch job through the Azure Batch REST API, then polls the task until completion or failure.

Azure Batch concepts:

- Batch account: control plane for pools, jobs, and tasks.
- Batch pool: compute capacity where tasks run.
- Batch job: grouping created by the Logic App execution.
- Batch task: the container command submitted to the pool.

## Basic Usage

```hcl
module "scheduled_batch_job" {
  source = "../../modules/azure/scheduled-batch-job"

  subscription_id     = var.subscription_id
  resource_group_name = var.resource_group_name
  location            = "westeurope"
  name                = "scheduled-batch-azure"

  container_image = "mcr.microsoft.com/azure-cli:latest"

  recurrence_frequency = "Day"
  recurrence_interval  = 1
  recurrence_hours     = [3]
  recurrence_minutes   = [0]

  environment_variables = {
    APP_ENV   = "dev"
    LOG_LEVEL = "info"
  }

  tags = {
    project = "multicloud-scheduled-jobs"
    env     = "dev"
  }
}
```

## No Public IP Usage

Use `modules/azure/batch-private-network` to create the VNet/subnet, then pass the subnet to this wrapper:

```hcl
module "network" {
  source = "../../modules/azure/batch-private-network"

  name                = "scheduled-batch-azure"
  resource_group_name = var.resource_group_name
  location            = var.location

  create_nat_gateway = true
}

module "scheduled_batch_job" {
  source = "../../modules/azure/scheduled-batch-job"

  subscription_id     = var.subscription_id
  resource_group_name = var.resource_group_name
  location            = var.location
  name                = "scheduled-batch-azure"

  container_image = var.container_image

  subnet_id                         = module.network.subnet_id
  public_address_provisioning_type  = "NoPublicIPAddresses"
}
```

For no-public-IP pools, Azure Batch support depends on region, account settings, and simplified node communication requirements. NAT Gateway is useful when tasks still need outbound internet access, such as public container registries or external APIs.

## Private ACR

When `acr_id` is set and `create_pool_identity = true`, the Batch account/pool module grants `AcrPull` to the pool managed identity. If the registry or backing storage is locked down, also plan the network path with private endpoints, network rules, service endpoints, or NAT depending on your security model.

## Command Override

Set `enable_command_override_from_trigger_body = true` to allow the Logic App trigger body to override the default `container_command_line`.

Azure Batch task `commandLine` is a string, not a list. AWS and GCP modules often model commands as `list(string)`, but Azure sends one shell command line to the Batch task.

Manual trigger body example:

```json
{
  "commandLine": "/bin/sh -c \"echo manual Azure Batch run; date; env\""
}
```

If `commandLine` is not present in the trigger body, the workflow uses `container_command_line`.

Keep secrets out of trigger bodies and Terraform variable files. Use Azure Key Vault or another managed secret store for sensitive runtime values.
