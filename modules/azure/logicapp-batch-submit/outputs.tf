output "logic_app_name" {
  description = "Logic Apps workflow name."
  value       = azapi_resource.logic_app.name
}

output "logic_app_id" {
  description = "Logic Apps workflow resource ID."
  value       = azapi_resource.logic_app.id
}

output "logic_app_identity_principal_id" {
  description = "Principal ID of the Logic App system-assigned managed identity."
  value       = azapi_resource.logic_app.identity[0].principal_id
}

output "logic_app_identity_tenant_id" {
  description = "Tenant ID of the Logic App system-assigned managed identity."
  value       = azapi_resource.logic_app.identity[0].tenant_id
}

output "batch_account_url" {
  description = "Normalized Azure Batch account URL used by the workflow."
  value       = local.batch_account_url
}

output "batch_role_assignment_id" {
  description = "Role assignment ID granting the Logic App access to the Batch account."
  value       = azurerm_role_assignment.logicapp_batch_submitter.id
}
