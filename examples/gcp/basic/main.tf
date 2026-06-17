provider "google" {
  project = var.project_id
  region  = var.region
}

module "scheduled_batch_job" {
  source = "../../../modules/gcp/scheduled-batch-job"

  project_id = var.project_id
  name       = var.name
  region     = var.region
  labels     = var.labels
}
