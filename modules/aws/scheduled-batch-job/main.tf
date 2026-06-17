module "batch" {
  source = "../batch-fargate"

  name                  = var.name
  vpc_id                = var.vpc_id
  subnet_ids            = var.subnet_ids
  container_image       = var.container_image
  container_command     = var.container_command
  environment_variables = var.environment_variables
  max_vcpus             = var.max_vcpus
  job_vcpu              = var.job_vcpu
  job_memory            = var.job_memory
  assign_public_ip      = var.assign_public_ip
  log_retention_in_days = var.log_retention_in_days
  tags                  = local.tags
}

module "state_machine" {
  source = "../stepfunctions-batch-submit"

  name               = var.name
  job_queue_arn      = module.batch.job_queue_arn
  job_definition_arn = module.batch.job_definition_arn
  batch_job_name     = "${var.name}-job"
  command_json_path  = local.command_json_path

  container_environment_overrides = {
    TRIGGER_SOURCE = "eventbridge-scheduler"
  }

  tags = local.tags
}

module "scheduler" {
  source = "../eventbridge-scheduler-sfn"

  name                = var.name
  state_machine_arn   = module.state_machine.state_machine_arn
  schedule_expression = var.schedule_expression
  schedule_timezone   = var.schedule_timezone
  schedule_group_name = var.schedule_group_name
  target_input        = local.scheduler_target_input
  tags                = local.tags
}
