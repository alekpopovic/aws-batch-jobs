data "aws_region" "current" {}

locals {
  name = var.name

  tags = merge(var.tags, {
    ManagedBy = "terraform"
    Module    = "vpc-endpoints-fargate"
  })
}
