variable "project_id" {
  description = "GCP project ID for the example."
  type        = string
}

variable "region" {
  description = "GCP region for Workflows, Cloud Scheduler, and Batch."
  type        = string
  default     = "europe-west1"
}

variable "name" {
  description = "Name prefix for the scheduled GCP Batch job."
  type        = string
  default     = "scheduled-batch-gcp-basic"
}

variable "container_image" {
  description = "Container image URI used by the Cloud Batch job."
  type        = string
}

variable "schedule" {
  description = "Cloud Scheduler unix cron schedule."
  type        = string
  default     = "0 3 * * *"
}

variable "time_zone" {
  description = "Time zone used by Cloud Scheduler."
  type        = string
  default     = "Europe/Belgrade"
}

variable "labels" {
  description = "Labels applied to resources that support labels."
  type        = map(string)
  default     = {}
}
