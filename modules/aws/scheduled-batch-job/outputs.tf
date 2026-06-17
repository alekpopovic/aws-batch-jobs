output "batch_compute_environment_arn" {
  description = "ARN of the AWS Batch Fargate compute environment."
  value       = module.batch.compute_environment_arn
}

output "batch_job_queue_arn" {
  description = "ARN of the AWS Batch job queue."
  value       = module.batch.job_queue_arn
}

output "batch_job_definition_arn" {
  description = "ARN of the AWS Batch job definition."
  value       = module.batch.job_definition_arn
}

output "batch_job_role_arn" {
  description = "ARN of the IAM role assumed by the running AWS Batch job container."
  value       = module.batch.job_role_arn
}

output "batch_execution_role_arn" {
  description = "ARN of the ECS task execution role used to pull images and write logs."
  value       = module.batch.execution_role_arn
}

output "batch_log_group_name" {
  description = "Name of the CloudWatch Log Group used by AWS Batch jobs."
  value       = module.batch.log_group_name
}

output "batch_security_group_id" {
  description = "ID of the security group attached to AWS Batch Fargate jobs."
  value       = module.batch.security_group_id
}

output "state_machine_arn" {
  description = "ARN of the Step Functions state machine."
  value       = module.state_machine.state_machine_arn
}

output "scheduler_schedule_arn" {
  description = "ARN of the EventBridge Scheduler schedule."
  value       = module.scheduler.schedule_arn
}
