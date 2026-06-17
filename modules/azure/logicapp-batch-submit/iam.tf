resource "azurerm_role_assignment" "logicapp_batch_submitter" {
  scope                = var.batch_account_id
  role_definition_name = var.batch_role_definition_name
  principal_id         = azapi_resource.logic_app.identity[0].principal_id
}
