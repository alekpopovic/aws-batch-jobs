# batch-fargate

Terraform module for AWS Batch jobs running on Fargate.

## What This Module Creates

- CloudWatch Log Group for Batch container logs.
- Security Group for AWS Batch Fargate tasks.
- AWS Batch service IAM role.
- ECS task execution IAM role.
- Batch job IAM role.
- AWS Batch managed Fargate Compute Environment.
- AWS Batch Job Queue.
- AWS Batch Job Definition with Fargate platform capabilities.

This module does not create Lambda functions or EC2 AWS Batch compute environments.

## Usage

```hcl
module "batch_fargate" {
  source = "../../modules/batch-fargate"

  name            = "daily-report"
  vpc_id          = "vpc-0123456789abcdef0"
  subnet_ids      = ["subnet-0123456789abcdef0", "subnet-abcdef01234567890"]
  container_image = "public.ecr.aws/docker/library/alpine:latest"

  container_command = ["sh", "-c", "echo 'Hello from AWS Batch'; date"]

  environment_variables = {
    ENVIRONMENT = "dev"
  }

  tags = {
    Project = "scheduled-batch-jobs"
  }
}
```

## Public IP Assignment

`assign_public_ip` controls whether Fargate tasks receive a public IP address:

- `false` is the default and is intended for private subnets with NAT Gateway or required VPC endpoints.
- `true` can be used when running in public subnets and direct outbound internet access is required.

## Execution Role vs Job Role

The execution role is used by ECS/Fargate to pull the container image and send logs to CloudWatch Logs.

The job role is assumed by the application code running inside the container. Add runtime permissions to this role when the container needs access to AWS services.

## Runtime Permissions

Add container runtime permissions in `iam.tf` on or alongside `aws_iam_role.batch_job`. Typical examples include S3, Secrets Manager, DynamoDB, SQS, or service-specific permissions needed by the job workload.
