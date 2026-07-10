# AWS Architecture

## Project Overview

This document describes the target AWS architecture for the **Terraform AWS Infrastructure Automation** project.

The goal is to build a **production-ready, highly available, secure, and scalable infrastructure** using Terraform and AWS following enterprise best practices.

---

# Project Information

| Property | Value |
|----------|-------|
| Project Name | Terraform AWS Infrastructure Automation |
| Repository | `terraform-aws-infrastructure` |
| Cloud Provider | AWS |
| Infrastructure as Code | Terraform |
| Application | LinkedIn Clone (Spring Boot) |
| Database | PostgreSQL |
| Load Balancer | Application Load Balancer (ALB) |
| Compute | Amazon EC2 |
| Auto Scaling | Auto Scaling Group (ASG) |

---

# High-Level Architecture

```text
                    Internet
                        │
                        ▼
          Application Load Balancer
                        │
                        ▼
             Auto Scaling Group
                        │
          ┌─────────────┴─────────────┐
          ▼                           ▼
      EC2 Instance               EC2 Instance
   (Spring Boot App)         (Spring Boot App)
          │                           │
          └─────────────┬─────────────┘
                        │
                        ▼
                  PostgreSQL RDS
```

---

# Complete AWS Architecture

```text
                                Internet
                                    │
                                    ▼
                           Internet Gateway
                                    │
                                    ▼
                    Public Route Table
                                    │
        ┌───────────────────────────┴───────────────────────────┐
        ▼                                                       ▼
 Public Subnet A                                         Public Subnet B
        │                                                       │
        └─────────────── Application Load Balancer ──────────────┘
                                    │
                                    ▼
                         Target Group
                                    │
                     Auto Scaling Group (ASG)
                 ┌─────────────────────────────┐
                 ▼                             ▼
        Private App Subnet A          Private App Subnet B
                 │                             │
                 ▼                             ▼
          EC2 Instance                  EC2 Instance
           Spring Boot                   Spring Boot
                 │                             │
                 └──────────────┬──────────────┘
                                ▼
                       PostgreSQL RDS
                    Private DB Subnets
```

---

# AWS Services Used

| Service | Purpose |
|----------|---------|
| Amazon VPC | Isolated network |
| Public Subnets | Load Balancer |
| Private Application Subnets | EC2 Instances |
| Private Database Subnets | Amazon RDS |
| Internet Gateway | Internet access |
| NAT Gateway | Outbound internet for private subnets |
| Route Tables | Network routing |
| Security Groups | Firewall rules |
| IAM Roles | Secure AWS access |
| EC2 | Spring Boot application |
| Application Load Balancer | Traffic distribution |
| Auto Scaling Group | High availability |
| Amazon RDS | PostgreSQL database |
| Amazon CloudWatch | Monitoring and logging |
| Amazon S3 | Terraform remote state |
| Amazon DynamoDB | Terraform state locking |

---

# Network Architecture

## Amazon VPC

The VPC provides an isolated network for all AWS resources.

Example CIDR:

```text
10.0.0.0/16
```

---

## Public Subnets

Used for internet-facing resources.

Resources include:

- Application Load Balancer
- NAT Gateway

Example:

```text
Public Subnet A
10.0.1.0/24

Public Subnet B
10.0.2.0/24
```

---

## Private Application Subnets

Used for application servers.

Resources include:

- EC2 Instances
- Auto Scaling Group

Example:

```text
Private App Subnet A
10.0.11.0/24

Private App Subnet B
10.0.12.0/24
```

---

## Private Database Subnets

Used exclusively for the database layer.

Resources include:

- Amazon RDS

Example:

```text
Private DB Subnet A
10.0.21.0/24

Private DB Subnet B
10.0.22.0/24
```

---

# Traffic Flow

```text
Internet
    │
    ▼
Application Load Balancer
    │
    ▼
Target Group
    │
    ▼
EC2 Instances
    │
    ▼
Amazon RDS
```

All user requests pass through the Application Load Balancer before reaching the application servers.

---

# Security Architecture

## Security Groups

### Application Load Balancer

Inbound:

- HTTP (80)
- HTTPS (443)

Outbound:

- EC2 Security Group

---

### EC2 Instances

Inbound:

- HTTP from ALB
- SSH (restricted for administration)

Outbound:

- Amazon RDS
- Internet via NAT Gateway

---

### Amazon RDS

Inbound:

- PostgreSQL (5432)
- Only from EC2 Security Group

No direct internet access.

---

# High Availability

The infrastructure is deployed across multiple Availability Zones.

```text
Availability Zone A

├── Public Subnet
├── Private App Subnet
└── Private DB Subnet

Availability Zone B

├── Public Subnet
├── Private App Subnet
└── Private DB Subnet
```

Benefits:

