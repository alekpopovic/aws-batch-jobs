locals {
  scheduler_region = var.scheduler_region != null ? var.scheduler_region : var.region

  labels = merge(var.labels, {
    managed_by = "terraform"
    module     = "scheduled-batch-job"
  })

  workflow_argument = merge(
    {
      source = "cloud-scheduler"
      name   = var.name
    },
    var.scheduler_workflow_argument
  )
}
