# 🚀 Phase 3 – VPC Design & Architecture

**Duration:** 3–5 Days

---

# 🎯 Goal

Design and build a **production-ready Virtual Private Cloud (VPC)** using Terraform.

Before writing any Terraform code, we'll first design the network exactly as an **AWS Solutions Architect** would.

The focus of this phase is **network architecture**, not Terraform syntax.

---

# Why We Design First

A common interview question is:

> **"How would you design a VPC for a production application?"**

Many candidates immediately begin explaining Terraform code.

However, interviewers are typically evaluating your understanding of:

- Networking fundamentals
- AWS architecture
- Security
- High Availability
- Scalability

Terraform comes **after** the architecture is designed.

A well-designed network is the foundation of a reliable cloud infrastructure.

---

# Final Target Architecture

The following architecture represents the infrastructure we will build over the next several phases.

```text
                                      Internet
                                          │
                                  Internet Gateway
                                          │
                 ┌────────────────────────┴────────────────────────┐
                 │                                                 │
          Public Subnet A                                   Public Subnet B
                 │                                                 │
                 └─────────────── Application Load Balancer ───────┘
                                          │
                   ┌──────────────────────┴──────────────────────┐
                   │                                             │
          Private App Subnet A                         Private App Subnet B
                   │                                             │
                EC2 (ASG)                                    EC2 (ASG)
                   │                                             │
                   └──────────────────────┬──────────────────────┘
                                          │
          ┌───────────────────────────────┴───────────────────────────────┐
          │                                                               │
     Private DB Subnet A                                           Private DB Subnet B
          │                                                               │
                   PostgreSQL RDS (Multi-AZ Ready)
```

This architecture follows AWS Well-Architected Framework principles and reflects a common production deployment pattern.

---

# Architecture Components

| Component | Purpose |
|-----------|---------|
| Amazon VPC | Isolated network for the application |
| Internet Gateway | Enables internet connectivity |
| Public Subnets | Host internet-facing resources |
| Application Load Balancer | Entry point for incoming traffic |
| Private Application Subnets | Host EC2 application servers |
| Auto Scaling Group | Provides scalability and high availability |
| Private Database Subnets | Host Amazon RDS securely |
| PostgreSQL RDS | Persistent relational database |

---

# Why This Architecture?

Every architectural decision has a purpose.

| Component | Design Decision |
|-----------|-----------------|
| **1 VPC** | Provides complete network isolation. |
| **2 Public Subnets** | Ensures high availability for internet-facing resources. |
| **2 Private Application Subnets** | Prevents direct internet access to application servers. |
| **2 Private Database Subnets** | Keeps the database isolated and secure. |
| **Application Load Balancer** | Provides a single public entry point and distributes traffic. |
| **EC2 in Private Subnets** | Improves security by removing direct public access. |
| **Amazon RDS in Private Subnets** | Protects sensitive database resources from the internet. |

These design decisions demonstrate an understanding of AWS networking best practices and are commonly discussed during technical interviews.

---

# CIDR Planning

A carefully planned IP addressing scheme improves scalability and simplifies network management.

| Resource | CIDR Block |
|----------|------------|
| VPC | `10.0.0.0/16` |
| Public Subnet A | `10.0.1.0/24` |
| Public Subnet B | `10.0.2.0/24` |
| Private App Subnet A | `10.0.11.0/24` |
| Private App Subnet B | `10.0.12.0/24` |
| Private DB Subnet A | `10.0.21.0/24` |
| Private DB Subnet B | `10.0.22.0/24` |

---

# Why Use a `/16` VPC?

The VPC uses the CIDR block:

```text
10.0.0.0/16
```

A `/16` network provides:

- 65,536 IP addresses
- Plenty of room for future expansion
- Flexibility for creating additional subnets
- Alignment with common enterprise networking standards

This allows the infrastructure to grow without redesigning the network.

---

# Why Use `/24` Subnets?

Each subnet uses a `/24` CIDR block.

Benefits include:

- 256 IP addresses per subnet
- Simple subnet management
- Clear separation of network tiers
- Sufficient capacity for this project

Using consistent `/24` subnet sizes also improves readability and maintenance.

---

# Availability Zones

The infrastructure will be deployed across two Availability Zones.

```text
ap-south-1a

ap-south-1b
```

