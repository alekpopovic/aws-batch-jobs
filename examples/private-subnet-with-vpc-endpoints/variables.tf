variable "aws_region" {
  description = "AWS region for the example."
  type        = string
}

variable "name" {
  description = "Name prefix for the scheduled AWS Batch job."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where endpoints will be created."
  type        = string
}

variable "schedule_expression" {
  description = "EventBridge Scheduler expression."
  type        = string
}

variable "subnet_ids" {
  description = "Private subnet IDs where AWS Batch Fargate jobs will run."
  type        = list(string)
}

variable "route_table_ids" {
  description = "Route table IDs associated with the private subnets for the S3 gateway endpoint."
  type        = list(string)
}

variable "security_group_ids" {
  description = "Security group IDs attached to AWS Batch Fargate jobs and VPC endpoints."
  type        = list(string)
}

variable "container_image" {
  description = "Container image used by the AWS Batch job definition."
  type        = string
}
