# Basic example

Minimal example showing how to use the `scheduled-batch-job` wrapper module.

## Usage

```bash
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform plan
```

The example expects an existing VPC and subnets. It creates the AWS Batch Fargate setup, Step Functions state machine, and EventBridge Scheduler schedule through the wrapper module.