Although AWS currently offers additional Availability Zones in the Mumbai Region, two zones are sufficient for:

- High Availability
- Fault tolerance
- Disaster resilience
- Cost optimization

This architecture remains production-ready while avoiding unnecessary complexity.

---

# High Availability Strategy

Resources are distributed across multiple Availability Zones.

Benefits include:

- Increased application availability
- Protection against Availability Zone failures
- Load balancing across multiple EC2 instances
- Support for Multi-AZ database deployments
- Improved resilience during maintenance events

---

# Security Architecture

The network follows a layered security model.

### Public Tier

Contains only:

- Application Load Balancer

Public internet traffic terminates here.

---

### Application Tier

Contains:

- EC2 Instances
- Auto Scaling Group

Characteristics:

- No public IP addresses
- Accessible only through the ALB
- Protected by Security Groups

---

### Database Tier

Contains:

- Amazon RDS PostgreSQL

Characteristics:

- Private subnets only
- No internet connectivity
- Accessible only from the application tier

This layered architecture minimizes the attack surface.

---

# Module Structure

The VPC will be implemented as a reusable Terraform module.

```text
terraform/
└── modules/
    └── vpc/
        ├── main.tf
        ├── variables.tf
        ├── outputs.tf
        ├── vpc.tf
        ├── subnets.tf
        ├── internet-gateway.tf
        ├── route-tables.tf
        ├── routes.tf
        └── README.md
```

Each future module—such as ALB, EC2, IAM, and RDS—will follow the same structure.

---

# Phase 3 Roadmap

| Step | Topic |
|------|-------|
| **3.1** | VPC Design & Architecture |
| **3.2** | Create VPC Module |
| **3.3** | Public Subnets |
|         | Private Application Subnets |
|         | Private Database Subnets |
| **3.4** | Internet Gateway |
| **3.5** | Route Tables |
| **3.6** | Route Table Associations |
| **3.7** | Module Outputs |
| **3.8** | Documentation, Interview Questions & Git Commit |
| **3.9** | Apply |

The NAT Gateway will be introduced after the VPC foundation is complete.

---

# Documentation Updates

Update:

```text
docs/04-aws-architecture.md
```

Include:

- High-level architecture diagram
- CIDR planning
- Subnet layout
- Availability Zone selection
- Design decisions
- Security architecture
- High Availability strategy

This document will continue to evolve throughout the project.

---

# Interview Questions

Be prepared to answer:

- What is a VPC?
- Why create a custom VPC instead of using the default VPC?
- Why choose `10.0.0.0/16` for the VPC?
- Why divide the network into public and private subnets?
- Why deploy across two Availability Zones?
- Why should databases reside in private subnets?
- Why is the Application Load Balancer deployed in public subnets?
- How do Route Tables control network traffic?

Understanding the reasoning behind these design decisions is just as important as writing the Terraform code.

---

# AWS Cost

At the beginning of Phase 3, no billable infrastructure has been deployed.

| Resource | Cost |
|----------|------|
| Amazon VPC | Free |
| Subnets | Free |
| Route Tables | Free |
| Internet Gateway | Free |
| NAT Gateway | Not Created |
| Amazon EC2 | Not Created |
| Amazon RDS | Not Created |

Paid AWS services will be introduced only when they are required.

---

# Development Workflow

Every implementation phase will follow the same workflow.

```text
Design
   │
   ▼
Terraform Code
   │
   ▼
terraform fmt
   │
   ▼
terraform validate
   │
   ▼
terraform plan
   │
   ▼
terraform apply
   │
   ▼
Verify in AWS Console
   │
   ▼
Update Documentation
   │
   ▼
Interview Questions
   │
   ▼
Git Commit
```

This workflow mirrors the development lifecycle used by professional DevOps and Cloud Engineering teams.

---

# Phase Summary

After completing **Phase 3 – Step 3.1**, you will have:

- A production-ready AWS network design
- A well-planned CIDR addressing strategy
- Public, Application, and Database subnet architecture
- Multi-AZ deployment strategy
- Security-first network design
- A reusable module structure for the VPC
- Documentation aligned with enterprise standards
- A strong understanding of AWS networking concepts frequently discussed in technical interviews

With the architecture finalized, the next step is to implement the **Terraform VPC Module**, transforming this design into reusable Infrastructure as Code.