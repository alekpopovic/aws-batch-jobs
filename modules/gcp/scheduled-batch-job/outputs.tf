output "batch_runtime_service_account_email" {
  description = "Email of the service account used by Cloud Batch runtime VMs."
  value       = module.runtime_iam.service_account_email
}

output "workflow_name" {
  description = "Name of the Google Workflows workflow."
  value       = module.workflow.workflow_name
}

output "workflow_id" {
  description = "Full Workflow resource ID."
  value       = module.workflow.workflow_id
}

output "workflow_region" {
  description = "Region where the Workflow is deployed."
  value       = module.workflow.workflow_region
}

output "workflow_service_account_email" {
  description = "Email of the service account used by Workflows."
  value       = module.workflow.workflow_service_account_email
}

output "scheduler_job_name" {
  description = "Cloud Scheduler job name."
  value       = module.scheduler.scheduler_job_name
}

output "scheduler_job_id" {
  description = "Full Cloud Scheduler job resource ID."
  value       = module.scheduler.scheduler_job_id
}

output "scheduler_service_account_email" {
  description = "Email of the service account used by Cloud Scheduler."
  value       = module.scheduler.scheduler_service_account_email
}

output "workflow_executions_uri" {
  description = "Workflow executions API URI used by the Scheduler HTTP target."
  value       = module.scheduler.workflow_executions_uri
}
