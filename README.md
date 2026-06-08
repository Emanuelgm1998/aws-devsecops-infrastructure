
# 🚀 Production-Ready AWS DevSecOps Infrastructure Platform

<p align="center">
  <img src="https://img.shields.io/badge/AWS-232F3E?style=for-the-badge&logo=amazon-aws&logoColor=white" alt="AWS" />
  <img src="https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white" alt="Terraform" />
  <img src="https://img.shields.io/badge/GitHub_Actions-2088FF?style=for-the-badge&logo=github-actions&logoColor=white" alt="CI/CD" />
  <img src="https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white" alt="Docker" />
  <img src="https://img.shields.io/badge/Security-DevSecOps-red?style=for-the-badge" alt="Security" />
</p>

---

## 📝 Overview

This repository contains a fully automated, production-ready, and highly secure cloud infrastructure on AWS engineered with Terraform. Adhering to strict **DevSecOps practices and Zero-Trust Architecture guidelines**, this multi-AZ containerized platform can be safely deployed or destroyed using single-line commands or integrated GitOps pipelines.

## 🏗️ Architecture

```mermaid
graph TD
    %% Define Styles
    classDef internet fill:#f9f9f9,stroke:#333,stroke-width:2px;
    classDef public fill:#e1f5fe,stroke:#0288d1,stroke-width:2px;
    classDef private fill:#efebe9,stroke:#5d4037,stroke-width:2px;
    classDef security fill:#ffebee,stroke:#c62828,stroke-width:1px;
    classDef logging fill:#f1f8e9,stroke:#558b2f,stroke-width:1px;

    %% Ingress Traffic
    User([Internet Client]) -->|HTTPS / Port 443| ALB[Application Load Balancer]
    class User internet;
    class ALB public;

    subgraph AWS VPC Cluster [Amazon VPC Context]
        subgraph Public Subnets [Public Subnet Layer]
            ALB
        end

        subgraph Private Subnets [Private Subnet Layer]
            direction LR
            ECS[AWS ECS Fargate Cluster]
            App[Node.js App Container]
            ECS --- App
        end
    end
    class Public Subnets public;
    class Private Subnets private;

    %% Traffic Rules
    ALB -->|HTTP / Port 3000 Only| ECS

    %% Identity & Secrets Linkage
    Secrets[(AWS Secrets Manager)] -.->|Secure Runtime Injection| App
    IAM[IAM Task Role <br> Principle of Least Privilege] ===>|Execution Token| App
    class Secrets,IAM security;

    %% Telemetry Data Flow
    App ---->|Structured Logs| CW_Logs[CloudWatch Logs Engine]
    ALB ---->|Telemetry Metrics| CW_Metrics[CloudWatch Alarms & Dashboards]
    class CW_Logs,CW_Metrics logging;

```

---

## 🛠️ Infrastructure Stack

| Architecture Layer | Core Component | Component Technology | Technical Objective / Implementation |
| --- | --- | --- | --- |
| **Compute** | Container Runtime | `AWS ECS Fargate` | Serverless container abstraction; eliminates EC2 host lifecycle management. |
| **Networking** | Edge Ingress | `AWS ALB (Layer 7)` | Public-facing distribution with built-in health checks and routing mechanics. |
| **Networking** | Boundary Isolation | `AWS VPC` | Multi-AZ architecture segmenting public (Ingress) and private (App) subnets. |
| **Security** | Secrets Engine | `AWS Secrets Manager` | Decoupled runtime injection of data stores credentials and environment secrets. |
| **Security** | Identity & Access | `AWS IAM` | Fine-grained execution task mapping based on the Principle of Least Privilege (PoLP). |
| **Observability** | Telemetry / Audit | `Amazon CloudWatch` | Aggregated logging streams, anomalous performance alarms, and telemetry dashboards. |
| **Automation** | Orchestration / IaC | `Terraform / OpenTofu` | Strictly declarative configuration files built for scaling environments (`dev`, `prod`). |

---

## 📂 Repository Topology

