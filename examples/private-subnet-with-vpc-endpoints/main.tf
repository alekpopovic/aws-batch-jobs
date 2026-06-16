module "vpc_endpoints_fargate" {
  source = "../../modules/vpc-endpoints-fargate"

  name                       = var.name
  vpc_id                     = var.vpc_id
  subnet_ids                 = var.subnet_ids
  route_table_ids            = var.route_table_ids
  allowed_security_group_ids = [module.scheduled_batch_job.batch_security_group_id]
}

module "scheduled_batch_job" {
  source = "../../modules/scheduled-batch-job"

  name                = var.name
  schedule_expression = var.schedule_expression
  vpc_id              = var.vpc_id
  subnet_ids          = var.subnet_ids
  container_image     = var.container_image
}
