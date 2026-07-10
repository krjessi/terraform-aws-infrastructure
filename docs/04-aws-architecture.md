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