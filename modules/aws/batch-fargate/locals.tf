data "aws_partition" "current" {}
data "aws_region" "current" {}

locals {
  name = var.name

  tags = merge(var.tags, {
    ManagedBy = "terraform"
    Module    = "batch-fargate"
  })
}
