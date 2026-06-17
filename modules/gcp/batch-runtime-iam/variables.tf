variable "project_id" {
  description = "GCP project ID where runtime IAM will be created."
  type        = string
}

variable "name" {
  description = "Name prefix for GCP Batch runtime IAM resources."
  type        = string
}

variable "labels" {
  description = "Labels applied to resources that support labels."
  type        = map(string)
  default     = {}
}