- Fault tolerance
- High availability
- Better resilience

---

# Auto Scaling Architecture

The Auto Scaling Group automatically adjusts the number of EC2 instances based on demand.

Benefits:

- Automatic scaling
- Improved availability
- Reduced operational effort
- Cost optimization

---

# Monitoring Architecture

Monitoring is provided through:

- Amazon CloudWatch Metrics
- Amazon CloudWatch Logs
- CloudWatch Alarms

Future enhancements may include:

- Prometheus
- Grafana
- AWS X-Ray

---

# Terraform Architecture

```text
Root Module
      │
      ▼
main.tf
      │
      ├────────► VPC Module
      ├────────► Security Group Module
      ├────────► IAM Module
      ├────────► ALB Module
      ├────────► EC2 Module
      ├────────► Auto Scaling Module
      ├────────► RDS Module
      └────────► Monitoring Module
```

---

# Planned Terraform Modules

```text
modules/
│
├── vpc/
├── security-group/
├── iam/
├── alb/
├── ec2/
├── autoscaling/
├── rds/
└── monitoring/
```

Each module has a single responsibility and can be reused across multiple projects.

---

# Infrastructure Deployment Flow

```text
Developer
      │
      ▼
Git Repository
      │
      ▼
Terraform
      │
      ▼
AWS Provider
      │
      ▼
AWS APIs
      │
      ▼
AWS Infrastructure
```

---

# Enterprise Best Practices

- Modular Terraform architecture
- Infrastructure as Code (IaC)
- Least privilege IAM access
- Multi-AZ deployment
- Private application and database subnets
- Public-facing Application Load Balancer
- Auto Scaling for high availability
- Centralized tagging strategy
- Remote Terraform state
- State locking with DynamoDB
- Reusable Terraform modules
- Environment-specific configuration

---

# Benefits of This Architecture

- Highly Available
- Scalable
- Secure
- Modular
- Reusable
- Easy to Maintain
- Production Ready
- CI/CD Friendly
- Cost Optimized
- Suitable for Enterprise Workloads

---

# Estimated AWS Resources

The completed infrastructure will include:

- 1 Amazon VPC
- 2 Public Subnets
- 2 Private Application Subnets
- 2 Private Database Subnets
- 1 Internet Gateway
- 1 NAT Gateway
- Multiple Route Tables
- Security Groups
- IAM Roles
- Application Load Balancer
- Auto Scaling Group
- EC2 Instances
- Amazon RDS PostgreSQL
- Amazon CloudWatch
- Amazon S3 Backend
- Amazon DynamoDB Lock Table

---

# Future Enhancements

The architecture can be extended with:

- Amazon Route 53
- AWS Certificate Manager (ACM)
- Amazon ElastiCache (Redis)
- Amazon EFS
- AWS WAF
- AWS Shield
- AWS Secrets Manager
- Amazon SNS
- AWS Backup
- AWS Systems Manager (SSM)

---

# Conclusion

This architecture follows modern AWS and Terraform best practices by using a modular Infrastructure as Code approach, private networking, high availability across multiple Availability Zones, centralized monitoring, and reusable Terraform modules. It provides a strong foundation for deploying scalable, secure, and production-ready Spring Boot applications on AWS.

---

# AWS Architecture

## Project Goal

Deploy a **production-ready AWS infrastructure** for a **Spring Boot LinkedIn Clone** using **Terraform** following enterprise Infrastructure as Code (IaC) best practices.

The infrastructure is designed to be:

- Highly Available
- Secure
- Scalable
- Modular
- Cost-efficient
- Production-ready

The project follows the AWS Well-Architected Framework by separating the application into networking, compute, database, and monitoring layers.

---

# Architecture Diagram

The infrastructure consists of three network tiers:

- Public Tier
- Application Tier
- Database Tier

```text
                                    Internet
                                        │
                                Internet Gateway
                                        │
                      ┌─────────────────┴─────────────────┐
                      │                                   │
               Public Subnet A                    Public Subnet B
                      │                                   │
                      └────────── Application Load Balancer ──────────┘
                                        │
                  ┌─────────────────────┴─────────────────────┐
                  │                                           │
           Private App Subnet A                      Private App Subnet B
                  │                                           │
              EC2 Instance                              EC2 Instance
                  │                                           │
                  └─────────────────────┬─────────────────────┘
                                        │
                  ┌─────────────────────┴─────────────────────┐
                  │                                           │
           Private DB Subnet A                      Private DB Subnet B
                  │                                           │
                PostgreSQL RDS (Multi-AZ Ready)
```

---

# CIDR Plan

The network uses a structured CIDR allocation to separate each layer of the infrastructure.

