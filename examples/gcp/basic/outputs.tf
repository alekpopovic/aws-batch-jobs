output "workflow_name" {
  description = "Name of the Google Workflows workflow."
  value       = module.scheduled_batch_job.workflow_name
}

output "scheduler_job_name" {
  description = "Name of the Cloud Scheduler job."
  value       = module.scheduled_batch_job.scheduler_job_name
}
