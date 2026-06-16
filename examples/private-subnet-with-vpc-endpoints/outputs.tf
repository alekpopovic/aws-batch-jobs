output "ecr_api_endpoint_id" {
  description = "ID of the ECR API interface VPC endpoint."
  value       = module.vpc_endpoints_fargate.ecr_api_endpoint_id
}

output "ecr_dkr_endpoint_id" {
  description = "ID of the ECR Docker interface VPC endpoint."
  value       = module.vpc_endpoints_fargate.ecr_dkr_endpoint_id
}

output "logs_endpoint_id" {
  description = "ID of the CloudWatch Logs interface VPC endpoint."
  value       = module.vpc_endpoints_fargate.logs_endpoint_id
}

output "s3_endpoint_id" {
  description = "ID of the S3 gateway VPC endpoint."
  value       = module.vpc_endpoints_fargate.s3_endpoint_id
}

output "vpc_endpoint_security_group_id" {
  description = "ID of the security group attached to interface VPC endpoints."
  value       = module.vpc_endpoints_fargate.security_group_id
}

output "job_queue_arn" {
  description = "ARN of the AWS Batch job queue."
  value       = module.scheduled_batch_job.job_queue_arn
}

output "job_definition_arn" {
  description = "ARN of the AWS Batch job definition."
  value       = module.scheduled_batch_job.job_definition_arn
}

output "state_machine_arn" {
  description = "ARN of the Step Functions state machine."
  value       = module.scheduled_batch_job.state_machine_arn
}

output "schedule_arn" {
  description = "ARN of the EventBridge Scheduler schedule."
  value       = module.scheduled_batch_job.schedule_arn
}
