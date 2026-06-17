module "runtime_iam" {
  source = "../batch-runtime-iam"

  project_id               = var.project_id
  name                     = var.name
  runtime_roles            = var.runtime_roles
  additional_runtime_roles = var.additional_runtime_roles
  labels                   = local.labels
}

module "workflow" {
  source = "../workflows-batch-submit"

  project_id                        = var.project_id
  region                            = var.region
  name                              = var.name
  container_image                   = var.container_image
  container_commands                = var.container_commands
  environment_variables             = var.environment_variables
  task_count                        = var.task_count
  parallelism                       = var.parallelism
  cpu_milli                         = var.cpu_milli
  memory_mib                        = var.memory_mib
  max_retry_count                   = var.max_retry_count
  max_run_duration                  = var.max_run_duration
  machine_type                      = var.machine_type
  provisioning_model                = var.provisioning_model
  batch_service_account_email       = module.runtime_iam.service_account_email
  batch_service_account_id          = module.runtime_iam.service_account_id
  network                           = var.network
  subnetwork                        = var.subnetwork
  no_external_ip_address            = var.no_external_ip_address
  delete_job_on_completion          = var.delete_job_on_completion
  enable_command_override_from_args = var.enable_command_override_from_scheduler_argument
  workflow_labels                   = local.labels
  batch_labels                      = local.labels
}

module "scheduler" {
  source = "../cloud-scheduler-workflows"

  project_id        = var.project_id
  region            = local.scheduler_region
  name              = var.name
  workflow_name     = module.workflow.workflow_name
  workflow_region   = module.workflow.workflow_region
  schedule          = var.schedule
  time_zone         = var.time_zone
  workflow_argument = local.workflow_argument
  labels            = local.labels
}
