variable "project_id" {
  description = "GCP project ID for the example."
  type        = string
}

variable "region" {
  description = "GCP region for the example."
  type        = string
  default     = "europe-west1"
}

variable "name" {
  description = "Name prefix for the scheduled GCP Batch job."
  type        = string
  default     = "multicloud-scheduled-jobs-gcp-basic"
}

variable "labels" {
  description = "Labels applied to resources that support labels."
  type        = map(string)
  default     = {}
}
