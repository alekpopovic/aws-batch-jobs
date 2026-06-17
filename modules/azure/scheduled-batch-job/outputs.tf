output "storage_account_id" {
  description = "ID of the storage account linked to the Azure Batch account."
  value       = module.batch.storage_account_id
}

output "storage_account_name" {
  description = "Name of the storage account linked to the Azure Batch account."
  value       = module.batch.storage_account_name
}

output "batch_account_id" {
  description = "ID of the Azure Batch account."
  value       = module.batch.batch_account_id
}

output "batch_account_name" {
  description = "Name of the Azure Batch account."
  value       = module.batch.batch_account_name
}

output "batch_account_endpoint" {
  description = "Endpoint of the Azure Batch account."
  value       = module.batch.batch_account_endpoint
}

output "batch_pool_id" {
  description = "ID of the Azure Batch pool."
  value       = module.batch.batch_pool_id
}

output "batch_pool_name" {
  description = "Name of the Azure Batch pool."
  value       = module.batch.batch_pool_name
}

output "pool_identity_principal_id" {
  description = "Principal ID of the pool user-assigned managed identity, or null when disabled."
  value       = module.batch.pool_identity_principal_id
}

output "logic_app_name" {
  description = "Logic Apps workflow name."
  value       = module.logic_app.logic_app_name
}

output "logic_app_id" {
  description = "Logic Apps workflow resource ID."
  value       = module.logic_app.logic_app_id
}

output "logic_app_identity_principal_id" {
  description = "Principal ID of the Logic App system-assigned managed identity."
  value       = module.logic_app.logic_app_identity_principal_id
}

output "batch_role_assignment_id" {
  description = "Role assignment ID granting the Logic App access to the Batch account."
  value       = module.logic_app.batch_role_assignment_id
}
