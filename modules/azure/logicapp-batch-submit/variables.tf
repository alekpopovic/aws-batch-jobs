variable "subscription_id" {
  description = "Azure subscription ID used to build ARM resource IDs."
  type        = string
}

variable "resource_group_name" {
  description = "Azure resource group name."
  type        = string
}

variable "location" {
  description = "Azure region for Logic Apps resources."
  type        = string
}

variable "name" {
  description = "Name prefix for the Logic Apps workflow."
  type        = string
}

variable "batch_account_id" {
  description = "Azure Batch account resource ID used as the RBAC scope."
  type        = string
}

variable "batch_account_name" {
  description = "Azure Batch account name targeted by the workflow."
  type        = string
}

variable "batch_account_endpoint" {
  description = "Azure Batch account endpoint host or URL."
  type        = string
}

variable "batch_pool_id" {
  description = "Azure Batch pool resource ID."
  type        = string
  default     = null
}

variable "batch_pool_name" {
  description = "Azure Batch pool name used by submitted jobs."
  type        = string
}

variable "container_image" {
  description = "Container image used by Azure Batch tasks."
  type        = string
}

variable "container_command_line" {
  description = "Default command line used by the Azure Batch task."
  type        = string
  default     = "/bin/sh -c \"echo Hello from Azure Batch; date; env\""
}

variable "environment_variables" {
  description = "Environment variables passed to the Azure Batch task."
  type        = map(string)
  default     = {}
}

variable "task_max_wall_clock_time" {
  description = "Maximum wall clock time for the Batch task."
  type        = string
  default     = "PT1H"
}

variable "task_retention_time" {
  description = "Retention time for the Batch task."
  type        = string
  default     = "P1D"
}

variable "task_retry_maximum" {
  description = "Maximum retry count for the Batch task."
  type        = number
  default     = 0
}

variable "poll_interval_seconds" {
  description = "Polling interval while waiting for the Batch task to complete."
  type        = number
  default     = 30
}

variable "max_poll_attempts" {
  description = "Maximum task polling attempts before failing the workflow."
  type        = number
  default     = 120
}

variable "delete_job_on_completion" {
  description = "Whether to delete the Batch job after task completion."
  type        = bool
  default     = false
}

variable "terminate_job_on_task_failure" {
  description = "Whether to terminate the Batch job when the task exits with a non-zero code."
  type        = bool
  default     = true
}

variable "batch_api_version" {
  description = "Azure Batch REST API version used by the Logic App."
  type        = string
  default     = "2025-06-01"
}

variable "batch_role_definition_name" {
  description = "Azure RBAC role assigned to the Logic App managed identity on the Batch account."
  type        = string
  default     = "Azure Batch Job Submitter"
}

variable "recurrence_frequency" {
  description = "Logic Apps recurrence frequency."
  type        = string
  default     = "Day"

  validation {
    condition     = contains(["Second", "Minute", "Hour", "Day", "Week", "Month"], var.recurrence_frequency)
    error_message = "recurrence_frequency must be Second, Minute, Hour, Day, Week, or Month."
  }
}

variable "recurrence_interval" {
  description = "Logic Apps recurrence interval."
  type        = number
  default     = 1
}

variable "recurrence_time_zone" {
  description = "Windows time zone ID used by Logic Apps recurrence. Europe/Belgrade is Central Europe Standard Time."
  type        = string
  default     = "Central Europe Standard Time"
}

variable "recurrence_hours" {
  description = "Hours used by daily or weekly recurrence schedules."
  type        = list(number)
  default     = [3]
}

variable "recurrence_minutes" {
  description = "Minutes used by recurrence schedules."
  type        = list(number)
  default     = [0]
}

variable "recurrence_week_days" {
  description = "Week days used by weekly recurrence schedules."
  type        = list(string)
  default     = []
}

variable "start_time" {
  description = "Optional Logic Apps recurrence start time."
  type        = string
  default     = null
}

variable "workflow_parameters" {
  description = "Additional Logic Apps workflow parameters. Values are exposed as Object parameters."
  type        = map(any)
  default     = {}
}

variable "enable_command_override_from_trigger_body" {
  description = "Whether triggerBody().commandLine can override container_command_line."
  type        = bool
  default     = false
}

variable "manual_trigger_body" {
  description = "Default object used by the workflow for manual command override testing."
  type        = any
  default     = {}
}

variable "tags" {
  description = "Tags applied to Azure resources that support tags."
  type        = map(string)
  default     = {}
}
