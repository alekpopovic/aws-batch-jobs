module "scheduled_batch_job" {
  source = "../../modules/scheduled-batch-job"

  name                = var.name
  schedule_expression = var.schedule_expression
  vpc_id              = var.vpc_id
  subnet_ids          = var.subnet_ids
  container_image     = var.container_image
}
