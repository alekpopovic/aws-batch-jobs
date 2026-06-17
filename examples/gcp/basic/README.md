# GCP Basic Example

Creates the GCP scheduled container job flow directly with provider-specific modules:

```text
Cloud Scheduler -> Google Workflows -> Cloud Batch container job
```

This example enables the required project services and uses `modules/gcp/scheduled-batch-job`. It does not use the multicloud switcher.

## Bootstrap

Enable Service Usage before Terraform manages project services:

```bash
gcloud services enable serviceusage.googleapis.com --project PROJECT_ID
```

## Apply

```bash
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform validate
terraform plan
terraform apply
```

## Manual Tests

Run the workflow manually:

```bash
gcloud workflows run WORKFLOW_NAME --location REGION --data='{"manual":true}'
```

Run the scheduler manually:

```bash
gcloud scheduler jobs run JOB_NAME --location REGION
```

List Batch jobs:

```bash
gcloud batch jobs list --location REGION
```

Read Batch task logs:

```bash
gcloud logging read 'resource.type="batch_task"' --limit 50
```
