provider "google" {
  project = var.project_id
  region  = var.region
}

module "project_services" {
  source = "../../../modules/gcp/project-services"

  project_id = var.project_id
}

module "scheduled_batch_job" {
  source = "../../../modules/gcp/scheduled-batch-job"

  project_id      = var.project_id
  region          = var.region
  name            = var.name
  container_image = var.container_image

  container_commands = ["sh", "-c", "echo Hello from Google Cloud Batch; date; env"]

  environment_variables = {
    APP_ENV   = "dev"
    LOG_LEVEL = "info"
  }

  schedule  = var.schedule
  time_zone = var.time_zone
  labels    = var.labels

  depends_on = [module.project_services]
}
