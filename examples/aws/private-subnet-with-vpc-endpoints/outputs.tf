output "state_machine_arn" {
  description = "ARN of the Step Functions state machine."
  value       = module.scheduled_batch_job.state_machine_arn
}

output "scheduler_schedule_arn" {
  description = "ARN of the EventBridge Scheduler schedule."
  value       = module.scheduled_batch_job.scheduler_schedule_arn
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

output "vpc_endpoint_ecr_api_id" {
  description = "ID of the ECR API interface VPC endpoint."
  value       = module.vpc_endpoints.ecr_api_endpoint_id
}

output "vpc_endpoint_ecr_dkr_id" {
  description = "ID of the ECR Docker interface VPC endpoint."
  value       = module.vpc_endpoints.ecr_dkr_endpoint_id
}

output "vpc_endpoint_logs_id" {
  description = "ID of the CloudWatch Logs interface VPC endpoint."
  value       = module.vpc_endpoints.logs_endpoint_id
}

output "vpc_endpoint_s3_id" {
  description = "ID of the S3 gateway VPC endpoint."
  value       = module.vpc_endpoints.s3_endpoint_id
}
