module "batch" {
  source = "../batch-account-pool"

  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location

  storage_account_name = var.storage_account_name
  batch_account_name   = var.batch_account_name
  pool_name            = var.pool_name

  vm_size                   = var.vm_size
  node_agent_sku_id         = var.node_agent_sku_id
  storage_image_reference   = var.storage_image_reference
  target_dedicated_nodes    = var.target_dedicated_nodes
  target_low_priority_nodes = var.target_low_priority_nodes
  max_tasks_per_node        = var.max_tasks_per_node

  container_image         = var.container_image
  preload_container_image = var.preload_container_image
  create_pool_identity    = var.create_pool_identity
  acr_id                  = var.acr_id

  subnet_id                        = var.subnet_id
  public_address_provisioning_type = var.public_address_provisioning_type

  tags = local.tags
}

module "logic_app" {
  source = "../logicapp-batch-submit"

  subscription_id     = var.subscription_id
  resource_group_name = var.resource_group_name
  location            = var.location
  name                = var.name

  batch_account_id       = module.batch.batch_account_id
  batch_account_name     = module.batch.batch_account_name
  batch_account_endpoint = module.batch.batch_account_endpoint
  batch_pool_id          = module.batch.batch_pool_id
  batch_pool_name        = module.batch.batch_pool_name

  container_image        = var.container_image
  container_command_line = var.container_command_line
  environment_variables  = var.environment_variables

  recurrence_frequency = var.recurrence_frequency
  recurrence_interval  = var.recurrence_interval
  recurrence_time_zone = var.recurrence_time_zone
  recurrence_hours     = var.recurrence_hours
  recurrence_minutes   = var.recurrence_minutes
  recurrence_week_days = var.recurrence_week_days
  start_time           = var.start_time

  task_max_wall_clock_time = var.task_max_wall_clock_time
  task_retention_time      = var.task_retention_time
  task_retry_maximum       = var.task_retry_maximum
  poll_interval_seconds    = var.poll_interval_seconds
  max_poll_attempts        = var.max_poll_attempts

  delete_job_on_completion                  = var.delete_job_on_completion
  terminate_job_on_task_failure             = var.terminate_job_on_task_failure
  batch_role_definition_name                = var.batch_role_definition_name
  enable_command_override_from_trigger_body = var.enable_command_override_from_trigger_body

  tags = local.tags
}
