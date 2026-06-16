output "batch_compute_environment_arn" {
  description = "ARN of the AWS Batch Fargate compute environment."
  value       = module.scheduled_batch_job.batch_compute_environment_arn
}

output "batch_job_queue_arn" {
  description = "ARN of the AWS Batch job queue."
  value       = module.scheduled_batch_job.batch_job_queue_arn
}

output "batch_job_definition_arn" {
  description = "ARN of the AWS Batch job definition."
  value       = module.scheduled_batch_job.batch_job_definition_arn
}

output "batch_security_group_id" {
  description = "ID of the security group attached to AWS Batch Fargate jobs."
  value       = module.scheduled_batch_job.batch_security_group_id
}

output "state_machine_arn" {
  description = "ARN of the Step Functions state machine."
  value       = module.scheduled_batch_job.state_machine_arn
}

output "scheduler_schedule_arn" {
  description = "ARN of the EventBridge Scheduler schedule."
  value       = module.scheduled_batch_job.scheduler_schedule_arn
}
