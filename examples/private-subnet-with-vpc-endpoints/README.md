# Private subnet with VPC endpoints example

Example showing how the scheduled Batch job wrapper module can be used with VPC endpoints for private subnet workloads.

## Usage

```bash
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform plan
```

The example expects an existing VPC, private subnets, and route tables. It creates the scheduled Batch job flow and the VPC endpoints needed for Fargate image pulls and CloudWatch Logs without a NAT Gateway.
