resource "terraform_data" "validate_aws_config" {
  count = local.is_aws ? 1 : 0

  lifecycle {
    precondition {
      condition = (
        coalesce(try(var.aws_config.vpc_id, null), "") != "" &&
        length(try(var.aws_config.subnet_ids, [])) > 0
      )
      error_message = "cloud_provider=\"aws\" zahteva aws_config.vpc_id i aws_config.subnet_ids."
    }
  }
}

resource "terraform_data" "validate_gcp_config" {
  count = local.is_gcp ? 1 : 0

  lifecycle {
    precondition {
      condition     = coalesce(try(var.gcp_config.project_id, null), "") != ""
      error_message = "cloud_provider=\"gcp\" zahteva gcp_config.project_id."
    }
  }
}

resource "terraform_data" "validate_azure_config" {
  count = local.is_azure ? 1 : 0

  lifecycle {
    precondition {
      condition = (
        coalesce(try(var.azure_config.subscription_id, null), "") != "" &&
        coalesce(try(var.azure_config.resource_group_name, null), "") != "" &&
        (
          try(var.azure_config.public_address_provisioning_type, "BatchManaged") != "NoPublicIPAddresses" ||
          coalesce(try(var.azure_config.subnet_id, null), "") != ""
        )
      )
      error_message = "cloud_provider=\"azure\" zahteva azure_config.subscription_id i azure_config.resource_group_name. Ako je public_address_provisioning_type=\"NoPublicIPAddresses\", potreban je i azure_config.subnet_id."
    }
  }
}

module "aws" {
  source = "../../aws/scheduled-batch-job"
  count  = local.is_aws ? 1 : 0

  name                                         = var.name
  vpc_id                                       = try(var.aws_config.vpc_id, "")
  subnet_ids                                   = try(var.aws_config.subnet_ids, [])
  container_image                              = var.container_image
  container_command                            = var.container_command
  environment_variables                        = var.environment_variables
  max_vcpus                                    = try(var.aws_config.max_vcpus, 4)
  job_vcpu                                     = try(var.aws_config.job_vcpu, "0.25")
  job_memory                                   = try(var.aws_config.job_memory, "512")
  assign_public_ip                             = try(var.aws_config.assign_public_ip, false)
  log_retention_in_days                        = try(var.aws_config.log_retention_in_days, 14)
  schedule_expression                          = local.aws_schedule_expression
  schedule_timezone                            = var.schedule_timezone
  schedule_group_name                          = try(var.aws_config.schedule_group_name, "default")
  scheduler_target_input                       = local.common_input
  enable_command_override_from_scheduler_input = var.enable_command_override_from_scheduler_input
  tags                                         = var.tags

  depends_on = [terraform_data.validate_aws_config]
}

module "gcp" {
  source = "../../gcp/scheduled-batch-job"
  count  = local.is_gcp ? 1 : 0

  project_id                                      = try(var.gcp_config.project_id, "")
  region                                          = try(var.gcp_config.region, "europe-west1")
  name                                            = var.name
  container_image                                 = var.container_image
  container_commands                              = var.container_command
  environment_variables                           = var.environment_variables
  task_count                                      = try(var.gcp_config.task_count, 1)
  parallelism                                     = try(var.gcp_config.parallelism, 1)
  cpu_milli                                       = try(var.gcp_config.cpu_milli, 1000)
  memory_mib                                      = try(var.gcp_config.memory_mib, 512)
  max_retry_count                                 = try(var.gcp_config.max_retry_count, 0)
  max_run_duration                                = try(var.gcp_config.max_run_duration, "3600s")
  machine_type                                    = try(var.gcp_config.machine_type, "e2-standard-2")
  provisioning_model                              = try(var.gcp_config.provisioning_model, "STANDARD")
  network                                         = try(var.gcp_config.network, null)
  subnetwork                                      = try(var.gcp_config.subnetwork, null)
  no_external_ip_address                          = try(var.gcp_config.no_external_ip_address, false)
  delete_job_on_completion                        = try(var.gcp_config.delete_job_on_completion, false)
  schedule                                        = local.gcp_schedule
  time_zone                                       = var.schedule_timezone
  scheduler_region                                = try(var.gcp_config.scheduler_region, null)
  scheduler_workflow_argument                     = local.common_input
  enable_command_override_from_scheduler_argument = var.enable_command_override_from_scheduler_input
  runtime_roles                                   = try(var.gcp_config.runtime_roles, ["roles/logging.logWriter", "roles/artifactregistry.reader"])
  additional_runtime_roles                        = try(var.gcp_config.additional_runtime_roles, [])
  labels                                          = local.gcp_labels

  depends_on = [terraform_data.validate_gcp_config]
}

module "azure" {
  source = "../../azure/scheduled-batch-job"
  count  = local.is_azure ? 1 : 0

  subscription_id     = try(var.azure_config.subscription_id, "")
  resource_group_name = try(var.azure_config.resource_group_name, "")
  location            = try(var.azure_config.location, "westeurope")

  name                   = var.name
  container_image        = var.container_image
  container_command_line = local.azure_command_line
  environment_variables  = var.environment_variables

  storage_account_name = try(var.azure_config.storage_account_name, null)
  batch_account_name   = try(var.azure_config.batch_account_name, null)
  pool_name            = try(var.azure_config.pool_name, null)

  vm_size                   = try(var.azure_config.vm_size, "STANDARD_D2S_V3")
  node_agent_sku_id         = try(var.azure_config.node_agent_sku_id, "batch.node.ubuntu 20.04")
  target_dedicated_nodes    = try(var.azure_config.target_dedicated_nodes, 0)
  target_low_priority_nodes = try(var.azure_config.target_low_priority_nodes, 1)
  max_tasks_per_node        = try(var.azure_config.max_tasks_per_node, 1)

  preload_container_image = try(var.azure_config.preload_container_image, true)
  create_pool_identity    = try(var.azure_config.create_pool_identity, true)
  acr_id                  = try(var.azure_config.acr_id, null)

  subnet_id                        = try(var.azure_config.subnet_id, null)
  public_address_provisioning_type = try(var.azure_config.public_address_provisioning_type, "BatchManaged")

  recurrence_frequency = try(var.azure_config.recurrence_frequency, "Day")
  recurrence_interval  = try(var.azure_config.recurrence_interval, 1)
  recurrence_time_zone = try(var.azure_config.recurrence_time_zone, "Central Europe Standard Time")
  recurrence_hours     = try(var.azure_config.recurrence_hours, [3])
  recurrence_minutes   = try(var.azure_config.recurrence_minutes, [0])
  recurrence_week_days = try(var.azure_config.recurrence_week_days, [])
  start_time           = try(var.azure_config.start_time, null)

  task_max_wall_clock_time = try(var.azure_config.task_max_wall_clock_time, "PT1H")
  task_retention_time      = try(var.azure_config.task_retention_time, "P1D")
  task_retry_maximum       = try(var.azure_config.task_retry_maximum, 0)
  poll_interval_seconds    = try(var.azure_config.poll_interval_seconds, 30)
  max_poll_attempts        = try(var.azure_config.max_poll_attempts, 120)

  delete_job_on_completion      = try(var.azure_config.delete_job_on_completion, false)
  terminate_job_on_task_failure = try(var.azure_config.terminate_job_on_task_failure, true)
  batch_role_definition_name    = try(var.azure_config.batch_role_definition_name, "Azure Batch Job Submitter")

  enable_command_override_from_trigger_body = var.enable_command_override_from_scheduler_input

  tags = local.azure_tags

  depends_on = [terraform_data.validate_azure_config]
}
