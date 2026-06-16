provider "aws" {
  region = var.aws_region
}

module "scheduled_batch_job" {
  source = "../../modules/scheduled-batch-job"

  name                = var.name
  schedule_expression = var.schedule_expression
  schedule_timezone   = var.schedule_timezone
  vpc_id              = var.vpc_id
  subnet_ids          = var.subnet_ids
  container_image     = var.container_image
  assign_public_ip    = false

  environment_variables = {
    APP_ENV   = "prod"
    LOG_LEVEL = "info"
  }

  tags = var.tags
}

module "vpc_endpoints" {
  source = "../../modules/vpc-endpoints-fargate"

  name                       = var.name
  vpc_id                     = var.vpc_id
  subnet_ids                 = var.subnet_ids
  route_table_ids            = var.route_table_ids
  allowed_security_group_ids = [module.scheduled_batch_job.batch_security_group_id]
  create                     = true
  tags                       = var.tags
}
