data "aws_partition" "current" {}
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

locals {
  name                 = var.name
  batch_submit_job_arn = "arn:${data.aws_partition.current.partition}:states:::batch:submitJob.sync"

  tags = merge(var.tags, {
    ManagedBy = "terraform"
    Module    = "stepfunctions-batch-submit"
  })

  batch_job_name = var.batch_job_name != null ? var.batch_job_name : "${var.name}-job"

  container_environment_overrides = [
    for key, value in var.container_environment_overrides : {
      Name  = key
      Value = value
    }
  ]

  container_overrides = merge(
    {
      Environment = local.container_environment_overrides
    },
    var.command_json_path != null ? {
      "Command.$" = var.command_json_path
    } : {}
  )
}
