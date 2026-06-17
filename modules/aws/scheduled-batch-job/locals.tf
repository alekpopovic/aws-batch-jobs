locals {
  name = var.name

  tags = merge(var.tags, {
    ManagedBy = "terraform"
    Module    = "scheduled-batch-job"
  })

  command_json_path = var.enable_command_override_from_scheduler_input ? "$.command" : null

  scheduler_target_input = merge(
    {
      source = "eventbridge-scheduler"
      name   = var.name
    },
    var.scheduler_target_input
  )
}
