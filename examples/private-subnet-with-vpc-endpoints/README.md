# Private subnet with VPC endpoints example

Example showing how to run scheduled AWS Batch Fargate jobs in private subnets without a NAT Gateway.

This example uses:

- `modules/scheduled-batch-job` for the EventBridge Scheduler, Step Functions, and AWS Batch Fargate flow.
- `modules/vpc-endpoints-fargate` for private access to ECR, CloudWatch Logs, and S3.

`assign_public_ip` is set to `false` so Batch Fargate tasks do not receive public IP addresses. The tasks stay in private subnets and use VPC endpoints for required AWS service access.

## Required Endpoints

- `ecr.api`: ECR API access for image metadata and authorization.
- `ecr.dkr`: ECR Docker registry access for pulling the image.
- `logs`: CloudWatch Logs access for container logs.
- `s3`: S3 gateway endpoint for ECR image layer access.

`route_table_ids` must belong to the route tables associated with the private subnets used by the Batch Fargate tasks. The S3 gateway endpoint attaches to those route tables.

## Usage

```bash
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform fmt -recursive
terraform validate
terraform plan
terraform apply
```

## Troubleshooting

If Batch jobs fail with `CannotPullContainerError`, check:

- The private subnets use route tables listed in `route_table_ids`.
- The S3 gateway endpoint is attached to those route tables.
- The ECR API, ECR Docker, and CloudWatch Logs interface endpoints have `private_dns_enabled = true`.
- The endpoint security group allows TCP 443 from `batch_security_group_id`.
- The container image URI exists in the selected `aws_region`.
