resource "terraform_data" "validate_aws_config" {
  count = local.is_aws ? 1 : 0

  lifecycle {
    precondition {
      condition = (
        try(var.aws_config.vpc_id, "") != "" &&
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
      condition     = try(var.gcp_config.project_id, "") != ""
      error_message = "cloud_provider=\"gcp\" zahteva gcp_config.project_id."
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
