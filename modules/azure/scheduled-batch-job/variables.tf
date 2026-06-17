variable "subscription_id" {
  description = "Azure subscription ID used by the Logic App workflow module to build ARM resource IDs."
  type        = string
}

variable "name" {
  description = "Name prefix for the scheduled Azure Batch job flow."
  type        = string
}

variable "resource_group_name" {
  description = "Azure resource group name."
  type        = string
}

variable "location" {
  description = "Azure region for the scheduled Azure Batch job flow."
  type        = string
  default     = "westeurope"
}

variable "container_image" {
  description = "Container image used by Azure Batch tasks."
  type        = string
}

variable "container_command_line" {
  description = "Default command line used by the Azure Batch task."
  type        = string
  default     = "/bin/sh -c \"echo Hello from Azure Batch; date; env\""
}

variable "environment_variables" {
  description = "Environment variables passed to the Azure Batch task."
  type        = map(string)
  default     = {}
}

variable "storage_account_name" {
  description = "Optional storage account name. When null, the Batch module generates a unique lowercase name."
  type        = string
  default     = null
}

variable "batch_account_name" {
  description = "Optional Azure Batch account name. When null, the Batch module generates a unique lowercase name."
  type        = string
  default     = null
}

variable "pool_name" {
  description = "Optional Azure Batch pool name. When null, the Batch module derives one from name."
  type        = string
  default     = null
}

variable "vm_size" {
  description = "Azure VM size used by pool nodes."
  type        = string
  default     = "STANDARD_D2S_V3"
}

variable "node_agent_sku_id" {
  description = "Azure Batch node agent SKU ID."
  type        = string
  default     = "batch.node.ubuntu 20.04"
}

variable "storage_image_reference" {
  description = "Azure Marketplace image reference compatible with the selected Batch node agent SKU."
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  default = {
    publisher = "microsoft-azure-batch"
    offer     = "ubuntu-server-container"
    sku       = "20-04-lts"
    version   = "latest"
  }
}

variable "target_dedicated_nodes" {
  description = "Target number of dedicated nodes in the Batch pool."
  type        = number
  default     = 0
}

variable "target_low_priority_nodes" {
  description = "Target number of low-priority nodes in the Batch pool."
  type        = number
  default     = 1
}

variable "max_tasks_per_node" {
  description = "Maximum number of tasks that can run concurrently on one node."
  type        = number
  default     = 1
}

variable "preload_container_image" {
  description = "Whether the Batch pool should preload container_image on nodes."
  type        = bool
  default     = true
}

variable "create_pool_identity" {
  description = "Whether to create and attach a user-assigned managed identity to the Batch pool."
  type        = bool
  default     = true
}

variable "acr_id" {
  description = "Optional Azure Container Registry resource ID. When set with create_pool_identity, AcrPull is granted to the pool identity."
  type        = string
  default     = null
}

variable "subnet_id" {
  description = "Optional subnet ID for Azure Batch pool network attachment. Use modules/azure/batch-private-network to create one."
  type        = string
  default     = null
}

variable "public_address_provisioning_type" {
  description = "Public IP provisioning mode for Azure Batch pool nodes."
  type        = string
  default     = "BatchManaged"

  validation {
    condition     = contains(["BatchManaged", "UserManaged", "NoPublicIPAddresses"], var.public_address_provisioning_type)
    error_message = "public_address_provisioning_type must be BatchManaged, UserManaged, or NoPublicIPAddresses."
  }
}

variable "recurrence_frequency" {
  description = "Logic Apps recurrence frequency."
  type        = string
  default     = "Day"

  validation {
    condition     = contains(["Second", "Minute", "Hour", "Day", "Week", "Month"], var.recurrence_frequency)
    error_message = "recurrence_frequency must be Second, Minute, Hour, Day, Week, or Month."
  }
}

variable "recurrence_interval" {
  description = "Logic Apps recurrence interval."
  type        = number
  default     = 1
}

variable "recurrence_time_zone" {
  description = "Windows time zone ID used by Logic Apps recurrence. Europe/Belgrade is Central Europe Standard Time."
  type        = string
  default     = "Central Europe Standard Time"
}

variable "recurrence_hours" {
  description = "Hours used by daily or weekly recurrence schedules."
  type        = list(number)
  default     = [3]
}

variable "recurrence_minutes" {
  description = "Minutes used by recurrence schedules."
  type        = list(number)
  default     = [0]
}

variable "recurrence_week_days" {
  description = "Week days used by weekly recurrence schedules."
  type        = list(string)
  default     = []
}

variable "start_time" {
  description = "Optional Logic Apps recurrence start time."
  type        = string
  default     = null
}

variable "task_max_wall_clock_time" {
  description = "Maximum wall clock time for the Batch task."
  type        = string
  default     = "PT1H"
}

variable "task_retention_time" {
  description = "Retention time for the Batch task."
  type        = string
  default     = "P1D"
}

variable "task_retry_maximum" {
  description = "Maximum retry count for the Batch task."
  type        = number
  default     = 0
}

variable "poll_interval_seconds" {
  description = "Polling interval while waiting for the Batch task to complete."
  type        = number
  default     = 30
}

variable "max_poll_attempts" {
  description = "Maximum task polling attempts before failing the workflow."
  type        = number
  default     = 120
}

variable "delete_job_on_completion" {
  description = "Whether to delete the Batch job after task completion."
  type        = bool
  default     = false
}

variable "terminate_job_on_task_failure" {
  description = "Whether to terminate the Batch job when the task exits with a non-zero code."
  type        = bool
  default     = true
}

variable "batch_role_definition_name" {
  description = "Azure RBAC role assigned to the Logic App managed identity on the Batch account."
  type        = string
  default     = "Azure Batch Job Submitter"
}

variable "enable_command_override_from_trigger_body" {
  description = "Whether triggerBody().commandLine can override container_command_line."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags applied to Azure resources that support tags."
  type        = map(string)
  default     = {}
}
