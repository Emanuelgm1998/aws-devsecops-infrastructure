Pipelines run automatically on GitHub Actions with AWS credentials stored as encrypted repository secrets.

## Deploy

### Prerequisites
- AWS CLI configured
- Terraform >= 1.0
- Docker

### One-command deploy
```bash
cd terraform/environments/dev
terraform init
terraform apply -auto-approve
```

### Get app URL
```bash
terraform output app_url
```

### Destroy (cost control)
```bash
terraform destroy -auto-approve
```

## Observability

CloudWatch dashboard includes:
- ECS CPU utilization
- ALB response latency
- HTTP 5xx error count

Alarms configured for:
- CPU > 80%
- Latency > 2 seconds
- 5xx errors > 5 per minute

## Cost

Designed for ephemeral usage (deploy → test → destroy):

| Resource | Cost per session (~15 min) |
|---|---|
| ECS Fargate | ~$0.01 |
| ALB | ~$0.01 |
| CloudWatch | Free tier |
| IAM / VPC | Always free |
| **Total** | **~$0.02** |

## Author

**Emanuel GM**
Cloud & DevOps Engineer
[github.com/Emanuelgm1998](https://github.com/Emanuelgm1998)
[linkedin.com/in/emanuelgm1998](https://linkedin.com/in/emanuelgm1998)
EOF
