locals {
  is_aws = var.cloud_provider == "aws"
  is_gcp = var.cloud_provider == "gcp"

  aws_schedule_expression = var.schedule_expression != null ? var.schedule_expression : "cron(0 3 * * ? *)"
  gcp_schedule            = var.schedule_expression != null ? var.schedule_expression : "0 3 * * *"

  common_input = merge({ name = var.name }, var.scheduler_input)

  gcp_labels = {
    for key, value in var.tags :
    substr(
      can(regex("^[a-z]", trim(replace(lower(key), "/[^a-z0-9_-]/", "-"), "-_")))
      ? trim(replace(lower(key), "/[^a-z0-9_-]/", "-"), "-_")
      : "label-${trim(replace(lower(key), "/[^a-z0-9_-]/", "-"), "-_")}",
      0,
      63
    ) => substr(trim(replace(lower(value), "/[^a-z0-9_-]/", "-"), "-_"), 0, 63)
  }
}
