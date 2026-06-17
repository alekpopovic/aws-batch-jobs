variable "project_id" {
  description = "GCP project ID where private networking resources are configured."
  type        = string
}

variable "network" {
  description = "VPC network self link or name used by GCP Batch jobs."
  type        = string
}

variable "subnetwork" {
  description = "Subnetwork self link or name used by GCP Batch jobs."
  type        = string
}

variable "labels" {
  description = "Labels applied to resources that support labels."
  type        = map(string)
  default     = {}
}