```text
aws-devsecops-infrastructure/
├── .github/workflows/
│   ├── terraform-plan.yml      # Triggered on Pull Requests: Dry-run schema validations
│   └── terraform-apply.yml     # Triggered on Main Merges: Automated state execution
├── app/
│   ├── index.js                # Minimalist Node.js microservice REST endpoint
│   ├── package.json            # Application dependencies manifest
│   └── Dockerfile              # Hardened, non-root user execution container specification
└── terraform/
    ├── modules/
    │   ├── vpc/                # Network Foundation: Gateways, Subnets, and Routing Tables
    │   └── ecs/                # Elastic Compute, Access Control, and Telemetry Engine
    │       ├── main.tf         # Main declaration for ECS Cluster, Task, Service, and ALB
    │       ├── iam.tf          # Least privilege policy scopes for Task and Execution Roles
    │       ├── secrets.tf      # Dynamic configuration wrappers for AWS Secrets Manager
    │       └── monitoring.tf   # CloudWatch metric tracking and threshold alarms
    └── environments/
        └── dev/                # Live Environment instantiation point

```

---

## 🔒 Hardening & DevSecOps Strategy

### 🛡️ 1. IAM Decoupled Permissions

The execution tier completely isolates platform start-up duties from runtime activities by provisioning dos identidades distintas:

* **ECS Task Execution Role:** Grants permissions strictly to the AWS ECS engine to pull images from container registries and create basic logging structures (`logs:CreateLogStream`).
* **ECS Task Role:** The processing scope granted to the application microservice itself. It is limited to reading the exact cryptographic secret string path from Secrets Manager and pushing metric traces to CloudWatch.

### 🔌 2. Restrictive Security Perimeters

* **Public Shielding:** The Application Load Balancer accepts incoming internet packets explicitly on standard port profiles (`80`/`443`).
* **Zero-Trust East-West Traffic:** The compute node executes inside completely closed subnets. It rejects all public inbound routing, exclusively acknowledging traffic entering through the security group hash belonging to the Load Balancer on port `3000`.

### 🔑 3. Zero Hardcoded Metadata

Sensitive configurations, tokens, or encryption keys are not embedded into application bundles or repository tracking trees. Variables are mapped as dynamic parameters injected straight into target node processes at runtime via **AWS Secrets Manager**.

---

## 🚀 Deployment Guide

### System Prerequisites

* AWS CLI initialized with active administrator or deployment credentials.
* Terraform CLI Installed ($\ge$ 1.0).
* Local Docker daemon up and running.

### One-Command Deployment Setup

Move into the target workspace context and execute the deployment:

```bash
cd terraform/environments/dev
terraform init
terraform apply -auto-approve

```

### Integration Smoke-Testing

Query the infrastructure deployment parameters, fetch the load balancer endpoint, and verify response payloads:

```bash
# Extract the public endpoint domain
PLATFORM_URL=$(terraform output -raw app_url)

# Execute the curl health checker request
curl -s http://$PLATFORM_URL

```

**Expected JSON Response Matrix:**

```json
{
  "status": "ok",
  "service": "secure-saas-platform",
  "version": "1.0.0",
  "timestamp": "2026-06-08T09:15:00.000Z"
}

```

### Clean-Up & Cost Control

Instantly purge all provisioned components to prevent unnecessary billing:

```bash
terraform destroy -auto-approve

```

---

## 📊 Telemetry and Real-Time Monitors

The monitoring module provisions a centralized **CloudWatch Dashboard** (`secure-saas-dashboard`) linked directly with automated alarm triggers:

| Telemetry Target | Defined Alarm Threshold | Evaluation Window | System Actions |
| --- | --- | --- | --- |
| **High CPU Consumption** | `> 80% Utilization` | 2 Continuous Cycles | Automated Alert / Scale Action |
| **ALB Outbound Latency** | `> 2000 ms` | 1 Minute | DevSecOps Alert Dispatch |
| **Application Failures** | `> 5 HTTP 5xx Errors` | 1 Minute | Critical System Alert |

---

## 💸 Ephemeral Cost Tracking Profile

Optimized to handle Sandbox automation, pipeline verification, and ephemeral test deployments:

| Cloud Architecture Module | Financial Estimate / Session (15 Mins) |
| --- | --- |
| **AWS ECS Fargate Compute Engine** | ~$0.01 |
| **Application Load Balancer Ingress** | ~$0.01 |
| **Amazon CloudWatch Telemetry Engine** | Included inside Free Tier allowance |
| **AWS VPC Networking Components** | Always Free ($0.00) |
| **AWS Secrets Manager Storage** | Active Trial Evaluation Window |
| 🧮 **Projected Cost Metrics** | **~$0.02 Total per Run** |

---

## 👨‍💻 Engineer Portfolio

**Emanuel GM** — Cloud & DevSecOps Engineer

```

```
