# Phase 0 – Final Project Goal

**Project Duration:** Entire Project  
**Difficulty Level:** Intermediate to Advanced  
**Project Type:** Enterprise Infrastructure as Code (IaC)

---

# 🎯 Goal

The objective of this project is to design, build, and manage a **production-ready AWS infrastructure** using **Terraform** while following enterprise best practices.

Throughout this project, you will learn how to provision scalable, secure, and highly available cloud infrastructure for a real-world Spring Boot application.

By the end of this project, you will have built an infrastructure that closely resembles what many organizations use in production environments.

---

# 📌 Project Overview

| Item | Details |
|------|---------|
| **Project Name** | `terraform-aws-infrastructure` |
| **Application** | LinkedIn Clone (Spring Boot) |
| **Cloud Platform** | Amazon Web Services (AWS) |
| **Infrastructure as Code (IaC)** | Terraform |
| **Version Control** | Git & GitHub |
| **Operating System** | Ubuntu Linux |
| **Database** | PostgreSQL RDS |
| **Load Balancer** | Application Load Balancer (ALB) |
| **Compute** | Amazon EC2 |
| **Scaling** | Auto Scaling Group |
| **Monitoring** | Amazon CloudWatch |
| **State Management** | Amazon S3 + DynamoDB |
| **Architecture** | Modular & Enterprise-Grade |

---

# 🏗️ Final Architecture

By the end of this project, the deployed application will follow the architecture shown below.

```text
                    Internet
                        │
                        ▼
        Application Load Balancer (ALB)
                        │
                        ▼
          Auto Scaling Group (ASG)
                        │
          ┌─────────────┴─────────────┐
          ▼                           ▼
     EC2 Instance                EC2 Instance
 (LinkedIn Clone App)      (LinkedIn Clone App)
          │                           │
          └─────────────┬─────────────┘
                        ▼
               PostgreSQL RDS
```

---

# 🧩 Infrastructure Components

The project will include the following AWS services.

| AWS Service | Purpose |
|-------------|---------|
| **Amazon VPC** | Provides an isolated virtual network for the infrastructure. |
| **Public & Private Subnets** | Separates internet-facing and internal resources. |
| **Internet Gateway** | Enables internet access for public resources. |
| **NAT Gateway** | Allows private resources to access the internet securely. |
| **Route Tables** | Controls network traffic routing. |
| **Security Groups** | Acts as virtual firewalls for AWS resources. |
| **IAM Roles** | Grants secure permissions to AWS services. |
| **Application Load Balancer (ALB)** | Distributes incoming traffic across EC2 instances. |
| **Auto Scaling Group (ASG)** | Automatically adjusts the number of EC2 instances based on demand. |
| **Amazon EC2** | Hosts the LinkedIn Clone Spring Boot application. |
| **Amazon RDS (PostgreSQL)** | Managed relational database service for application data. |
| **Amazon CloudWatch** | Monitors infrastructure metrics, logs, and alarms. |
| **Amazon S3** | Stores the remote Terraform state file. |
| **Amazon DynamoDB** | Provides state locking for Terraform. |

---

# 🚀 Technologies Used

| Category | Technology |
|----------|------------|
| Infrastructure as Code | Terraform |
| Cloud Platform | AWS |
| Programming Language | Java |
| Framework | Spring Boot |
| Database | PostgreSQL |
| Version Control | Git |
| Repository Hosting | GitHub |
| Monitoring | Amazon CloudWatch |
| IDE | Visual Studio Code |

---

# 📈 What You Will Learn

By completing this project, you will gain hands-on experience with:

- Building enterprise-grade AWS infrastructure using Terraform.
- Writing reusable and modular Terraform code.
- Managing Terraform state securely with S3 and DynamoDB.
- Creating scalable networking using VPC, subnets, and route tables.
- Configuring secure access with IAM and Security Groups.
- Deploying Spring Boot applications on EC2.
- Using Application Load Balancers for traffic distribution.
- Implementing Auto Scaling Groups for high availability.
- Provisioning and connecting a PostgreSQL RDS database.
- Monitoring AWS resources with CloudWatch.
- Following Infrastructure as Code (IaC) best practices.
- Managing infrastructure using Git and GitHub.

---

# 📦 Expected Outcome

At the end of this project, you will have:

- ✅ A production-ready Terraform project.
- ✅ Modular and reusable Terraform code.
- ✅ Automated AWS infrastructure deployment.
- ✅ A scalable Spring Boot application hosted on AWS.
- ✅ Secure remote Terraform state management.
- ✅ Monitoring and logging with CloudWatch.
- ✅ Professional project documentation.
- ✅ A portfolio-ready GitHub repository.

---

# 🎯 Project Success Criteria

The project will be considered successful when:

- The infrastructure is fully managed using Terraform.
- The LinkedIn Clone application is accessible through the Application Load Balancer.
- EC2 instances scale automatically using an Auto Scaling Group.
- The application connects successfully to a PostgreSQL RDS database.
- Terraform state is stored remotely in Amazon S3 with state locking enabled using DynamoDB.
- All infrastructure components follow AWS and Terraform best practices.

---

# 🚀 Project Journey

This project will be completed in multiple phases, with each phase building upon the previous one.

```text
Phase 0  → Final Project Goal
      ↓
Phase 1  → Planning & Project Setup
      ↓
Phase 2  → Terraform Fundamentals
      ↓
Phase 3  → AWS Provider & Backend Configuration
      ↓
Phase 4  → Networking (VPC)
      ↓
Phase 5  → Security Groups & IAM
      ↓
Phase 6  → EC2 Deployment
      ↓
Phase 7  → Application Load Balancer
      ↓
Phase 8  → Auto Scaling Group
      ↓
Phase 9  → PostgreSQL RDS
      ↓
Phase 10 → CloudWatch Monitoring
      ↓
Phase 11 → Testing & Validation
      ↓
Phase 12 → Project Completion
```

---

# 🎉 Final Vision

By the completion of this project, you will have built an **enterprise-grade AWS infrastructure** capable of hosting a **Spring Boot LinkedIn Clone application** using **Terraform**. This project will demonstrate modern Infrastructure as Code (IaC) practices, scalability, high availability, security, and automation—making it an excellent addition to your DevOps portfolio and a strong talking point in technical interviews.