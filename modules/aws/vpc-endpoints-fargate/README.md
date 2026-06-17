# vpc-endpoints-fargate

Terraform module for VPC endpoints commonly needed by AWS Batch Fargate jobs running in private subnets without a NAT Gateway and without public IP addresses.

## When To Use This Module

Use this module when Fargate tasks must stay private but still need to:

- Pull container images from Amazon ECR.
- Write logs to CloudWatch Logs.
- Access ECR image layers stored in S3.

## What This Module Creates

- ECR API interface endpoint: `com.amazonaws.<region>.ecr.api`
- ECR Docker interface endpoint: `com.amazonaws.<region>.ecr.dkr`
- CloudWatch Logs interface endpoint: `com.amazonaws.<region>.logs`
- S3 gateway endpoint: `com.amazonaws.<region>.s3`
- Security group for the interface endpoints.

The interface endpoint security group allows inbound TCP 443 only from the security groups passed through `allowed_security_group_ids`.

## Usage

```hcl
module "vpc_endpoints_fargate" {
  source = "../../modules/aws/vpc-endpoints-fargate"

  name       = "daily-report"
  vpc_id     = "vpc-0123456789abcdef0"
  subnet_ids = ["subnet-0123456789abcdef0", "subnet-abcdef01234567890"]

  route_table_ids = [
    "rtb-0123456789abcdef0",
    "rtb-abcdef01234567890"
  ]

  allowed_security_group_ids = [
    module.batch_fargate.security_group_id
  ]

  tags = {
    Project = "scheduled-batch-jobs"
  }
}
```

## Private Subnets Without NAT

For private Fargate jobs with `assign_public_ip = false`, these endpoints provide the private network paths needed for image pulls and logs. Without them, jobs may fail before the container starts because Fargate cannot reach ECR or CloudWatch Logs.

## Why Each Endpoint Is Needed

- `ecr.api`: lets Fargate call the ECR API for image metadata and authorization.
- `ecr.dkr`: lets Fargate connect to the ECR Docker registry endpoint.
- `logs`: lets the task execution role write container logs to CloudWatch Logs.
- `s3`: lets Fargate access ECR image layers, which are served through S3.

## S3 Route Tables

The S3 endpoint is a gateway endpoint, so `route_table_ids` must include the route tables associated with the private subnets used by the Fargate tasks. If `route_table_ids` is empty, the S3 gateway endpoint will not be attached to any route table.
