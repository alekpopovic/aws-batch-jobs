variable "project_id" {
  description = "GCP project ID for the example."
  type        = string
}

variable "region" {
  description = "GCP region for Workflows, Cloud Scheduler, Batch, and networking."
  type        = string
  default     = "europe-west1"
}

variable "name" {
  description = "Name prefix for the scheduled GCP Batch job."
  type        = string
  default     = "scheduled-batch-gcp-private"
}

variable "container_image" {
  description = "Container image URI used by the Cloud Batch job."
  type        = string
}

variable "ip_cidr_range" {
  description = "Primary IPv4 CIDR range for the Batch subnet."
  type        = string
  default     = "10.20.0.0/24"
}

variable "create_cloud_nat" {
  description = "Whether to create Cloud NAT for private outbound internet access."
  type        = bool
  default     = false
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
