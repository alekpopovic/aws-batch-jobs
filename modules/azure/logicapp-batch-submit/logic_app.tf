resource "azapi_resource" "logic_app" {
  type      = "Microsoft.Logic/workflows@2019-05-01"
  name      = local.logic_app_name
  location  = var.location
  parent_id = local.resource_group_id
  tags      = local.tags

  identity {
    type = "SystemAssigned"
  }

  body = {
    properties = {
      definition = merge(
        jsondecode(templatefile("${path.module}/workflow-definition.json.tftpl", {
          batch_account_url                         = local.batch_account_url
          batch_api_version                         = var.batch_api_version
          batch_pool_name                           = var.batch_pool_name
          container_image                           = var.container_image
          delete_job_on_completion                  = var.delete_job_on_completion
          enable_command_override_from_trigger_body = var.enable_command_override_from_trigger_body
          environment_settings_json                 = jsonencode(local.environment_settings)
          max_poll_attempts                         = var.max_poll_attempts
          poll_interval_seconds                     = var.poll_interval_seconds
          recurrence_json                           = jsonencode(local.recurrence)
          safe_name                                 = local.safe_name
          task_max_wall_clock_time                  = var.task_max_wall_clock_time
          task_retention_time                       = var.task_retention_time
          task_retry_maximum                        = var.task_retry_maximum
          terminate_job_on_task_failure             = var.terminate_job_on_task_failure
        })),
        {
          parameters = local.workflow_parameter_definitions
        }
      )
      parameters = local.workflow_parameter_values
    }
  }

  response_export_values = [
    "identity.principalId",
    "identity.tenantId"
  ]
}
