# 🏗️ AWS Infrastructure Project (Terraform + Python)

A comprehensive AWS infrastructure project built with **Terraform** and **Python**, demonstrating modular IaC design and automation skills.

> 💼 Ideal for your **Upwork portfolio** as an AWS Cloud Engineer.

---

## 📚 Project Overview

This project provisions and automates:

- VPC networking (multi-AZ, private/public subnets)
- EC2 Auto Scaling Group behind ALB
- RDS MySQL database (multi-AZ)
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
│   ├── database/
│   ├── monitoring/
│   ├── security/
│   └── backup/
│
├── scripts/
│   ├── deploy.sh
│   ├── destroy.sh
│   ├── send-alerts.py
│   └── check-backup-integrity.py
│
└── README.md
```

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

### 3. `modules/database`
- RDS MySQL in private subnets
- Parameter group and subnet group

### 4. `modules/monitoring`
- CloudWatch Alarms & Dashboards
- SNS topic for alerting
- AWS Config rules

### 5. `modules/security`
- IAM best practices (least privilege, MFA)
- Security Groups, KMS keys
- Security Hub, GuardDuty enabled
- Python script: `security-scan.py` (optional)

### 6. `modules/backup`
- AWS Backup plans for EC2, RDS, EBS
- Python script to verify snapshots and restore flow

---

## 🐍 Python Scripts

### ✅ `send-alerts.py`

Sends CloudWatch/SNS alerts:

```bash
python scripts/send-alerts.py
```

### 🔁 `check-backup-integrity.py`

Verifies backup snapshots (RDS & EBS):

```bash
python scripts/check-backup-integrity.py
```

---

## 🔐 IAM Roles & Permissions

- Each module uses least privilege IAM roles.
- Backup module requires `AWSBackupServiceRolePolicy`.
- SNS and CloudWatch integration requires publishing permissions.

---

## 🧠 What You Learn

- Modular Terraform design (scalable, reusable)
- Infrastructure monitoring & alerting
- Backup automation & DR strategy
- Real-world Python scripting for AWS ops
- Compliance & security hardening using native services

---

## 📸 Architecture Diagram

![AWS Infrastructure Diagram](./images/aws_architecture_diagram.png)

---

## ✅ Checklist

- [x] Networking module (VPC, subnets, NAT, IGW)
- [x] Compute module (ALB, ASG, EC2, EBS)
- [x] Database module (RDS MySQL)
- [x] Monitoring module (CloudWatch, Config, SNS)
- [x] Security module (IAM, GuardDuty, Security Hub)
- [x] Backup module (AWS Backup, Python restore check)
- [x] Python scripts for alerts and integrity
- [x] Shell scripts for deployment
- [x] Clean, readable Terraform code