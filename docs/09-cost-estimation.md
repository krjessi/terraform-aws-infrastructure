# AWS Cost

## Phase 1 – Planning & Project Setup

### Estimated Cost

| Resource                 |      Cost |
| ------------------------ | --------: |
| AWS Resources            | **$0.00** |
| **Total Estimated Cost** | **$0.00** |

## Why the Cost Is $0

During **Phase 1**, no AWS infrastructure is provisioned. This phase focuses entirely on preparing the development environment and project structure.

Completed activities include:

* Creating the GitHub repository
* Setting up the project directory structure
* Installing Terraform
* Configuring the AWS CLI
* Configuring Git
* Installing Visual Studio Code extensions
* Creating project documentation
* Initializing the Git repository
* Creating the first Git commit

Since no Terraform resources have been deployed and no AWS services have been created, there are **no AWS charges** for this phase.

## Resources Created

**None**

## AWS Billing Summary

| Service                   | Status      | Estimated Cost |
| ------------------------- | ----------- | -------------: |
| Amazon VPC                | Not Created |          $0.00 |
| Amazon EC2                | Not Created |          $0.00 |
| Amazon RDS                | Not Created |          $0.00 |
| Application Load Balancer | Not Created |          $0.00 |
| Auto Scaling Group        | Not Created |          $0.00 |
| Amazon S3                 | Not Created |          $0.00 |
| Amazon DynamoDB           | Not Created |          $0.00 |
| Amazon CloudWatch         | Not Created |          $0.00 |

## Cost Optimization Notes

* No AWS infrastructure has been provisioned.
* No compute, storage, networking, or database resources are running.
* AWS billing will begin only after infrastructure is deployed in later phases.

## Phase Summary

**Phase 1 Estimated AWS Cost:** **$0.00** ✅

---

# AWS Cost

## Phase 2 – Terraform Fundamentals

### Estimated AWS Cost

| Resource | Status | Estimated Cost |
|----------|--------|---------------:|
| AWS Resources | Not Created | **$0.00** |
| **Total Estimated Cost** |  | **$0.00** |

---

# Why the Cost Is $0.00

During **Phase 2 – Terraform Fundamentals**, no AWS infrastructure is provisioned.

This phase focuses on building the Terraform project foundation by:

- Creating the `versions.tf` file
- Defining Terraform version constraints
- Configuring provider version requirements
- Learning the Terraform workflow
- Initializing the Terraform working directory
- Validating the Terraform configuration
- Preparing the project structure for future infrastructure deployment

Although the AWS provider is downloaded locally during `terraform init`, **no API calls are made to create AWS resources**, so there are **no AWS charges**.

---

# Resources Created

**None**

The following AWS resources have **not** been created in this phase:

- Amazon VPC
- Public Subnets
- Private Subnets
- Internet Gateway
- NAT Gateway
- Route Tables
- Security Groups
- IAM Roles
- Amazon EC2
- Application Load Balancer (ALB)
- Auto Scaling Group (ASG)
- Amazon RDS (PostgreSQL)
- Amazon S3 Bucket
- Amazon DynamoDB Table
- Amazon CloudWatch Resources

---

# Local Resources Created

The following files and directories are created **locally** on your machine:

```text
terraform/
│
├── versions.tf
├── .terraform/
└── .terraform.lock.hcl
```

These are local project artifacts and do **not** incur any AWS costs.

---

# AWS Billing Summary

| AWS Service | Status | Estimated Cost |
|-------------|--------|---------------:|
| Amazon VPC | Not Created | $0.00 |
| Amazon EC2 | Not Created | $0.00 |
| Amazon RDS | Not Created | $0.00 |
| Application Load Balancer | Not Created | $0.00 |
| Auto Scaling Group | Not Created | $0.00 |
| Amazon S3 | Not Created | $0.00 |
| Amazon DynamoDB | Not Created | $0.00 |
| Amazon CloudWatch | Not Created | $0.00 |

---

# Cost Optimization Notes

- No cloud resources have been provisioned.
- No compute, storage, database, or networking services are running.
- `terraform init` only downloads the required provider plugins to your local machine.
- AWS billing will begin only after infrastructure is created in future phases.

---

# Phase Summary

| Item | Status |
|------|--------|
| AWS Resources Created | ❌ None |
| Estimated AWS Cost | **$0.00** |
| Safe to Continue | ✅ Yes |

---

## ✅ Conclusion

**Phase 2 – Terraform Fundamentals** prepares the Terraform project by defining version constraints and initializing the working directory. Since no AWS resources are created, the **estimated AWS cost for this phase is $0.00**.

---