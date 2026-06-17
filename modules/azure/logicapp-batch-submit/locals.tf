locals {
  tags = merge(var.tags, {
    managed_by = "terraform"
    module     = "azure-logicapp-batch-submit"
  })

  logic_app_name    = "${var.name}-logicapp"
  safe_name         = trim(replace(lower(var.name), "/[^a-z0-9-]/", "-"), "-")
  resource_group_id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}"
  batch_account_url = trimsuffix(startswith(var.batch_account_endpoint, "https://") ? var.batch_account_endpoint : "https://${var.batch_account_endpoint}", "/")

  environment_settings = [
    for key, value in var.environment_variables : {
      name  = key
      value = value
    }
  ]

  recurrence = merge(
    {
      frequency = var.recurrence_frequency
      interval  = var.recurrence_interval
      timeZone  = var.recurrence_time_zone
    },
    contains(["Day", "Week"], var.recurrence_frequency) ? {
      schedule = merge(
        {
          hours   = var.recurrence_hours
          minutes = var.recurrence_minutes
        },
        length(var.recurrence_week_days) > 0 ? {
          weekDays = var.recurrence_week_days
        } : {}
      )
    } : {},
    var.start_time != null ? {
      startTime = var.start_time
    } : {}
  )

  workflow_parameter_definitions = merge(
    {
      defaultCommandLine = {
        type         = "String"
        defaultValue = var.container_command_line
      }
      manualTriggerBody = {
        type         = "Object"
        defaultValue = var.manual_trigger_body
      }
    },
    {
      for key, value in var.workflow_parameters : key => {
        type         = "Object"
        defaultValue = value
      }
    }
  )

  workflow_parameter_values = merge(
    {
      defaultCommandLine = {
        value = var.container_command_line
      }
      manualTriggerBody = {
        value = var.manual_trigger_body
      }
    },
    {
      for key, value in var.workflow_parameters : key => {
        value = value
      }
    }
  )
}
