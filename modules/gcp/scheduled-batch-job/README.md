# scheduled-batch-job

Skeleton wrapper module for the GCP scheduled Batch job flow.

Target flow:

```text
Cloud Scheduler -> Google Workflows -> GCP Batch Job
```

## TODO

- Compose the GCP building-block modules.
- Keep project ID, region, network, and runtime IAM configurable.
- Do not introduce Cloud Functions or Cloud Run jobs.
