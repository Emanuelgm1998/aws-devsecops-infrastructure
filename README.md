cat > ~/secure-saas-platform/README.md << 'EOF'
# AWS DevSecOps Infrastructure Platform

Production-ready cloud infrastructure on AWS built with Terraform, following DevSecOps best practices. Deployable in a single command.

## Architecture
Internet
│
▼
Application Load Balancer (ALB)
│
▼
ECS Fargate (Node.js containerized app)
│
├── IAM Task Role (least privilege)
├── Secrets Manager (credentials)
└── CloudWatch (logs + metrics + alarms)
Infrastructure as Code: Terraform (modular)
CI/CD: GitHub Actions

## Stack

| Layer | Technology |
|---|---|
| Compute | AWS ECS Fargate |
| Networking | VPC, Subnets (multi-AZ), ALB, Security Groups |
| Security | IAM least privilege, Secrets Manager |
| Observability | CloudWatch Logs, Metrics, Alarms, Dashboard |
| IaC | Terraform (modular) |
| CI/CD | GitHub Actions |
| App | Node.js + Docker |

## Project Structure
aws-devsecops-infrastructure/
├── app/
│   ├── index.js           # Node.js application
│   ├── package.json
│   └── Dockerfile         # Container definition
├── terraform/
│   ├── modules/
│   │   ├── vpc/           # Networking module
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   └── outputs.tf
│   │   └── ecs/           # Compute + Security + Observability
│   │       ├── main.tf    # ECS Fargate + ALB
│   │       ├── iam.tf     # IAM roles + least privilege policies
│   │       ├── secrets.tf # Secrets Manager
│   │       ├── monitoring.tf # CloudWatch alarms + dashboard
│   │       ├── variables.tf
│   │       └── outputs.tf
│   └── environments/
│       └── dev/           # Dev environment entry point
│           ├── main.tf
│           ├── variables.tf
│           └── outputs.tf
└── .github/
└── workflows/
├── terraform-plan.yml   # Runs on Pull Request
└── terraform-apply.yml  # Runs on merge to main

## Security Design

- **IAM least privilege**: task role and execution role are separated. The container only has permissions to read secrets and write logs.
- **Secrets Manager**: no credentials in code or environment variables. DB passwords and API keys are injected at runtime from AWS Secrets Manager.
- **Security Groups**: ALB only accepts traffic on port 80. ECS only accepts traffic from ALB on port 3000. No direct public access to containers.
- **No hardcoded credentials**: all sensitive values managed via GitHub Actions secrets and AWS Secrets Manager.

## CI/CD Pipeline
Pull Request → terraform plan (preview changes)
Merge to main → terraform apply (deploy infrastructure)

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
Verifica y sube:
bashcat ~/secure-saas-platform/README.md | head -20
bashcd ~/secure-saas-platform
git add README.md
git commit -m "docs: professional README with architecture, security design and deploy guide"
git push origin mainDijiste: NECESITO QUE ME CREES EL README PROFESIONALMENTE PARA COPIAR Y PEGAR TODO EN UN SOLO BLOQUE (LO PEGARE POR LA PAGINA NOMAS)NECESITO QUE ME CREES EL README PROFESIONALMENTE PARA COPIAR Y PEGAR TODO EN UN SOLO BLOQUE (LO PEGARE POR LA PAGINA NOMAS)4:29 a. m.Claude respondió: Aquí está el README completo para copiar y pegar directamente en GitHub:Aquí está el README completo para copiar y pegar directamente en GitHub:

markdown# AWS DevSecOps Infrastructure Platform

