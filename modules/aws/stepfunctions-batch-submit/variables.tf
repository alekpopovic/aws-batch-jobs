variable "name" {
  description = "Name of the Step Functions state machine."
  type        = string
}

variable "job_queue_arn" {
  description = "ARN of the AWS Batch job queue."
  type        = string
}

variable "job_definition_arn" {
  description = "ARN of the AWS Batch job definition."
  type        = string
}

variable "batch_job_name" {
  description = "Name to use when submitting AWS Batch jobs. Defaults to <name>-job."
  type        = string
  default     = null
}

variable "container_environment_overrides" {
  description = "Environment variables passed to the submitted AWS Batch job as container overrides."
  type        = map(string)
  default = {
    TRIGGER_SOURCE = "eventbridge-scheduler"
  }
}

variable "command_json_path" {
  description = "Optional JSONPath used to set ContainerOverrides Command.$, for example $.command."
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags applied to resources that support tags."
  type        = map(string)
  default     = {}
}
