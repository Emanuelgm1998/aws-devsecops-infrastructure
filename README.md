
#Aquí tienes una versión sustancialmente mejorada y optimizada de tu **README.md**.

He pulido el diseño visual añadiendo una arquitectura en ASCII mucho más clara, una sección estructurada de **DevSecOps Hardening** (que vende mucho mejor tus habilidades de seguridad), íconos limpios, tablas estilizadas y bloques de código listos para copiar y pegar en un solo bloque de Markdown.

```markdown
# 🚀 AWS DevSecOps Infrastructure Platform

│ [Core Architecture](#-architecture) │ [Tech Stack](#-tech-stack) │ [Security Design](#-security-design-hardening) │ [CI/CD](#-cicd-pipeline) │ [Deployment](#-deployment-guide) │

---

Production-ready, highly secure, and compliant cloud infrastructure on AWS built with Terraform, adhering to **DevSecOps best practices and Zero Trust principles**. Fully automated and deployable via a single pipeline or CLI command.

## 🏗️ Architecture

```text
                  [ Internet ]
                       │
                       ▼  HTTPS (Port 443 / 80)
          ┌─────────────────────────┐
          │ Application Load Balancer│ (Public Subnets)
          └────────────┬────────────┘
                       │
                       ▼  HTTP (Port 3000) ──► Restricted via Security Groups
          ┌─────────────────────────┐
          │    AWS ECS Fargate      │ (Private Subnets)
          │  (Node.js Secure App)   │
          └───────┬─────────┬───────┘
                  │         │
                  │ IAM     ├───────────► [ AWS Secrets Manager ] (Runtime Injection)
                  ▼         │
        [ CloudWatch Logs ] └───────────► [ CloudWatch Metrics & Alarms ]

```

* **Infrastructure as Code:** Modular Terraform configuration designed for multi-environment scalability (`dev`, `staging`, `prod`).
* **CI/CD GitOps:** Fully automated delivery lifecycle powered by GitHub Actions.

---

## 🛠️ Tech Stack

| Layer | Component | Technology | Description |
| --- | --- | --- | --- |
| **Compute** | Container Orchestration | `AWS ECS Fargate` | Serverless, isolated container execution. |
| **Networking** | Infrastructure Isolation | `AWS VPC` | Multi-AZ architecture with public/private subnet isolation. |
| **Traffic Management** | Ingress | `AWS ALB` | Layer 7 routing with health checks and SSL/TLS termination hooks. |
| **Security** | Secrets Management | `AWS Secrets Manager` | Dynamic runtime credential rotation and ingestion. |
| **Security** | Identity & Access | `AWS IAM` | Strict Principle of Least Privilege (PoLP) policy mapping. |
| **Observability** | Monitoring & Alerting | `Amazon CloudWatch` | Structured logging, real-time metrics, automated alarms, and dashboards. |
| **Automation** | IaC & Pipelines | `Terraform` / `GitHub Actions` | Declarative definitions and integrated GitOps workflow. |
| **Application** | Microservice Runtime | `Node.js` + `Docker` | Containerized REST API running under a non-root user context. |

---

## 📂 Project Structure

```text
aws-devsecops-infrastructure/
├── .github/workflows/
│   ├── terraform-plan.yml      # Dry-run validation triggered on Pull Requests
│   └── terraform-apply.yml     # Automated deployment triggered on merge to main
├── app/
│   ├── index.js                # Lightweight Node.js REST API
│   ├── package.json            # Node.js dependencies
│   └── Dockerfile              # Distroless/Non-root secure container definition
└── terraform/
    ├── modules/
    │   ├── vpc/                # Network Topology: VPC, Subnets, IGW, Route Tables
    │   │   ├── main.tf & variables.tf & outputs.tf
    │   └── ecs/                # Compute, Security, IAM Policies & Observability
    │       ├── main.tf         # ECS Cluster, Task Definition, Service, and ALB
    │       ├── iam.tf          # Fine-grained Execution & Task Roles (PoLP)
    │       ├── secrets.tf      # Secure parameter store & secret structures
    │       └── monitoring.tf   # CloudWatch Dashboards and Alarm metrics
    └── environments/
        └── dev/                # Root environment execution context
            ├── main.tf         # Module instantiation backend mapping
            ├── variables.tf    # Dev-specific configuration variables
            └── outputs.tf      # Exposed deployment outputs

