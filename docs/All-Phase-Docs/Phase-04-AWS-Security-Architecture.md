# 🚀 Phase 4 – AWS Security Architecture

**Duration:** 2–3 Days

---

# 🎯 Goal

Build a reusable **Terraform Security Module** that implements the **Principle of Least Privilege** for a production-ready AWS environment.

Instead of defining Security Groups inside EC2 or ALB resources, we will create a dedicated Terraform module responsible for all network security.

---

# 📖 Why a Separate Security Module?

Many beginners create Security Groups directly inside:

```text
ec2.tf
```

or

```text
alb.tf
```

This approach works for very small projects but quickly becomes difficult to maintain.

Enterprise projects separate **networking**, **security**, **compute**, and **database** into independent modules.

---

# Enterprise Module Architecture

```text
VPC Module
      │
      ├── Creates VPC
      ├── Creates Subnets
      └── Creates Route Tables

Security Module
      │
      ├── ALB Security Group
      ├── EC2 Security Group
      └── RDS Security Group

EC2 Module
      │
      └── Uses EC2 Security Group

RDS Module
      │
      └── Uses RDS Security Group
```

This layered design improves:

- Reusability
- Maintainability
- Security
- Separation of responsibilities
- Scalability

---

# Module Naming Improvement

Before we begin, we'll make one small improvement.

Instead of naming the module:

```text
security-group
```

we'll simply use:

```text
security
```

Our project structure becomes:

```text
modules/
│
├── vpc/
├── security/
├── iam/
├── alb/
├── ec2/
├── autoscaling/
├── rds/
└── monitoring/
```

This follows the naming convention commonly used in enterprise Terraform repositories.

Example:

```hcl
module "security" {
  source = "./modules/security"
}
```

This is cleaner and easier to read than:

```hcl
module "security-group" {
  source = "./modules/security-group"
}
```

---

# Module Structure

Create the following directory structure:

```text
terraform/
└── modules/
    └── security/
        ├── main.tf
        ├── variables.tf
        ├── outputs.tf
        └── README.md
```

This module will manage all Security Groups for the infrastructure.

---

# Final Security Architecture

```text
                        Internet
                            │
                            ▼
                  ALB Security Group
             Allow: HTTP (80), HTTPS (443)
                  Source: 0.0.0.0/0
                            │
                            ▼
                Application Load Balancer
                            │
                            ▼
                  EC2 Security Group
          Allow: Port 8080 only from ALB SG
                            │
                            ▼
                Spring Boot Application
                            │
                            ▼
                  RDS Security Group
         Allow: PostgreSQL (5432) only from EC2 SG
```

---

# Layered Security Model

Notice the security boundaries.

### Internet

Can access:

- Application Load Balancer

Cannot access:

- EC2 Instances
- Amazon RDS

---

### Application Load Balancer

Can communicate only with:

- EC2 Instances

---

### EC2 Instances

Can communicate only with:

- Amazon RDS

---

### Amazon RDS

Accepts connections only from:

- EC2 Security Group

This follows the **Principle of Least Privilege**.

---

# Security Groups We'll Build

| Security Group | Purpose |
|---------------|---------|
| **ALB Security Group** | Allow HTTP (80) and HTTPS (443) from the Internet |
| **EC2 Security Group** | Allow application traffic (8080) only from the ALB Security Group |
| **RDS Security Group** | Allow PostgreSQL (5432) only from the EC2 Security Group |

This is a common production architecture for three-tier applications.

---

# Why This Design?

### ❌ Internet → EC2

Not Allowed

Application servers should never be exposed directly to the Internet.

---

### ❌ Internet → Amazon RDS

Not Allowed

Databases must remain completely private.

---

### ✅ Internet → ALB

Allowed

The Application Load Balancer is the only public entry point.

---

### ✅ ALB → EC2

Allowed

The ALB forwards requests to the application.

---

### ✅ EC2 → Amazon RDS

