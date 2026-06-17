output "workflow_name" {
  description = "Name of the Google Workflows workflow."
  value       = module.scheduled_batch_job.workflow_name
}

output "scheduler_job_name" {
  description = "Name of the Cloud Scheduler job."
  value       = module.scheduled_batch_job.scheduler_job_name
}

output "network" {
  description = "Network used by GCP Batch jobs."
  value       = module.private_network.network
}

output "subnetwork" {
  description = "Subnetwork used by GCP Batch jobs."
  value       = module.private_network.subnetwork
}
