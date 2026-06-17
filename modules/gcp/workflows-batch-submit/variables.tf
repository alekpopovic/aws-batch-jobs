variable "project_id" {
  description = "GCP project ID where Workflows will be created."
  type        = string
}

variable "name" {
  description = "Name prefix for the Workflow."
  type        = string
}

variable "region" {
  description = "GCP region for Workflows and Batch jobs."
  type        = string
}

variable "labels" {
  description = "Labels applied to resources that support labels."
  type        = map(string)
  default     = {}
}
