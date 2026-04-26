# ☁️ Huawei Cloud Serverless FinOps & Audit Engine

> **Enterprise-Grade Serverless FinOps Platform**  
> Autonomous, event-driven cloud cost optimization and audit engine built on Huawei Cloud.

---

<div align="center">

![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white)
![Huawei Cloud](https://img.shields.io/badge/Huawei_Cloud-E60012?style=for-the-badge&logo=huawei&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![Serverless](https://img.shields.io/badge/Serverless-FD5750?style=for-the-badge&logo=serverless&logoColor=white)

</div>
---

## 🌍 Overview

Enterprise cloud environments often suffer from **hidden cost inefficiencies** — unused storage, detached volumes, and forgotten resources silently accumulating expenses.

This project introduces a **Serverless FinOps & Audit Engine** that:

- Detects idle cloud resources automatically  
- Quantifies wasted storage and cost impact  
- Provides actionable insights  
- Operates fully autonomously  

Built using **Huawei Cloud native services**, this platform demonstrates how organizations can implement **continuous cost governance (FinOps)** using cloud-native principles.

---

## 🎯 Vision

> "You can't optimize what you don't continuously audit."

This system enforces:

- Zero-Waste Infrastructure  
- Continuous Cost Visibility  
- Autonomous Cloud Governance  

---

## 🏗️ Architecture

### 🔁 Event-Driven Serverless Workflow

```mermaid
flowchart LR

A[⏰ CRON Trigger<br/>03:00 AM Daily] --> B[⚡ FunctionGraph<br/>Audit Engine]
B --> C[🔍 EVS Scan<br/>Idle Disk Detection]
C --> D[📊 Cost Analysis<br/>Wasted Storage]
D --> E[📄 Logs & Insights]
```

---

## 🧠 Architecture Breakdown

### 1️⃣ Serverless Compute (FunctionGraph)

- Runs only when triggered → **zero idle cost**
- Fully scalable execution model  
- Python-based audit engine  

---

### 2️⃣ Event-Driven Automation

- Scheduled via CRON trigger (daily at 03:00 AM)  
- Fully autonomous execution  

---

### 3️⃣ Resource Audit Logic

- Scans EVS (Elastic Volume Service) disks  
- Detects:
  - Detached volumes (`available`)  
  - Idle storage resources  
- Calculates wasted storage (GB)  

---

### 4️⃣ FinOps Insights

- Generates structured logs  
- Provides cost optimization insights  
- Enables governance reporting  

---

### 5️⃣ Security (IAM)

- Uses **least-privilege IAM policy**
- `EVS ReadOnlyAccess`
- No mutation permissions → audit-only mode  

---

### 6️⃣ Infrastructure as Code (Terraform)

- Provisions:
  - IAM roles  
  - FunctionGraph  
  - CRON triggers  
  - Deployment packages  

✔ Reproducible  
✔ Version-controlled  
✔ Fully automated  

---

## 📊 Observability & Monitoring (SRE)

The platform integrates a **production-grade observability stack** aligned with modern **SRE practices**, provisioned via **Terraform and Helm**.

---

### 🔍 Monitoring Stack

- **Prometheus**
  - Auto-discovers Kubernetes services  
  - Scrapes metrics from:
    - FastAPI endpoints (`/metrics`)  
    - Kubernetes nodes  
  - Stores time-series data  

- **Grafana**
  - Pre-configured dashboards  
  - Visualizes:
    - Cluster health  
    - CPU & memory usage  
    - HTTP error rates  
    - Request throughput  

---

### ⚙️ Deployment Model

```bash
terraform apply
```

Automatically:

- Installs `kube-prometheus-stack` via Helm  
- Deploys Prometheus Operator  
- Configures Grafana dashboards  
- Enables ServiceMonitor-based discovery  

---

### 📡 Capabilities

- Auto service discovery  
- Centralized monitoring  
- Real-time metrics  
- Scalable observability  
- Infrastructure as Code  

---

### 🚨 Optional Extensions

- Alertmanager (Slack / Email alerts)  
- SLO / SLI tracking  
- Distributed tracing (Jaeger)  
- Log aggregation (Loki / ELK)  

---

## 📂 Repository Structure

```text
.
├── infrastructure/
│   ├── provider.tf
│   ├── iam.tf
│   └── function.tf
│
└── src/
    ├── audit_engine.py
    └── requirements.txt
```

---

## 🚀 Deployment Guide

### ⚙️ Prerequisites

- Terraform (v1.0+)  
- Python 3.10+  
- Huawei Cloud credentials  

---

### 1️⃣ Initialize

```bash
cd infrastructure
terraform init
```

---

### 2️⃣ Plan

```bash
terraform plan
```
---

### 3️⃣ Apply

```bash
terraform apply -auto-approve
```

---

## ⚡ Runtime Behavior

- Runs daily at **03:00 AM**  
- Scans `tr-west-1` region  
- Detects idle EVS disks  
- Calculates wasted storage  
- Outputs cost insights  

---

## 📊 Example Output

```text
[INFO] Scanning EVS volumes in region: tr-west-1
[INFO] Found 5 idle volumes
[INFO] Total wasted storage: 320 GB
[INFO] Estimated monthly waste: $XX
```

---

## 💡 Key Capabilities

- Serverless FinOps engine  
- Automated cloud auditing  
- Real-time cost insights  
- Secure IAM model  
- Event-driven execution  
- Fully automated lifecycle  

---

## 🧠 What This Project Demonstrates

- FinOps practices  
- Serverless architecture  
- Cloud cost optimization  
- Secure IAM usage  
- Automated governance  
- Infrastructure as Code  

---

## 👨‍💻 Developer

**Ali Gaffar Toksoy**

Cloud Engineering • DevOps • FinOps  

> "Cloud isn't expensive — unmanaged cloud is."

---

## ⭐ Final Note

This project demonstrates how **cloud cost optimization can be automated**.

Instead of manually tracking costs, the system:

✔ Detects waste  
✔ Quantifies impact  
✔ Enables optimization  

All in a fully automated, cloud-native workflow.

If you found this useful, consider giving it a ⭐

---