| Resource | CIDR Block |
|-----------|------------|
| VPC | `10.0.0.0/16` |
| Public Subnet A | `10.0.1.0/24` |
| Public Subnet B | `10.0.2.0/24` |
| Private App Subnet A | `10.0.11.0/24` |
| Private App Subnet B | `10.0.12.0/24` |
| Private DB Subnet A | `10.0.21.0/24` |
| Private DB Subnet B | `10.0.22.0/24` |

### Why This CIDR Plan?

- `/16` provides approximately **65,536 IP addresses**, allowing room for future expansion.
- Each `/24` subnet provides **256 IP addresses**, which is sufficient for this project.
- Separate subnet ranges improve readability, organization, and long-term maintainability.

---

# High Availability Strategy

The infrastructure is designed to remain available even if one Availability Zone becomes unavailable.

### Availability Zones

The deployment spans two AWS Availability Zones:

- `ap-south-1a`
- `ap-south-1b`

### High Availability Design

- Application Load Balancer deployed across both Availability Zones.
- Public Subnets created in each Availability Zone.
- Private Application Subnets created in each Availability Zone.
- Private Database Subnets created in each Availability Zone.
- Auto Scaling Group distributes EC2 instances across both Availability Zones.
- Amazon RDS is designed to support **Multi-AZ deployment** for improved database availability.

### Benefits

- Improved fault tolerance
- Increased application availability
- Better resilience during maintenance
- Automatic traffic distribution
- Simplified horizontal scaling

---

# Security Strategy

The architecture follows a layered security model based on the **Principle of Least Privilege** and **Least Exposure**.

## Public Layer

Resources:

- Application Load Balancer (ALB)

Characteristics:

- Receives internet traffic.
- Terminates incoming HTTP/HTTPS requests.
- Routes requests to private application servers.

---

## Application Layer

Resources:

- Amazon EC2
- Auto Scaling Group

Characteristics:

- Hosted in Private Application Subnets.
- No public IP addresses.
- Accessible only through the Application Load Balancer.
- Protected using Security Groups.

---

## Database Layer

Resources:

- Amazon RDS PostgreSQL

Characteristics:

- Hosted in Private Database Subnets.
- No direct internet access.
- Accessible only from the application tier.
- Protected by dedicated Security Groups.

---

## Layered Security

Traffic flows through controlled layers.

```text
Internet
     │
     ▼
Application Load Balancer
     │
     ▼
EC2 Instances
     │
     ▼
Amazon RDS
```

Security Groups enforce communication between each layer, preventing unauthorized access.

---

# AWS Services

| AWS Service | Purpose |
|--------------|---------|
| **Amazon VPC** | Provides an isolated virtual network for the application. |
| **Public Subnets** | Host internet-facing resources such as the Application Load Balancer. |
| **Private Application Subnets** | Host Spring Boot application servers without public internet exposure. |
| **Private Database Subnets** | Host Amazon RDS securely within the private network. |
| **Application Load Balancer (ALB)** | Distributes incoming traffic across multiple EC2 instances. |
| **Auto Scaling Group (ASG)** | Automatically scales EC2 instances based on application demand. |
| **Amazon RDS (PostgreSQL)** | Provides a managed relational database service. |
| **Amazon CloudWatch** | Monitors infrastructure, collects metrics, and generates alarms. |

---

# Network Flow

Every client request follows the same secure path.

```text
Client
    │
    ▼
DNS
    │
    ▼
Application Load Balancer
    │
    ▼
EC2 Auto Scaling Group
    │
    ▼
Amazon RDS PostgreSQL
```

Only the Application Load Balancer is publicly accessible.

Application servers and the database remain isolated within private subnets.

---

# Enterprise Design Principles

This architecture follows several enterprise networking principles:

- Custom VPC instead of the default VPC.
- Separation of Public, Application, and Database tiers.
- Multi-Availability Zone deployment.
- No public access to application servers or databases.
- Layered security using Security Groups.
- Modular Terraform design for infrastructure provisioning.
- Scalable architecture through Auto Scaling.
- High availability using redundant subnets and load balancing.

---

# Future Enhancements

As the project evolves, additional AWS services will be integrated, including:

- Internet Gateway
- NAT Gateway
- Route Tables
- Route Table Associations
- IAM Roles
- AWS Systems Manager (SSM)
- Amazon Route 53
- AWS Certificate Manager (ACM)
- AWS Secrets Manager
- Amazon S3 (Terraform Remote State)
- Amazon DynamoDB (State Locking)
- AWS WAF
- Amazon SNS
- AWS Backup

---

# Summary

This AWS architecture provides a secure, scalable, and highly available foundation for deploying the LinkedIn Clone application.

By combining:

- Multi-AZ networking
- Public and Private subnet separation
- Layered security
- Auto Scaling
- Load balancing
- Managed database services
- Infrastructure as Code with Terraform

the project closely follows enterprise AWS architecture patterns used in real-world production environments.