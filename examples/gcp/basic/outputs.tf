output "workflow_name" {
  description = "Name of the Google Workflows workflow."
  value       = module.scheduled_batch_job.workflow_name
}

output "workflow_id" {
  description = "Full Workflow resource ID."
  value       = module.scheduled_batch_job.workflow_id
}

output "scheduler_job_name" {
  description = "Cloud Scheduler job name."
  value       = module.scheduled_batch_job.scheduler_job_name
}

output "scheduler_job_id" {
  description = "Full Cloud Scheduler job resource ID."
  value       = module.scheduled_batch_job.scheduler_job_id
}

output "workflow_executions_uri" {
  description = "Workflow executions API URI used by the Scheduler HTTP target."
  value       = module.scheduled_batch_job.workflow_executions_uri
}

output "batch_runtime_service_account_email" {
  description = "Email of the service account used by Cloud Batch runtime VMs."
  value       = module.scheduled_batch_job.batch_runtime_service_account_email
}
