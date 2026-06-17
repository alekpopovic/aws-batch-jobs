module "scheduled_batch_job" {
  source = "../../modules/multicloud/scheduled-batch-job"

  provider_name = var.provider_name
  name          = var.name
}
