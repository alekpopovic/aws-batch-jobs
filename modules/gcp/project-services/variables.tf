variable "project_id" {
  description = "GCP project ID where required APIs will be enabled."
  type        = string
}

variable "services" {
  description = "Google APIs to enable for the scheduled Batch job stack."
  type        = list(string)
  default = [
    "batch.googleapis.com",
    "cloudscheduler.googleapis.com",
    "workflows.googleapis.com",
    "logging.googleapis.com"
  ]
}
