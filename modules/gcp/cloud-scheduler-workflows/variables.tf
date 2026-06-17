variable "project_id" {
  description = "GCP project ID where Cloud Scheduler will be created."
  type        = string
}

variable "name" {
  description = "Name prefix for the Cloud Scheduler job."
  type        = string
}

variable "region" {
  description = "GCP region for Cloud Scheduler."
  type        = string
}

variable "workflow_name" {
  description = "Name of the target Google Workflows workflow."
  type        = string
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

variable "labels" {
  description = "Labels applied to resources that support labels."
  type        = map(string)
  default     = {}
}
