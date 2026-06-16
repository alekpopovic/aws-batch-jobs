variable "aws_region" {
  description = "AWS region for the example."
  type        = string
}

variable "name" {
  description = "Name prefix for the scheduled AWS Batch job."
  type        = string
}

variable "schedule_expression" {
  description = "EventBridge Scheduler expression."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where AWS Batch Fargate resources will run."
  type        = string
}

variable "subnet_ids" {
  description = "Subnet IDs where AWS Batch Fargate jobs will run."
  type        = list(string)
}

variable "container_image" {
  description = "Container image used by the AWS Batch job definition."
  type        = string
}
