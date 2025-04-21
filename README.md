# 🏗️ AWS Infrastructure Project (Terraform + Python)

A comprehensive AWS infrastructure project built with **Terraform** and **Python**, demonstrating modular IaC design and automation skills.

>

---

## 📚 Project Overview

This project provisions and automates:

- VPC networking (multi-AZ, private/public subnets)
- EC2 Auto Scaling Group behind ALB
- Monitoring and alerting with CloudWatch + SNS
- Security hardening (IAM, Security Hub, GuardDuty)
- Backup & disaster recovery automation
- Python scripts for alerts, backup verification, and compliance

---

## 📁 Folder Structure

```
aws-infra-project/
│
├── main.tf                  # Root configuration
├── variables.tf             # Root input variables
├── outputs.tf               # Root outputs
├── provider.tf              # AWS provider config
├── terraform.tfvars         # Optional values file
│
├── modules/
│   ├── networking/
│   ├── compute/
│   ├── monitoring/
│   ├── security/
│   └── backup/
│
├── scripts/
│   ├── deploy.sh
│   ├── destroy.sh
│   └── send-alerts.py
└── README.md
---

## 🛠️ How to Use

### 📦 1. **Install Requirements**

- Terraform ≥ 1.4
- Python 3.9+
- AWS CLI configured (`aws configure`)
- IAM user with sufficient permissions

### 🧱 2. **Deploy Infrastructure**

```bash
cd aws-infra-project
chmod +x scripts/deploy.sh
./scripts/deploy.sh
```

---

### 🧨 3. **Destroy Infrastructure**

```bash
./scripts/destroy.sh
```

---

## 🔧 Modules Overview

### 1. `modules/networking`
- VPC with private/public subnets (multi-AZ)
- Internet Gateway, route tables, NAT Gateway

### 2. `modules/compute`
- Auto Scaling EC2 instances in public subnets
- ALB with target groups and listeners
- EBS volumes for EC2
- Bastion Host (optional)

### 3. `modules/monitoring`
- CloudWatch Alarms & Dashboards
- SNS topic for alerting
- AWS Config rules

### 4. `modules/security`
- IAM best practices (least privilege, MFA)
- Security Groups, KMS keys
- Security Hub, GuardDuty enabled
- Python script: `security-scan.py` (optional)

### 5. `modules/backup`
- AWS Backup plans for EC2, RDS, EBS
- Python script to verify snapshots and restore flow

---

## 🐍 Python Scripts

### ✅ `send-alerts.py`

Sends CloudWatch/SNS alerts:

```bash
python scripts/send-alerts.py
```
---

## 🔐 IAM Roles & Permissions

- Each module uses least privilege IAM roles.
- Backup module requires `AWSBackupServiceRolePolicy`.
- SNS and CloudWatch integration requires publishing permissions.

---

## 📸 Architecture Diagram

![AWS Infrastructure Diagram](./images/aws_architecture_diagram.png)

---

