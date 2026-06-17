variable "name" {
  description = "Name prefix for VPC endpoint resources."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where endpoints will be created."
  type        = string
}

variable "subnet_ids" {
  description = "Subnet IDs for interface endpoints."
  type        = list(string)
}

variable "route_table_ids" {
  description = "Route table IDs associated with private subnets for the S3 gateway endpoint."
  type        = list(string)
  default     = []
}

variable "allowed_security_group_ids" {
  description = "Security group IDs allowed to connect to interface endpoints on TCP 443."
  type        = list(string)
  default     = []
}

variable "create" {
  description = "Whether to create VPC endpoints and their security group."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags applied to resources that support tags."
  type        = map(string)
  default     = {}
}
