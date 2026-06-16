variable "name" {
  description = "Name prefix for the scheduled AWS Batch job."
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

variable "schedule_group_name" {
  description = "EventBridge Scheduler schedule group name."
  type        = string
  default     = "default"
}

variable "scheduler_target_input" {
  description = "JSON-serializable input passed from EventBridge Scheduler to Step Functions."
  type        = any
  default = {
    source = "eventbridge-scheduler"
  }
}

variable "enable_command_override_from_scheduler_input" {
  description = "Whether Step Functions should read ContainerOverrides Command from scheduler input key command."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags applied to resources that support tags."
  type        = map(string)
  default     = {}
}
