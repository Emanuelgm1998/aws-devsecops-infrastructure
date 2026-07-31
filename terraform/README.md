# AWS ECS Fargate Infrastructure

This directory provisions the optional AWS runtime for the project. The local demo and CI checks do not require an AWS account.

## Architecture

- Multi-AZ VPC and public subnets
- Application Load Balancer
- ECS Fargate service and container health checks
- Least-privilege IAM roles and GitHub OIDC federation
- AWS Secrets Manager
- CloudWatch logs, dashboard, alarms, and SNS notifications
- S3 remote state with DynamoDB locking

## Layout

- `bootstrap/`: one-time remote-state resources
- `environments/dev/`: deployable development environment
- `modules/vpc/`: networking
- `modules/ecs/`: compute, load balancing, secrets, and observability
- `modules/iam-oidc/`: GitHub Actions federation

## Validation without AWS credentials

```bash
terraform fmt -check -recursive
terraform -chdir=environments/dev init -backend=false
terraform -chdir=environments/dev validate
```

## Deployment

Create the backend once, configure the required GitHub repository variables, and run the `Terraform Apply` workflow manually. This workflow is intentionally never triggered by a push.

Required repository variables:

- `AWS_OIDC_ROLE_ARN`
- `TF_STATE_BUCKET`
- `TF_LOCK_TABLE`
- `ALERT_EMAIL`

Destroy cloud resources when the evaluation is complete to avoid ongoing charges.
