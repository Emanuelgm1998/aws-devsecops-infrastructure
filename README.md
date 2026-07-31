
<p align="center">
  <img src="docs/assets/aws-devsecops-banner.png" width="100%" alt="AWS DevSecOps Infrastructure — Secure, Automated, Observable" />
</p>

<h1 align="center">AWS DevSecOps Infrastructure Platform</h1>

<p align="center">
  <strong>Production-oriented AWS infrastructure engineered for security, automation, and observability.</strong>
</p>

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

## Engineer

**Emanuel G. Michea** — Cloud & DevOps Engineer

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Emanuel%20G.%20Michea-blue?style=flat&logo=linkedin)](https://www.linkedin.com/in/emanuel-gonzalez-michea/)
[![GitHub](https://img.shields.io/badge/GitHub-Emanuelgm1998-black?style=flat&logo=github)](https://github.com/Emanuelgm1998)

---

## Overview

This repository implements a **production-oriented, multi-AZ AWS infrastructure platform** built with:

* Infrastructure as Code (Terraform)
* DevSecOps automation (GitHub Actions)
* Zero Trust security model
* Containerized microservices (ECS Fargate)
* Full observability (CloudWatch)

It is designed as a **real-world cloud architecture portfolio project** aligned with modern DevSecOps engineering roles.

---

## Platform Highlights

| Engineering Pillar | Production-Oriented Implementation |
|---|---|
| Secure access | GitHub OIDC federation, least-privilege IAM, Secrets Manager, and non-root containers |
| Automated delivery | Pull-request validation, Terraform plan/apply workflows, Checkov, and Trivy scanning |
| Resilient runtime | Multi-AZ load balancing, ECS Fargate, health checks, and target-tracking autoscaling |
| Operational visibility | CloudWatch dashboards, service alarms, and SNS email notifications |
| Controlled infrastructure | Modular Terraform with versioned remote state and DynamoDB locking |

---

## Architecture Decisions

This platform was designed following production engineering principles:

- Infrastructure as Code as the single source of truth
- Immutable deployments using Terraform
- Separation of infrastructure and application responsibilities
- Security-first architecture based on Zero Trust concepts
- Observability integrated from the beginning
- Modular design for future multi-environment expansion

The project intentionally prioritizes security, automation, and maintainability over rapid deployment.

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
AS[Application Auto Scaling] --> ECS

Secrets[AWS Secrets Manager] --> APP
IAM[IAM Roles - Least Privilege] --> APP

APP --> CWL[CloudWatch Logs]
ALB --> CWM[CloudWatch Metrics]
CWM --> AS
CWM --> ALARMS[CloudWatch Alarms]
ALARMS --> SNS[Amazon SNS]
SNS --> EMAIL[Email Notifications]
```

> **Note:** Current implementation uses public subnets with Security Group restrictions (ALB → ECS only). Migration to private subnets + NAT Gateway is included in the roadmap.

---

## Security Controls

### Implemented

| Control | Status |
|---|---|
| Least Privilege IAM | ✅ Implemented |
| Secrets Manager Integration | ✅ Implemented |
| Container Non-Root User | ✅ Implemented |
| Security Group Segmentation | ✅ Implemented |
| Infrastructure as Code | ✅ Implemented |
| Audit Logging | ✅ Implemented |
| CloudWatch Monitoring | ✅ Implemented |
| OIDC Federation | ✅ Implemented |
| Trivy + Checkov in CI/CD | ✅ Implemented |
| Terraform Remote State | ✅ Implemented |

### Planned

| Control | Status |
|---|---|
| AWS WAF | 🔲 Roadmap |
| Security Hub | 🔲 Roadmap |
| GuardDuty | 🔲 Roadmap |

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

GitHub Actions authenticates to AWS through short-lived OIDC credentials. Static AWS access keys are not stored in the repository.

<p align="center">
  <img src="docs/evidence/EVIDENCIA 8.png" width="800" alt="GitHub Actions - Terraform Apply success" />
</p>

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
    │   ├── iam-oidc/            # GitHub Actions OIDC federation
    │   └── ecs/
    │       ├── main.tf          # ECS cluster, task, service, ALB
    │       ├── iam.tf           # IAM roles + least privilege policies
    │       ├── secrets.tf       # AWS Secrets Manager
    │       ├── sns.tf           # Alarm email notifications
    │       └── monitoring.tf    # CloudWatch alarms + dashboard
    ├── bootstrap/               # One-time remote state resources
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

<p align="center">
  <img src="docs/evidence/EVIDENCIA 6.png" width="800" alt="CloudWatch dashboard: CPU, latency, 5xx" />
</p>

<p align="center">
  <img src="docs/evidence/EVIDENCIA 5.png" width="800" alt="CloudWatch alarms list" />
</p>

<p align="center">
  <img src="docs/evidence/EVIDENCIA 7.png" width="800" alt="SNS topic with confirmed email subscription" />
</p>

---

## Professional Skills Demonstrated

### Cloud Engineering
- AWS Networking (VPC, Subnets, IGW, Route Tables)
- ECS Fargate (serverless container orchestration)
- Application Load Balancing
- Secrets Management
- Monitoring and Logging

### DevOps
- Terraform (modular IaC)
- GitHub Actions (CI/CD automation)
- Infrastructure Lifecycle Management
- Ephemeral environment strategy

### Security
- Zero Trust Principles
- IAM Least Privilege
- Secure Secrets Handling
- Secure Container Practices (non-root user)

### Software Delivery
- GitOps Workflow
- Pull Request Validation
- Automated Deployments
- Change Control

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

<p align="center">
  <img src="docs/evidence/EVIDENCIA 9.png" width="300" alt="Health endpoint response from mobile browser" />
</p>

### Destroy
```bash
terraform destroy -auto-approve
```

---

## Deployment Evidence

The repository includes real infrastructure deployments validated in AWS:

- Terraform execution plans (18+ resources)
- ECS Fargate service running and responding
- CloudWatch dashboard active
- CI/CD pipeline execution via GitHub Actions

Screenshots and deployment evidence will be maintained as the project evolves.

<p align="center">
  <img src="docs/evidence/EVIDENCIA 10.png" width="800" alt="ALB details: Active, Internet-facing, multi-AZ" />
</p>

<p align="center">
  <img src="docs/evidence/EVIDENCIA 11.png" width="800" alt="ECS service: 1/1 tasks, target healthy" />
</p>

---

## Roadmap

- [ ] Private subnets + NAT Gateway
- [ ] staging and prod environments
- [ ] HTTPS with ACM certificate on ALB
- [ ] AWS WAF + GuardDuty + Security Hub

---

## Changelog

### 2026-07-21

- Replaced hardcoded application secrets with generated 24-character passwords.
- Connected all CloudWatch alarms to email notifications through Amazon SNS.
- Added CPU target-tracking autoscaling for the ECS service.
- Added versioned S3 remote state with DynamoDB locking and a one-time bootstrap module.
- Migrated GitHub Actions authentication from static access keys to AWS OIDC federation.
- Integrated Checkov IaC scanning and Trivy container scanning into the pull request pipeline.

---

## Business Value

This project demonstrates the ability to:

- Design secure cloud infrastructure from scratch
- Automate deployments through CI/CD pipelines
- Apply infrastructure security best practices
- Build maintainable and scalable cloud environments
- Operate production-oriented AWS workloads

The architecture reflects engineering decisions commonly found in modern cloud-native organizations.


---

## License

**Proprietary software — All Rights Reserved.**

Copyright © 2026 **Emanuel G. Michea**.

The source code, infrastructure definitions, documentation, architecture, and visual assets in this repository may not be copied, modified, redistributed, sublicensed, or used commercially without prior written authorization from the copyright holder.

For commercial licensing, implementation, consulting, or acquisition inquiries, contact:

[![LinkedIn](https://img.shields.io/badge/Contact-Emanuel%20G.%20Michea-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/emanuel-gonzalez-michea/)

See the [LICENSE](LICENSE) file for the complete terms.
