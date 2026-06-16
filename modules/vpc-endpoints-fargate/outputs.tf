output "ecr_api_endpoint_id" {
  description = "ID of the ECR API interface VPC endpoint."
  value       = var.create ? aws_vpc_endpoint.ecr_api[0].id : null
}

output "ecr_dkr_endpoint_id" {
  description = "ID of the ECR Docker interface VPC endpoint."
  value       = var.create ? aws_vpc_endpoint.ecr_dkr[0].id : null
}

output "logs_endpoint_id" {
  description = "ID of the CloudWatch Logs interface VPC endpoint."
  value       = var.create ? aws_vpc_endpoint.logs[0].id : null
}

output "s3_endpoint_id" {
  description = "ID of the S3 gateway VPC endpoint."
  value       = var.create ? aws_vpc_endpoint.s3[0].id : null
}

output "security_group_id" {
  description = "ID of the security group attached to interface VPC endpoints."
  value       = var.create ? aws_security_group.endpoints[0].id : null
}
