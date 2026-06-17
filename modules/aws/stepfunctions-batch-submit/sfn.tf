resource "aws_sfn_state_machine" "this" {
  name     = "${var.name}-state-machine"
  role_arn = aws_iam_role.sfn.arn
  type     = "STANDARD"

  definition = jsonencode({
    StartAt = "SubmitBatchJob"
    States = {
      SubmitBatchJob = {
        Type     = "Task"
        Resource = local.batch_submit_job_arn
        Parameters = {
          JobName            = local.batch_job_name
          JobQueue           = var.job_queue_arn
          JobDefinition      = var.job_definition_arn
          ContainerOverrides = local.container_overrides
        }
        End = true
      }
    }
  })

  tags = local.tags
}