![AWS](https://img.shields.io/badge/AWS-ECS%20Fargate-orange)
![Terraform](https://img.shields.io/badge/IaC-Terraform-purple)
![CI/CD](https://img.shields.io/badge/CI%2FCD-GitHub%20Actions-blue)
![Security](https://img.shields.io/badge/Security-DevSecOps-red)

Production-ready cloud infrastructure on AWS built with Terraform, following DevSecOps best practices. Fully deployable in a single command.

---

## Architecture
Internet
│
▼
Application Load Balancer (ALB)
│  port 80 — public
▼
ECS Fargate (Node.js containerized app)
│  port 3000 — private (only from ALB)
├── IAM Task Role (least privilege)
├── Secrets Manager (credentials at runtime)
└── CloudWatch (logs + metrics + alarms + dashboard)
Infrastructure as Code : Terraform (modular, multi-environment)
CI/CD                  : GitHub Actions (plan on PR, apply on merge)
Container Registry     : Docker Hub

---

## Tech Stack

| Layer | Technology |
|---|---|
| Compute | AWS ECS Fargate (serverless containers) |
| Networking | VPC, Public Subnets multi-AZ, ALB, Security Groups |
| Security | IAM least privilege, AWS Secrets Manager |
| Observability | CloudWatch Logs, Metrics, Alarms, Dashboard |
| Infrastructure as Code | Terraform modular |
| CI/CD | GitHub Actions |
| Application | Node.js + Docker |

---

## Project Structure
aws-devsecops-infrastructure/
├── app/
│   ├── index.js                  # Node.js REST API
│   ├── package.json
│   └── Dockerfile                # Secure container (non-root user)
├── terraform/
│   ├── modules/
│   │   ├── vpc/                  # Networking module
│   │   │   ├── main.tf           # VPC, subnets, IGW, route tables
│   │   │   ├── variables.tf
│   │   │   └── outputs.tf
│   │   └── ecs/                  # Compute + Security + Observability
│   │       ├── main.tf           # ECS cluster, task, service, ALB
│   │       ├── iam.tf            # IAM roles + least privilege policies
│   │       ├── secrets.tf        # AWS Secrets Manager
│   │       ├── monitoring.tf     # CloudWatch alarms + dashboard
│   │       ├── variables.tf
│   │       └── outputs.tf
│   └── environments/
│       └── dev/                  # Dev environment entry point
│           ├── main.tf
│           ├── variables.tf
│           └── outputs.tf
└── .github/
└── workflows/
├── terraform-plan.yml    # Triggered on Pull Request
└── terraform-apply.yml   # Triggered on merge to main

---

## Security Design

### IAM Least Privilege
Two separate IAM roles:
- **Execution Role**: allows ECS to pull the container image and write logs. Uses AWS managed policy only.
- **Task Role**: allows the running container to read secrets from Secrets Manager and write to CloudWatch Logs. No other permissions granted.

### Secrets Management
No credentials in code or environment variables. Passwords and API keys are stored in AWS Secrets Manager and injected at runtime. The secret ARN is referenced in the task definition — never the value itself.

### Network Security
- ALB accepts traffic only on port 80 from the public internet
- ECS containers accept traffic only on port 3000 from the ALB security group
- No direct public access to containers

### CI/CD Security
AWS credentials are stored as encrypted GitHub Actions repository secrets. They are never exposed in logs or code.

---

## CI/CD Pipeline
Developer pushes code
│
▼
Pull Request opened
│
▼
GitHub Actions: terraform plan
(shows infrastructure changes before applying)
│
▼
Pull Request merged to main
│
▼
GitHub Actions: terraform apply
(deploys infrastructure automatically)

---

## Deploy

### Prerequisites
- AWS CLI configured (`aws configure`)
- Terraform >= 1.0 installed
- Docker installed

### Deploy in one command
```bash
cd terraform/environments/dev
terraform init
terraform apply -auto-approve
```

### Get the app URL
```bash
terraform output app_url
```

### Test the app
```bash
curl $(terraform output -raw app_url)
```

Expected response:
```json
{
  "status": "ok",
  "service": "secure-saas-platform",
  "version": "1.0.0",
  "timestamp": "2026-01-01T00:00:00.000Z"
}
```

### Destroy (cost control)
```bash
terraform destroy -auto-approve
```

---

## Observability

### CloudWatch Alarms
| Alarm | Threshold | Action |
|---|---|---|
| CPU High | > 80% | Alert |
| ALB Latency | > 2 seconds | Alert |
| HTTP 5xx Errors | > 5 per minute | Alert |

### CloudWatch Dashboard
Unified view of CPU utilization, ALB response time and error rates available in AWS Console → CloudWatch → Dashboards → secure-saas-dashboard.

---

## Cost Estimation

Designed for ephemeral usage (deploy → verify → destroy):

| Resource | Cost per session (~15 min) |
|---|---|
| ECS Fargate | ~$0.01 |
| Application Load Balancer | ~$0.01 |
| CloudWatch | Free tier |
| IAM / VPC / Subnets | Always free |
| Secrets Manager | Free (30-day trial per secret) |
| **Total per session** | **~$0.02** |

---

## Author

**Emanuel GM** — Cloud & DevOps Engineer

[![GitHub](https://img.shields.io/badge/GitHub-Emanuelgm1998-black)](https://github.com/Emanuelgm1998)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Emanuel%20GM-blue)](https://linkedin.com/in/emanuelgm1998)