```

---

## 🔒 Security Design & Hardening

### 1. Principle of Least Privilege (PoLP)

The compute tier splits identity execution into two strictly decoupled IAM Roles:

* **ECS Task Execution Role:** Restricted to infrastructure startup requirements (`ecr:PullImage`, `logs:CreateLogStream`, `logs:PutLogEvents`).
* **ECS Task Role:** The execution context of the application container itself. It **only** possesses access to read its dedicated application secret from Secrets Manager and ship business logs to CloudWatch.

### 2. Zero-Trust Network Topology

* **ALB Protection:** Accepts public traffic exclusively on standard ingress web ports.
* **Service Isolation:** The ECS Fargate containers are situated within isolated network rings. They block all direct public internet ingress, accepting traffic **only** from the Application Load Balancer via a strict Security Group reference rule on port `3000`.

### 3. Runtime Secret Injection

No plaintext environment variables, configurations, or credentials ever hit the Git repository or build logs. Sensitive parameters are referenced by ARN within the Terraform definitions, pulling values securely at runtime from **AWS Secrets Manager**.

---

## 🚀 Deployment Guide

### Prerequisites

* AWS CLI configured (`aws configure`) with administrative or deployment permissions.
* Terraform CLI installed ($\ge$ 1.0).
* Docker engine running locally for building assets.

### Automated Local Bootstrap

Run the setup from the root environment directory:

```bash
cd terraform/environments/dev
terraform init
terraform apply -auto-approve

```

### Verification & Smoke Tests

Extract the dynamically generated load balancer endpoint and perform a secure curl validation:

```bash
# Fetch the active deployment URL
URL=$(terraform output -raw app_url)

# Run a validation request
curl -s http://$URL

```

Expected healthy response payload:

```json
{
  "status": "ok",
  "service": "secure-saas-platform",
  "version": "1.0.0",
  "timestamp": "2026-06-08T09:00:00.000Z"
}

```

### Resource Decommissioning (Cost Control)

Tear down all deployed cloud real estate instantly when testing is complete:

```bash
terraform destroy -auto-approve

```

---

## 📊 Observability & Thresholds

The platform provisions automated **CloudWatch Alarms** coupled with a unified **CloudWatch Dashboard** named `secure-saas-dashboard` monitoring the following baselines:

| Metric Trigger | Threshold Value | Evaluation Period | Severity | Action |
| --- | --- | --- | --- | --- |
| **High CPU Utilization** | `> 80%` | 2 consecutive mins | Warning | Scale / Alert |
| **ALB Target Response Time** | `> 2000ms` | 1 minute | Error | Dev Team Alert |
| **HTTP 5xx Error Spike** | `> 5 errors` | 1 minute | Critical | Incident Response |

---

## 💸 Cost Optimization Profile

Engineered explicitly for ephemeral usage, automated testing, and sandbox validation:

| AWS Resource Service Element | Cost per Test Run (~15 Mins) |
| --- | --- |
| **AWS ECS Fargate** | ~$0.01 |
| **Application Load Balancer** | ~$0.01 |
| **CloudWatch Log Engine** | AWS Free Tier |
| **Networking Infrastructure (VPC)** | Included ($0.00) |
| **AWS Secrets Manager Storage** | Free Tier Window |
| 💰 **Estimated Run Cost** | **~$0.02 per session** |

---

## 👨‍💻 Author

**Emanuel GM** — Cloud & DevSecOps Engineer

```

```
