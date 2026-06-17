output "state_machine_arn" {
  description = "ARN of the Step Functions state machine."
  value       = aws_sfn_state_machine.this.arn
}

output "state_machine_name" {
  description = "Name of the Step Functions state machine."
  value       = aws_sfn_state_machine.this.name
}

output "role_arn" {
  description = "ARN of the Step Functions execution role."
  value       = aws_iam_role.sfn.arn
}
