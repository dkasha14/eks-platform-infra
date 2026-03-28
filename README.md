# 🚀 EKS Modular Terraform Infrastructure

This project demonstrates a **production-grade, modular Infrastructure as Code (IaC) setup** using Terraform to provision and manage Amazon EKS clusters across multiple environments.
It is designed to reflect **real-world DevOps practices**, focusing on scalability, reusability, environment isolation, and operational clarity.

---

## 📌 Project Overview

The primary objective of this project is to build a **clean, reusable, and environment-aware Kubernetes infrastructure** on AWS.

This implementation emphasizes:

* Modular Terraform architecture for maintainability and reuse
* Multi-environment support (dev, sit, preprod, prod) with strict isolation
* Secure and scalable EKS cluster deployment
* Automated node scaling using Kubernetes Cluster Autoscaler
* Clear Git history for traceability and interview readiness

---

## 🏗️ Architecture Structure

```
eks-platform-infra/
│
├── environments/
│   ├── dev/
│   ├── sit/
│   ├── preprod/
│   └── prod/
│
├── modules/
│   ├── vpc/
│   ├── eks/
│   ├── nodegroups/
│   └── autoscaler/
│
├── providers.tf
├── locals.tf
└── outputs.tf
```

This structure separates **core infrastructure logic (modules)** from **environment-specific configurations**, ensuring scalability and clarity.

---

## 📦 Modules Explanation

### 1️⃣ VPC Module (`modules/vpc`)

The VPC module is responsible for building the foundational networking layer required for the EKS cluster.

It performs the following:

* Creates a custom VPC using a defined CIDR block
* Configures public and private subnets across multiple availability zones
* Attaches an Internet Gateway for public connectivity
* Defines route tables to control traffic flow

👉 This module ensures that the cluster is deployed within a **secure, well-structured network boundary**.

---

### 2️⃣ EKS Module (`modules/eks`)

The EKS module provisions the Kubernetes control plane and integrates it with the networking layer.

It includes:

* Creation of the EKS cluster
* Integration with VPC subnets
* Enabling OIDC provider for IAM-based authentication (IRSA)
* Support for configurable Kubernetes versions

👉 This module represents the **core Kubernetes control plane**, enabling workload orchestration.

---

### 3️⃣ Nodegroups Module (`modules/nodegroups`)

This module defines the compute layer of the cluster by creating managed node groups.

It includes:

* Separate public and private node groups
* Launch template integration for SSH access
* Configurable instance types for flexibility
* Auto-scaling parameters (min, max, desired)
* Kubernetes labels for workload scheduling
* IAM roles and policies for node permissions

👉 This module provides **scalable worker nodes**, allowing workloads to run efficiently.

---

### 4️⃣ Autoscaler Module (`modules/autoscaler`)

The autoscaler module enables dynamic scaling of nodes based on workload demand.

It implements:

* IAM Roles for Service Accounts (IRSA)
* Secure IAM role creation using OIDC trust
* Integration with Kubernetes Cluster Autoscaler

👉 This module ensures **cost optimization and automatic scaling**, which is critical in production systems.

---

## 🌍 Environment Design

Each environment is isolated and independently configurable using its own Terraform configuration and state.

| Environment | Purpose                                                    |
| ----------- | ---------------------------------------------------------- |
| dev         | Used for development and initial testing of infrastructure |
| sit         | Used for system integration testing and validation         |
| preprod     | Used as a staging environment before production            |
| prod        | Used for live production workloads                         |

Each environment contains:

* `main.tf` → defines module orchestration
* `variables.tf` → declares input variables
* `outputs.tf` → exposes useful outputs
* `<env>.tfvars` → holds environment-specific values
* `backend.tf` → configures remote state

👉 This design ensures **strict isolation, safety, and reproducibility across environments**.

---

## 🔐 Remote State Management

Terraform state is stored remotely using:

* **S3 bucket** → stores the state file
* **DynamoDB table** → handles state locking

Example configuration:

```
key = "sit/terraform.tfstate"
```

Each environment uses a different key, ensuring:

* No overlap between environments
* Safe concurrent operations
* Better state management

👉 This setup is essential for **team collaboration and production-grade deployments**.

---

## ⚙️ Configuration Files Explained

### `main.tf`

This file orchestrates the infrastructure by calling different modules and wiring dependencies between them.

### `variables.tf`

Defines all input variables required for the environment, ensuring flexibility and reusability.

### `outputs.tf`

Exposes important outputs such as IAM roles or cluster details for integration and visibility.

### `*.tfvars`

Contains environment-specific values like:

* CIDR ranges
* cluster names
* node sizes
* scaling configurations

👉 Together, these files provide a **clean separation of logic and configuration**.

---

## 🚀 Execution Workflow

### Step 1: Navigate to Environment

```bash
cd environments/dev
```

---

### Step 2: Initialize Terraform

```bash
terraform init
```

This step downloads providers and configures backend state.

---

### Step 3: Validate Configuration

```bash
terraform validate
```

Ensures that Terraform syntax and structure are correct before execution.

---

### Step 4: Plan Deployment

```bash
terraform plan -var-file=dev.tfvars
```

Shows a preview of resources that will be created or modified.

---

### Step 5: Apply Infrastructure

```bash
terraform apply -var-file=dev.tfvars
```

Creates the infrastructure in AWS based on the configuration.

---

## 🔑 Cluster Access

### Update kubeconfig

```bash
aws eks update-kubeconfig --region us-east-1 --name <cluster-name>
```

This configures kubectl to interact with the cluster.

---

### Verify Nodes

```bash
kubectl get nodes
```

Confirms that worker nodes are successfully registered.

---

## 🔧 Key Features Implemented

* Modular Terraform architecture for reusability
* Multi-environment infrastructure design
* EKS cluster provisioning with configurable versions
* Managed node groups with scaling support
* Cluster Autoscaler using IRSA
* Secure SSH access via launch templates
* Remote state management with locking
* Clean and meaningful Git commit history

👉 These features collectively demonstrate a **real-world production-ready DevOps setup**.

---

## 🧠 Design Decisions

* Modules are used instead of a monolithic approach to improve maintainability and reuse
* Separate environments ensure safety and prevent accidental impact across stages
* IRSA is used instead of static credentials for better security
* Launch templates are used to enable SSH due to EKS constraints
* Descriptive commit messages improve traceability and understanding

👉 Each decision aligns with **industry best practices**.

---

## ⚠️ Important Notes

* `.tfvars` files are included intentionally for demonstration and interview purposes
* In production systems, sensitive data should be managed using secure solutions like AWS Secrets Manager
* SSH access is enabled for debugging but should be restricted in real environments

---

## 🚀 Future Enhancements

* Integration with CI/CD pipelines (Jenkins or GitHub Actions)
* Monitoring using Prometheus and Grafana
* Centralized logging using ELK stack or CloudWatch
* Chaos engineering experiments for resilience testing

---

## 👩‍💻 Author

**Asha**
DevOps & AI-DevOps Engineer 

---

## 📌 Summary

This project showcases the ability to design and implement:

* Scalable cloud infrastructure
* Modular Terraform architecture
* Kubernetes cluster management on AWS
* Real-world debugging and problem-solving
* Clean and professional Git practices



