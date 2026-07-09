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

# AWS Cost

## Phase 2 – Step 2.2: `provider.tf`

### Estimated AWS Cost

| Resource | Status | Estimated Cost |
|----------|--------|---------------:|
| AWS Resources | Not Created | **$0.00** |
| **Total Estimated Cost** |  | **$0.00** |

---

# Resources Created

**None**

In this step, no AWS infrastructure is provisioned.

The `provider.tf` file only configures how Terraform will communicate with AWS in future steps.

---

# Why the Cost Is $0.00

During **Step 2.2**, you:

- Created the `provider.tf` file
- Configured the AWS provider
- Specified the AWS region using a variable
- Configured default resource tags
- Formatted the Terraform configuration
- Validated the Terraform configuration

Although the AWS Provider is configured, **Terraform does not create any AWS resources** until you explicitly run:

```bash
terraform apply
```

Therefore, **no AWS charges are incurred** during this step.

---

# AWS Resources Provisioned

None of the following resources are created:

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

# Local Changes Only

The following changes occur only on your local machine:

- Created `provider.tf`
- Updated Terraform configuration
- Formatted configuration using `terraform fmt`
- Validated configuration using `terraform validate`

These operations do **not** interact with AWS billing.

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

- No AWS infrastructure has been deployed.
- Provider configuration alone does not incur AWS charges.
- Billing begins only after AWS resources are provisioned with `terraform apply`.
- It is safe to experiment with Terraform configuration files before creating infrastructure.

---

# Step Summary

| Item | Status |
|------|--------|
| AWS Resources Created | ❌ None |
| Terraform Provider Configured | ✅ Yes |
| Estimated AWS Cost | **$0.00** |
| Safe to Continue | ✅ Yes |

---

## ✅ Conclusion

This step focuses solely on configuring the AWS Provider. Since **no AWS resources are created**, the **estimated AWS cost remains $0.00**.

---

# AWS Cost

## Phase 2 – Step 2.3: `variables.tf`

### Estimated AWS Cost

| Resource                 | Status      | Estimated Cost |
| ------------------------ | ----------- | -------------: |
| AWS Resources            | Not Created |      **$0.00** |
| **Total Estimated Cost** |             |      **$0.00** |

---

# Resources Created

**None**

This step focuses on defining Terraform input variables and preparing the project for future infrastructure deployment. No AWS resources are provisioned.

---

# Why the Cost Is $0.00

During **Step 2.3**, you:

* Created the `variables.tf` file.
* Defined reusable input variables.
* Added variable descriptions and data types.
* Configured default values.
* Implemented variable validation.
* Learned Terraform variable precedence.
* Formatted and validated the Terraform configuration.

These actions modify only the local Terraform project and do **not** create or manage any AWS resources.

---

# AWS Resources Provisioned

The following AWS resources have **not** been created:

* Amazon VPC
* Public Subnets
* Private Subnets
* Internet Gateway
* NAT Gateway
* Route Tables
* Security Groups
* IAM Roles
* Amazon EC2
* Application Load Balancer (ALB)
* Auto Scaling Group (ASG)
* Amazon RDS (PostgreSQL)
* Amazon S3 Bucket
* Amazon DynamoDB Table
* Amazon CloudWatch Resources

---

# Local Changes Only

The following files were created or updated locally:

```text
terraform/
│
├── variables.tf
├── provider.tf
└── versions.tf
```

These are local configuration files and do **not** incur any AWS charges.

---

# AWS Billing Summary

| AWS Service               | Status      | Estimated Cost |
| ------------------------- | ----------- | -------------: |
| Amazon VPC                | Not Created |          $0.00 |
| Amazon EC2                | Not Created |          $0.00 |
| Amazon RDS                | Not Created |          $0.00 |
| Application Load Balancer | Not Created |          $0.00 |
| Auto Scaling Group        | Not Created |          $0.00 |
| Amazon S3                 | Not Created |          $0.00 |
| Amazon DynamoDB           | Not Created |          $0.00 |
| Amazon CloudWatch         | Not Created |          $0.00 |

