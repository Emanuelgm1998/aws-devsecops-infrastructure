# Secure Multi-Tenant SaaS Platform

## Concepto
Plataforma SaaS en AWS que permite a múltiples empresas usar una API segura con aislamiento total por tenant.

## Arquitectura
- AWS ECS Fargate (serverless container orchestration)
- Application Load Balancer (ALB) multi-AZ
- Zero Trust security model & Security Group segmentation
- AWS Secrets Manager & OIDC GitHub Actions federation

## Componentes
- Microservicio REST API (Node.js)
- Cluster ECS & Task Definitions con usuario no-root
- Observabilidad CloudWatch (Logs, Métricas, Alarmas, Dashboards) y SNS
- Infraestructura modular como código (Terraform) con estado remoto en S3 y DynamoDB

## Principios
- Zero Trust
- Least privilege IAM
- Observability first
- Secure-by-design