Allowed

Only the application communicates with the database.

---

# Principle of Least Privilege

One of the most important AWS security principles is:

> **Grant only the minimum permissions required to perform a task.**

Examples:

Instead of:

```text
Allow All Traffic

0.0.0.0/0
```

we allow:

```text
HTTP (80)

HTTPS (443)

↓

Application Load Balancer
```

Application servers:

```text
Allow Port 8080

↓

Only from ALB Security Group
```

Database:

```text
Allow Port 5432

↓

Only from EC2 Security Group
```

Every layer exposes only the ports that are absolutely necessary.

---

# What Are Security Groups?

A Security Group is a **virtual firewall** attached to AWS resources.

It controls:

- Inbound (Ingress) traffic
- Outbound (Egress) traffic

Security Groups are:

- Stateful
- Resource-level firewalls
- Allow rules only (no deny rules)

---

# Learning Objectives

By the end of this phase, you'll understand:

- AWS Security Groups
- Stateful Firewalls
- Ingress Rules
- Egress Rules
- Security Group References
- Principle of Least Privilege
- AWS Network Security
- Terraform Dependencies
- Modular Security Design

---

# Phase 4 Roadmap

## Step 4.1

Design the Security Architecture

---

## Step 4.2

Create the Security Module

```text
modules/security/
```

---

## Step 4.3

Create the ALB Security Group

Allow:

- HTTP (80)
- HTTPS (443)

Source:

```text
0.0.0.0/0
```

---

## Step 4.4

Create the EC2 Security Group

Allow:

```text
Port 8080

↓

Only from ALB Security Group
```

---

## Step 4.5

Create the RDS Security Group

Allow:

```text
Port 5432

↓

Only from EC2 Security Group
```

---

## Step 4.6

Expose Module Outputs

Return:

- ALB Security Group ID
- EC2 Security Group ID
- RDS Security Group ID

---

## Step 4.7

Connect the Module from the Root Module

The Root Module will orchestrate the Security Module.

---

## Step 4.8

Validate

Run:

```bash
terraform fmt -recursive

terraform validate

terraform plan
```

---

## Step 4.9

Apply

Deploy the Security Groups to AWS.

---

# Interview Questions You'll Be Able to Answer

After completing this phase, you should confidently answer:

- What is a Security Group?
- Why are Security Groups stateful?
- What is the difference between Security Groups and Network ACLs?
- Why reference one Security Group from another?
- Why shouldn't EC2 allow `0.0.0.0/0`?
- Why shouldn't PostgreSQL be exposed to the Internet?
- What is the Principle of Least Privilege?
- Why create separate Security Groups for ALB, EC2, and RDS?

---

# AWS Cost

Security Groups are **completely free**.

| Resource | Monthly Cost |
|----------|-------------:|
| ALB Security Group | ₹0 |
| EC2 Security Group | ₹0 |
| RDS Security Group | ₹0 |
| **Total** | **₹0** |

Creating Security Groups does not increase your AWS bill.

---

# Best Practices

- Create dedicated Security Groups for each application layer.
- Follow the Principle of Least Privilege.
- Avoid exposing EC2 instances directly to the Internet.
- Never expose databases to the public Internet.
- Use Security Group references instead of CIDR blocks wherever possible.
- Separate networking and security into independent Terraform modules.
- Use consistent enterprise tagging across all security resources.
- Keep modules small, reusable, and focused on a single responsibility.

---

# Phase Summary

After completing **Phase 4 – AWS Security Architecture**, you will have:

- Designed a reusable Security Module.
- Adopted enterprise Terraform module organization.
- Implemented a layered security architecture.
- Applied the Principle of Least Privilege.
- Planned dedicated Security Groups for the ALB, EC2, and Amazon RDS.
- Prepared the infrastructure for secure application deployment.

The next steps will implement each Security Group individually and connect them together using **Security Group references**, creating a production-ready AWS security model.