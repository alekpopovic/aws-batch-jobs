variable "project_id" {
  description = "GCP project ID for the scheduled Batch job."
  type        = string
}

variable "region" {
  description = "GCP region for Workflows and Cloud Batch."
  type        = string
}

variable "name" {
  description = "Name prefix for the scheduled GCP Batch job."
  type        = string
}

variable "container_image" {
  description = "Container image URI used by the Cloud Batch job."
  type        = string
}

variable "container_commands" {
  description = "Default container command list used by the Cloud Batch job."
  type        = list(string)
  default     = []
}

variable "environment_variables" {
  description = "Environment variables passed to the Batch runnable."
  type        = map(string)
  default     = {}
}

variable "task_count" {
  description = "Number of Batch tasks to run."
  type        = number
  default     = 1
}

variable "parallelism" {
  description = "Maximum number of tasks to run in parallel."
  type        = number
  default     = 1
}

variable "cpu_milli" {
  description = "CPU request in milli CPU units."
  type        = number
  default     = 1000
}

variable "memory_mib" {
  description = "Memory request in MiB."
  type        = number
  default     = 512
}

variable "max_retry_count" {
  description = "Maximum retry count for the Batch task."
  type        = number
  default     = 0
}

variable "max_run_duration" {
  description = "Maximum task run duration, for example 3600s."
  type        = string
  default     = "3600s"
}

variable "machine_type" {
  description = "Compute Engine machine type used by Batch."
  type        = string
  default     = "e2-standard-2"
}

variable "provisioning_model" {
  description = "Provisioning model for Batch VMs."
  type        = string
  default     = "STANDARD"

  validation {
    condition     = contains(["STANDARD", "SPOT"], var.provisioning_model)
    error_message = "provisioning_model must be STANDARD or SPOT."
  }
}

variable "network" {
  description = "Optional VPC network self link or resource name for Batch jobs."
  type        = string
  default     = null
}

variable "subnetwork" {
  description = "Optional subnetwork self link or resource name for Batch jobs."
  type        = string
  default     = null
}

variable "no_external_ip_address" {
  description = "Whether Batch VMs should run without external IP addresses."
  type        = bool
  default     = false
}

variable "delete_job_on_completion" {
  description = "Whether the workflow deletes the Batch job after a successful create call returns."
  type        = bool
  default     = false
}

variable "schedule" {
  description = "Cloud Scheduler cron schedule."
  type        = string
  default     = "0 3 * * *"
}

variable "time_zone" {
  description = "Time zone used by Cloud Scheduler."
  type        = string
  default     = "Europe/Belgrade"
}

variable "scheduler_region" {
  description = "Cloud Scheduler region. Defaults to region when null."
  type        = string
  default     = null
}

variable "scheduler_workflow_argument" {
  description = "Object passed to the Workflows execution argument field."
  type        = any
  default = {
    source = "cloud-scheduler"
  }
}

variable "enable_command_override_from_scheduler_argument" {
  description = "When true, scheduler_workflow_argument.command overrides the default container command."
  type        = bool
  default     = false
}

variable "runtime_roles" {
  description = "Base IAM roles granted to the GCP Batch runtime service account."
  type        = set(string)
  default = [
    "roles/logging.logWriter",
    "roles/artifactregistry.reader"
  ]
}

variable "additional_runtime_roles" {
  description = "Additional least-privilege IAM roles granted to the GCP Batch runtime service account."
  type        = set(string)
  default     = []
}

variable "labels" {
  description = "Labels applied to resources that support labels."
  type        = map(string)
  default     = {}
}
