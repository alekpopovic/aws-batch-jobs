variable "aws_region" {
  description = "AWS region for the example."
  type        = string
  default     = "eu-central-1"
}

variable "name" {
  description = "Name prefix for the scheduled AWS Batch job."
  type        = string
  default     = "multicloud-scheduled-jobs-aws-private"
}

variable "vpc_id" {
  description = "VPC ID where AWS Batch Fargate resources and endpoints will be created."
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

variable "container_image" {
  description = "Container image used by the AWS Batch job definition."
  type        = string
}

variable "schedule_expression" {
  description = "EventBridge Scheduler expression."
  type        = string
  default     = "cron(0 3 * * ? *)"
}

variable "schedule_timezone" {
  description = "Timezone used to evaluate the schedule expression."
  type        = string
  default     = "Europe/Belgrade"
}

variable "tags" {
  description = "Tags applied to resources created by the modules."
  type        = map(string)
  default     = {}
}
