resource "aws_scheduler_schedule" "this" {
  name                         = local.schedule_name
  group_name                   = var.schedule_group_name
  schedule_expression          = var.schedule_expression
  schedule_expression_timezone = var.schedule_timezone
  state                        = "ENABLED"

  flexible_time_window {
    mode = "OFF"
  }

  target {
    arn      = var.state_machine_arn
    role_arn = aws_iam_role.scheduler.arn
    input    = jsonencode(var.target_input)

    retry_policy {
      maximum_retry_attempts       = var.maximum_retry_attempts
      maximum_event_age_in_seconds = var.maximum_event_age_in_seconds
    }
  }
}
