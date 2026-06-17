variable "project_id" {
  description = "GCP project ID for the scheduled Batch job."
  type        = string
}

variable "name" {
  description = "Name prefix for the scheduled GCP Batch job."
  type        = string
}

variable "region" {
  description = "GCP region for Workflows, Cloud Scheduler, and Batch."
  type        = string
}

variable "labels" {
  description = "Labels applied to resources that support labels."
  type        = map(string)
  default     = {}
}
