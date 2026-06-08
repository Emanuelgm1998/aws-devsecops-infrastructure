
# Production-Ready AWS DevSecOps Infrastructure Platform

<p align="center">

<img src="https://img.shields.io/badge/AWS-232F3E?style=for-the-badge&logo=amazon-aws&logoColor=white" />
<img src="https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white" />
<img src="https://img.shields.io/badge/GitHub_Actions-2088FF?style=for-the-badge&logo=github-actions&logoColor=white" />
<img src="https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white" />
<img src="https://img.shields.io/badge/DevSecOps-Zero_Trust-red?style=for-the-badge" />

</p>

---

## 👤 Engineer Profile

**Emanuel Ernesto González Michea**
Emanuel Ernesto González Michea

Portfolio & professional profile:
LinkedIn
[https://www.linkedin.com/in/emanuel-gonzalez-michea/](https://www.linkedin.com/in/emanuel-gonzalez-michea/)

---

## 🧭 Overview

This repository implements a **production-grade, multi-AZ AWS infrastructure platform** built with:

* Infrastructure as Code (Terraform)
* DevSecOps automation (GitHub Actions)
* Zero Trust security model
* Containerized microservices (ECS Fargate)
* Full observability (CloudWatch)

It is designed as a **real-world cloud architecture portfolio project** aligned with modern DevSecOps engineering roles.

---

## 🏗️ High-Level Architecture

```mermaid
flowchart TD

User[Internet Client] --> ALB[Application Load Balancer]

subgraph VPC[AWS VPC - Multi AZ]
    
    subgraph Public[Public Subnets]
        ALB
    end

    subgraph Private[Private Subnets]
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

---

## 🔐 Zero Trust Security Model

### Identity & Access Control

* Separate IAM roles:

  * ECS Task Execution Role (infra only)
  * ECS Task Role (application permissions only)
* Principle of Least Privilege enforced at every layer

### Network Security

* Private subnets for compute layer (no public IPs)
* Only ALB exposed to internet (HTTPS 443)
* Security Group strict inbound rules (ALB → ECS only)

### Secrets Management

* No hardcoded credentials
* Runtime injection via AWS Secrets Manager
* Secure environment variable resolution at container startup

---

## 🔄 CI/CD Pipeline (GitOps)

```mermaid
flowchart LR

PR[Pull Request] --> PLAN[Terraform Plan - GitHub Actions]
PLAN --> REVIEW[Code Review / Validation]
REVIEW --> MERGE[Merge to Main]
MERGE --> APPLY[Terraform Apply]
APPLY --> AWS[Deploy to AWS]

AWS --> MON[CloudWatch Monitoring]
```

---

## 🧱 Infrastructure Stack

| Layer         | Service               | Purpose                    |
| ------------- | --------------------- | -------------------------- |
| Compute       | AWS ECS Fargate       | Serverless containers      |
| Networking    | AWS VPC + ALB         | Secure traffic routing     |
| Security      | IAM + Secrets Manager | Zero Trust identity model  |
| Observability | CloudWatch            | Logs, metrics, alarms      |
| IaC           | Terraform             | Declarative infrastructure |
| CI/CD         | GitHub Actions        | Automated deployment       |

---

## 📁 Project Structure

```text
aws-devsecops-infrastructure/

├── .github/workflows/
│   ├── terraform-plan.yml
│   └── terraform-apply.yml

├── app/
│   ├── index.js
│   ├── Dockerfile
│   └── package.json

└── terraform/
    ├── modules/
    │   ├── vpc/
    │   └── ecs/
    │       ├── main.tf
    │       ├── iam.tf
    │       ├── secrets.tf
    │       └── monitoring.tf
    └── environments/
        └── dev/
```

---

## 📡 Observability & Monitoring

* Centralized CloudWatch Dashboard
* Real-time alerting system
* Application + infrastructure metrics

### Alert Rules

| Metric    | Threshold | Action                |
| --------- | --------- | --------------------- |
| CPU Usage | > 80%     | Alert / Scale trigger |
| HTTP 5xx  | > 5/min   | Critical alert        |
| Latency   | > 2s      | Performance warning   |

---

## 💸 Cost Optimization Strategy

* ECS Fargate: pay-per-use compute model
* Ephemeral environments (terraform destroy)
* Free-tier optimized monitoring
* Minimal always-on resources

Estimated cost per test deployment:
👉 ~$0.02 per execution cycle

---

## 🚀 Deployment

```bash
cd terraform/environments/dev
terraform init
terraform apply -auto-approve
```

### Destroy stack

```bash
terraform destroy -auto-approve
```

---

## 🧠 Key DevSecOps Principles Demonstrated

* Zero Trust Architecture
* Immutable infrastructure
* GitOps-based deployments
* Least privilege IAM design
* Secrets isolation
* Multi-AZ resiliency
* Observability-first design

---

## 🧾 Why this project matters

This project demonstrates **production-level thinking**, not just AWS usage:

* Security-first design (not afterthought)
* Real CI/CD pipeline (like enterprise teams)
* Scalable container architecture
* Recruiter-ready documentation
* Cloud engineering maturity