---

# Cost Optimization Notes

* No AWS infrastructure has been provisioned.
* Defining variables and validation rules does not interact with AWS.
* No billable AWS services are running.
* AWS charges will begin only after infrastructure is created using `terraform apply`.

---

# Step Summary

| Item                        | Status    |
| --------------------------- | --------- |
| AWS Resources Created       | ❌ None    |
| Terraform Variables Created | ✅ Yes     |
| Estimated AWS Cost          | **$0.00** |
| Safe to Continue            | ✅ Yes     |

---

## ✅ Conclusion

**Phase 2 – Step 2.3 (`variables.tf`)** focuses on creating reusable and validated input variables for the Terraform project. Since **no AWS resources are created**, the **estimated AWS cost for this step is $0.00**.

---

# AWS Cost

## Phase 2 – Step 2.4: `locals.tf`

### Estimated AWS Cost

| Resource                 | Status      | Estimated Cost |
| ------------------------ | ----------- | -------------: |
| AWS Resources            | Not Created |      **$0.00** |
| **Total Estimated Cost** |             |      **$0.00** |

---

# Resources Created

**None**

This step focuses on defining reusable local values, naming conventions, and common resource tags. No AWS infrastructure is provisioned.

---

# Why the Cost Is $0.00

During **Step 2.4**, you:

* Created the `locals.tf` file.
* Defined reusable local values.
* Implemented a centralized resource naming strategy.
* Created common tags for AWS resources.
* Eliminated duplicate configuration.
* Formatted the Terraform configuration.
* Validated the Terraform configuration.

These activities are performed entirely on your local machine and do **not** create or modify any AWS resources.

---

# AWS Resources Provisioned

The following AWS resources have **not** been created:

* Amazon VPC
* Public Subnets
* Private Subnets
* Internet Gateway
* NAT Gateway
* Route Tables
* Security Groups
* IAM Roles
* Amazon EC2
* Application Load Balancer (ALB)
* Auto Scaling Group (ASG)
* Amazon RDS (PostgreSQL)
* Amazon S3 Bucket
* Amazon DynamoDB Table
* Amazon CloudWatch Resources

---

# Local Changes Only

The following Terraform configuration files now exist locally:

```text id="0hyjrh"
terraform/
│
├── versions.tf
├── provider.tf
├── variables.tf
├── locals.tf
```

These files define the project foundation and do **not** incur any AWS charges.

---

# AWS Billing Summary

| AWS Service               | Status      | Estimated Cost |
| ------------------------- | ----------- | -------------: |
| Amazon VPC                | Not Created |          $0.00 |
| Amazon EC2                | Not Created |          $0.00 |
| Amazon RDS                | Not Created |          $0.00 |
| Application Load Balancer | Not Created |          $0.00 |
| Auto Scaling Group        | Not Created |          $0.00 |
| Amazon S3                 | Not Created |          $0.00 |
| Amazon DynamoDB           | Not Created |          $0.00 |
| Amazon CloudWatch         | Not Created |          $0.00 |

---

# Cost Optimization Notes

* No AWS infrastructure has been deployed.
* Local values and tags exist only within the Terraform configuration.
* Creating or updating `locals.tf` does not interact with AWS APIs.
* AWS billing begins only after infrastructure is provisioned using `terraform apply`.

---

# Step Summary

| Item                    | Status    |
| ----------------------- | --------- |
| AWS Resources Created   | ❌ None    |
| Local Values Configured | ✅ Yes     |
| Common Tags Defined     | ✅ Yes     |
| Estimated AWS Cost      | **$0.00** |
| Safe to Continue        | ✅ Yes     |

---

## ✅ Conclusion

**Phase 2 – Step 2.4 (`locals.tf`)** establishes reusable local values, consistent resource naming, and centralized tagging for the Terraform project. Since **no AWS resources are created**, the **estimated AWS cost remains $0.00**.

---