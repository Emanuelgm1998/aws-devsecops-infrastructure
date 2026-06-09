

markdown
# Production-Ready AWS DevSecOps Infrastructure Platform

<p align="center">

<img src="https://img.shields.io/badge/AWS-232F3E?style=for-the-badge&logo=amazon-aws&logoColor=white" />
<img src="https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white" />
<img src="https://img.shields.io/badge/GitHub_Actions-2088FF?style=for-the-badge&logo=github-actions&logoColor=white" />
<img src="https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white" />
<img src="https://img.shields.io/badge/DevSecOps-Zero_Trust-red?style=for-the-badge" />

</p>

<p align="center">
  <a href="https://github.com/Emanuelgm1998/aws-devsecops-infrastructure">
    <img src="https://img.shields.io/badge/Repository-aws--devsecops--infrastructure-black?style=for-the-badge&logo=github" />
  </a>
</p>

---

## Engineer Profile

**Emanuel G. Michea** — Cloud & DevOps Engineer

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Emanuel%20G.%20Michea-blue?style=flat&logo=linkedin)](https://www.linkedin.com/in/emanuel-gonzalez-michea/)
[![GitHub](https://img.shields.io/badge/GitHub-Emanuelgm1998-black?style=flat&logo=github)](https://github.com/Emanuelgm1998)

---

## Overview

This repository implements a **production-grade, multi-AZ AWS infrastructure platform** built with:

* Infrastructure as Code (Terraform)
* DevSecOps automation (GitHub Actions)
* Zero Trust security model
* Containerized microservices (ECS Fargate)
* Full observability (CloudWatch)

It is designed as a **real-world cloud architecture portfolio project** aligned with modern DevSecOps engineering roles.

---

## High-Level Architecture

```mermaid
flowchart TD

User[Internet Client] --> ALB[Application Load Balancer]

subgraph VPC[AWS VPC - Multi AZ]

    subgraph Public[Public Subnets - AZ-a and AZ-b]
        ALB
        ECS[AWS ECS Fargate Cluster]
        APP[Node.js Microservice]
        ECS --> APP
    end

end

ALB --> ECS

Secrets[AWS Secrets Manager] --> APP
IAM[IAM Roles - Least Privilege] --> APP

APP --> CWL[CloudWatch Logs]
ALB --> CWM[CloudWatch Metrics]
```

> **Note:** Current implementation uses public subnets with Security Group restrictions (ALB → ECS only). Migration to private subnets + NAT Gateway is included in the roadmap.

---

## Zero Trust Security Model

### Identity & Access Control

* Separate IAM roles:
  * ECS Task Execution Role (infrastructure access only)
  * ECS Task Role (application permissions only)
* Principle of Least Privilege enforced at every layer

### Network Security

* ALB is the only internet-facing resource (port 80)
* ECS containers accept traffic only from ALB security group (port 3000)
* No direct public access to application containers

### Secrets Management

* No hardcoded credentials anywhere in code
* Runtime injection via AWS Secrets Manager
* Secret ARN referenced in task definition — never the value itself

---

## CI/CD Pipeline (GitOps)

```mermaid
flowchart LR

PR[Pull Request] --> PLAN[Terraform Plan - GitHub Actions]
PLAN --> REVIEW[Code Review / Validation]
REVIEW --> MERGE[Merge to Main]
MERGE --> APPLY[Terraform Apply]
APPLY --> AWS[Deploy to AWS]

AWS --> MON[CloudWatch Monitoring]
```

AWS credentials are stored as encrypted GitHub Actions repository secrets. Never exposed in logs or code.

---

## Infrastructure Stack

| Layer | Service | Purpose |
|---|---|---|
| Compute | AWS ECS Fargate | Serverless containers |
| Networking | AWS VPC + ALB | Secure traffic routing |
| Security | IAM + Secrets Manager | Zero Trust identity model |
| Observability | CloudWatch | Logs, metrics, alarms |
| IaC | Terraform | Declarative infrastructure |
| CI/CD | GitHub Actions | Automated deployment |

---

## Project Structure

```text
aws-devsecops-infrastructure/

├── .github/workflows/
│   ├── terraform-plan.yml       # Triggered on Pull Request
│   └── terraform-apply.yml      # Triggered on merge to main

├── app/
│   ├── index.js                 # Node.js REST API
│   ├── Dockerfile               # Secure container (non-root user)
│   └── package.json

└── terraform/
    ├── modules/
    │   ├── vpc/                 # Networking module
    │   └── ecs/
    │       ├── main.tf          # ECS cluster, task, service, ALB
    │       ├── iam.tf           # IAM roles + least privilege policies
    │       ├── secrets.tf       # AWS Secrets Manager
    │       └── monitoring.tf    # CloudWatch alarms + dashboard
    └── environments/
        └── dev/                 # Dev environment entry point
```

---

## Observability & Monitoring

* Centralized CloudWatch Dashboard
* Real-time alerting system
* Application + infrastructure metrics

### Alert Rules

| Metric | Threshold | Action |
|---|---|---|
| CPU Usage | > 80% | Alert / Scale trigger |
| HTTP 5xx | > 5/min | Critical alert |
| Latency | > 2s | Performance warning |

---

## Cost Optimization Strategy

* ECS Fargate: pay-per-use compute model
* Ephemeral environments (terraform destroy when not in use)
* Free-tier optimized monitoring
* Minimal always-on resources

Estimated cost per test deployment: **~$0.02 per execution cycle**

---

## Deployment

### Prerequisites
- AWS CLI configured (`aws configure`)
- Terraform >= 1.0 installed
- Docker installed

### Deploy
```bash
cd terraform/environments/dev
terraform init
terraform apply -auto-approve
```

### Get app URL
```bash
terraform output app_url
```

### Test
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

### Destroy
```bash
terraform destroy -auto-approve
```

---

## Key DevSecOps Principles Demonstrated

* Zero Trust Architecture
* Immutable infrastructure
* GitOps-based deployments
* Least privilege IAM design
* Secrets isolation
* Multi-AZ resiliency
* Observability-first design

---

## Roadmap

- [ ] OIDC GitHub Actions → AWS (replace static Access Keys)
- [ ] Terraform Remote State (S3 + DynamoDB locking)
- [ ] Private subnets + NAT Gateway
- [ ] Trivy + Checkov security scanning in CI/CD pipeline
- [ ] staging and prod environments
- [ ] HTTPS with ACM certificate on ALB

---

## Why this project matters

This project demonstrates **production-level thinking**, not just AWS usage:

* Security-first design (not afterthought)
* Real CI/CD pipeline (like enterprise teams)
* Scalable container architecture
* Recruiter-ready documentation
* Cloud engineering maturity
```

---

Pégalo directo en GitHub editando el README. Las 4 mejoras que agregué fueron el badge con link al repo, la corrección del diagrama con la nota honesta sobre subnets públicas, los badges de LinkedIn/GitHub más visuales, y el Roadmap al final.
