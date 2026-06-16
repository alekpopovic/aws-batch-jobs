variable "name" {
  description = "Name of the EventBridge Scheduler schedule."
  type        = string
}

variable "state_machine_arn" {
  description = "ARN of the Step Functions state machine to invoke."
  type        = string
}

variable "schedule_expression" {
  description = "EventBridge Scheduler expression, for example rate(1 day) or cron(...)."
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

variable "target_input" {
  description = "JSON-serializable input passed to the Step Functions state machine execution."
  type        = any
  default     = {}
}

variable "maximum_retry_attempts" {
  description = "Maximum number of retry attempts for failed target invocations."
  type        = number
  default     = 2
}

variable "maximum_event_age_in_seconds" {
  description = "Maximum event age, in seconds, for retrying failed target invocations."
  type        = number
  default     = 3600
}

variable "tags" {
  description = "Tags applied to resources that support tags."
  type        = map(string)
  default     = {}
}
