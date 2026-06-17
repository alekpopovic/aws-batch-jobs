output "schedule_arn" {
  description = "ARN of the EventBridge Scheduler schedule."
  value       = aws_scheduler_schedule.this.arn
}

output "schedule_name" {
  description = "Name of the EventBridge Scheduler schedule."
  value       = aws_scheduler_schedule.this.name
}

output "role_arn" {
  description = "ARN of the EventBridge Scheduler execution role."
  value       = aws_iam_role.scheduler.arn
}
