output "cloud_provider" {
  description = "Selected cloud provider."
  value       = var.cloud_provider
}

output "scheduler_identifier" {
  description = "Selected provider scheduler identifier."
  value       = local.is_aws ? try(module.aws[0].scheduler_schedule_arn, null) : try(module.gcp[0].scheduler_job_id, null)
}

output "orchestrator_identifier" {
  description = "Selected provider orchestrator identifier."
  value       = local.is_aws ? try(module.aws[0].state_machine_arn, null) : try(module.gcp[0].workflow_id, null)
}

output "batch_queue_or_runtime_identifier" {
  description = "AWS Batch queue ARN or GCP Batch runtime service account email."
  value       = local.is_aws ? try(module.aws[0].batch_job_queue_arn, null) : try(module.gcp[0].batch_runtime_service_account_email, null)
}

output "aws_batch_compute_environment_arn" {
  description = "AWS Batch Fargate compute environment ARN, or null when GCP is selected."
  value       = try(module.aws[0].batch_compute_environment_arn, null)
}

output "aws_batch_job_queue_arn" {
  description = "AWS Batch job queue ARN, or null when GCP is selected."
  value       = try(module.aws[0].batch_job_queue_arn, null)
}

output "aws_batch_job_definition_arn" {
  description = "AWS Batch job definition ARN, or null when GCP is selected."
  value       = try(module.aws[0].batch_job_definition_arn, null)
}

output "aws_state_machine_arn" {
  description = "AWS Step Functions state machine ARN, or null when GCP is selected."
  value       = try(module.aws[0].state_machine_arn, null)
}

output "aws_scheduler_schedule_arn" {
  description = "AWS EventBridge Scheduler schedule ARN, or null when GCP is selected."
  value       = try(module.aws[0].scheduler_schedule_arn, null)
}

output "aws_batch_log_group_name" {
  description = "AWS Batch CloudWatch log group name, or null when GCP is selected."
  value       = try(module.aws[0].batch_log_group_name, null)
}

output "gcp_batch_runtime_service_account_email" {
  description = "GCP Batch runtime service account email, or null when AWS is selected."
  value       = try(module.gcp[0].batch_runtime_service_account_email, null)
}

output "gcp_workflow_name" {
  description = "GCP Workflows workflow name, or null when AWS is selected."
  value       = try(module.gcp[0].workflow_name, null)
}

output "gcp_workflow_id" {
  description = "GCP Workflows workflow ID, or null when AWS is selected."
  value       = try(module.gcp[0].workflow_id, null)
}

output "gcp_scheduler_job_name" {
  description = "GCP Cloud Scheduler job name, or null when AWS is selected."
  value       = try(module.gcp[0].scheduler_job_name, null)
}

output "gcp_scheduler_job_id" {
  description = "GCP Cloud Scheduler job ID, or null when AWS is selected."
  value       = try(module.gcp[0].scheduler_job_id, null)
}

output "gcp_workflow_executions_uri" {
  description = "GCP Workflows executions URI, or null when AWS is selected."
  value       = try(module.gcp[0].workflow_executions_uri, null)
}
