output "compute_environment_arn" {
  description = "ARN of the AWS Batch Fargate compute environment."
  value       = aws_batch_compute_environment.fargate.arn
}

output "job_queue_arn" {
  description = "ARN of the AWS Batch job queue."
  value       = aws_batch_job_queue.this.arn
}

output "job_definition_arn" {
  description = "ARN of the AWS Batch job definition."
  value       = aws_batch_job_definition.this.arn
}

output "job_role_arn" {
  description = "ARN of the IAM role assumed by the running AWS Batch job container."
  value       = aws_iam_role.batch_job.arn
}

output "execution_role_arn" {
  description = "ARN of the ECS task execution role used to pull images and write logs."
  value       = aws_iam_role.batch_execution.arn
}

output "log_group_name" {
  description = "Name of the CloudWatch Log Group used by AWS Batch jobs."
  value       = aws_cloudwatch_log_group.batch.name
}

output "security_group_id" {
  description = "ID of the security group attached to AWS Batch Fargate jobs."
  value       = aws_security_group.batch.id
}
