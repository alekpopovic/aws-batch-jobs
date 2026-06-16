variable "name" {
  description = "Name prefix for AWS Batch Fargate resources."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the AWS Batch Fargate security group will be created."
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

variable "container_command" {
  description = "Command executed by the AWS Batch container."
  type        = list(string)
  default     = ["sh", "-c", "echo 'Hello from AWS Batch'; date"]
}

variable "environment_variables" {
  description = "Environment variables passed to the AWS Batch container."
  type        = map(string)
  default     = {}
}

variable "max_vcpus" {
  description = "Maximum vCPUs for the managed AWS Batch Fargate compute environment."
  type        = number
  default     = 4
}

variable "job_vcpu" {
  description = "vCPU value requested by the AWS Batch job definition."
  type        = string
  default     = "0.25"
}

variable "job_memory" {
  description = "Memory value in MiB requested by the AWS Batch job definition."
  type        = string
  default     = "512"
}

variable "assign_public_ip" {
  description = "Whether AWS Batch Fargate jobs should receive a public IP address."
  type        = bool
  default     = false
}

variable "log_retention_in_days" {
  description = "CloudWatch Log Group retention period in days."
  type        = number
  default     = 14
}

variable "tags" {
  description = "Tags applied to resources that support tags."
  type        = map(string)
  default     = {}
}
