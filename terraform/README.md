# Secure SaaS Platform (AWS DevSecOps Project)

## 🚀 Overview
This project is a production-style SaaS cloud platform built on AWS using Infrastructure as Code (Terraform) and Kubernetes (EKS).

It demonstrates:
- Cloud Architecture (AWS VPC, EKS)
- DevSecOps practices
- Infrastructure as Code (Terraform)
- Scalable SaaS design principles

---

## 🧱 Architecture
- AWS VPC (isolated network)
- Public & Private Subnets
- Amazon EKS Cluster
- Managed Node Groups (EC2)
- IAM Roles & Policies

---

## 🔐 Security Design
- IAM least privilege roles
- Private subnets for worker nodes
- Controlled access to Kubernetes cluster

---

## ⚙️ Tech Stack
- AWS (EKS, VPC, IAM, EC2)
- Terraform
- Kubernetes
- Linux CLI

---

## 💰 Cost Control
⚠️ This project is designed for short-term deployment only.

Recommended workflow:
```bash
terraform apply
terraform destroy
