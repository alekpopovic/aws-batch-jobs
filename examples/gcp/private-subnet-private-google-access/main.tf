provider "google" {
  project = var.project_id
  region  = var.region
}

module "private_network" {
  source = "../../../modules/gcp/batch-private-network"

  project_id = var.project_id
  network    = var.network
  subnetwork = var.subnetwork
  labels     = var.labels
}

module "scheduled_batch_job" {
  source = "../../../modules/gcp/scheduled-batch-job"

  project_id = var.project_id
  name       = var.name
  region     = var.region
  labels     = var.labels
}
