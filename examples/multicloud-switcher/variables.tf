variable "provider_name" {
  description = "Cloud provider to use. Expected values will be aws or gcp."
  type        = string
  default     = "aws"
}

variable "name" {
  description = "Name prefix for the scheduled batch job."
  type        = string
  default     = "multicloud-scheduled-jobs-switcher"
}
