provider "google" {
  project = var.project_id
  region  = var.region
}

module "project_services" {
  source = "../../../modules/gcp/project-services"

  project_id = var.project_id
}

module "network" {
  source = "../../../modules/gcp/batch-private-network"

  project_id       = var.project_id
  region           = var.region
  name             = var.name
  ip_cidr_range    = var.ip_cidr_range
  create_cloud_nat = var.create_cloud_nat

  depends_on = [module.project_services]
}

module "scheduled_batch_job" {
  source = "../../../modules/gcp/scheduled-batch-job"

  project_id      = var.project_id
  region          = var.region
  name            = var.name
  container_image = var.container_image

  container_commands = ["sh", "-c", "echo Private Google Access Batch job; date; env"]

  environment_variables = {
    APP_ENV   = "dev"
    LOG_LEVEL = "info"
  }

  network                = module.network.network_self_link
  subnetwork             = module.network.subnetwork_self_link
  no_external_ip_address = true

  schedule  = var.schedule
  time_zone = var.time_zone
  labels    = var.labels

  depends_on = [
    module.project_services,
    module.network,
  ]
}
