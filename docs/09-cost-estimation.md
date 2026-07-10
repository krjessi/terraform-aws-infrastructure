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

# AWS Cost

## Phase 2 – Step 2.5: `data.tf`

### Estimated AWS Cost

| Resource                 | Status      | Estimated Cost |
| ------------------------ | ----------- | -------------: |
| AWS Resources            | Not Created |      **$0.00** |
| **Total Estimated Cost** |             |      **$0.00** |

---

# Resources Created

**None**

This step focuses on configuring Terraform **Data Sources** to retrieve information from AWS. No infrastructure is created, modified, or deleted.

---

# Why the Cost Is $0.00

During **Step 2.5**, you:

* Created the `data.tf` file.
* Configured AWS Data Sources.
* Retrieved the current AWS account information.
* Retrieved the current AWS Region.
* Retrieved the available Availability Zones.
* Formatted and validated the Terraform configuration.

These operations are **read-only** and do **not** provision any AWS resources.

---

# Data Sources Are Read-Only

Terraform Data Sources only query existing information from AWS APIs.

Examples include:

* AWS Account ID
* AWS Region
* Availability Zones
* Existing VPCs
* Existing IAM Roles
* Existing Security Groups

They **do not**:

* Create resources
* Modify resources
* Delete resources

Because no infrastructure is provisioned, there are **no AWS charges** associated with this step.

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

* Data Sources only query AWS APIs.
* No compute, storage, networking, or database resources are created.
* Querying AWS metadata does not incur infrastructure provisioning charges.
* AWS billing begins only after resources are created using `terraform apply`.

---

# Step Summary

| Item                    | Status            |
| ----------------------- | ----------------- |
| AWS Resources Created   | ❌ None            |
| Data Sources Configured | ✅ Yes             |
| AWS APIs Queried        | ✅ Yes (Read-Only) |
| Estimated AWS Cost      | **$0.00**         |
| Safe to Continue        | ✅ Yes             |

---

## ✅ Conclusion

**Phase 2 – Step 2.5 (`data.tf`)** introduces Terraform Data Sources for retrieving information from AWS. Since Data Sources only perform **read-only API queries** and **do not provision resources**, the **estimated AWS cost remains $0.00**.

---

# AWS Cost

## Phase 2 – Step 2.6: `outputs.tf`

### Estimated AWS Cost

| Resource                 | Status      | Estimated Cost |
| ------------------------ | ----------- | -------------: |
| AWS Resources            | Not Created |      **$0.00** |
| **Total Estimated Cost** |             |      **$0.00** |

---

# Resources Created

**None**

This step focuses on defining Terraform **Outputs** to expose useful information after deployment. No AWS infrastructure is created, modified, or deleted.

---

# Why the Cost Is $0.00

During **Step 2.6**, you:

* Created the `outputs.tf` file.
* Defined outputs for AWS Account ID.
* Defined outputs for the current AWS Region.
* Defined outputs for Availability Zones.
* Learned how outputs are used by modules.
* Learned how outputs integrate with CI/CD pipelines.
* Formatted and validated the Terraform configuration.

These activities modify only the Terraform configuration and do **not** provision any AWS resources.

---

# Outputs Do Not Create Infrastructure

Terraform Outputs are **read-only values** that display information after Terraform operations.

Outputs can expose values such as:

* AWS Account ID
* AWS Region
* Availability Zones
* VPC ID
* EC2 Instance ID
* ALB DNS Name
* RDS Endpoint

Outputs simply display existing information—they **do not** create, update, or delete infrastructure.

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

* Outputs do not create infrastructure.
* Outputs simply expose values from resources, data sources, variables, or locals.
* Defining outputs has no impact on AWS billing.
* AWS charges begin only after infrastructure is provisioned using `terraform apply`.

---

# Step Summary

| Item                       | Status    |
| -------------------------- | --------- |
| AWS Resources Created      | ❌ None    |
| Outputs Configured         | ✅ Yes     |
| Infrastructure Provisioned | ❌ No      |
| Estimated AWS Cost         | **$0.00** |
| Safe to Continue           | ✅ Yes     |

---

## ✅ Conclusion

**Phase 2 – Step 2.6 (`outputs.tf`)** introduces Terraform Outputs, which expose useful infrastructure information after deployment. Since **Outputs do not create infrastructure**, the **estimated AWS cost for this step remains $0.00**.

---

# AWS Cost

## Phase 2 – Step 2.7: `terraform.tfvars`

### Estimated AWS Cost

| Resource                         | Status      | Estimated Monthly Cost |
| -------------------------------- | ----------- | ---------------------: |
| AWS Resources                    | Not Created |              **$0.00** |
| **Total Estimated Monthly Cost** |             |              **$0.00** |

---

# Resources Created

**None**

This step focuses on configuring environment-specific variables using the `terraform.tfvars` file. No AWS infrastructure is created, modified, or deleted.

---

# Why the Cost Is $0.00

During **Step 2.7**, you:

* Created the `terraform.tfvars` file.
* Moved environment-specific values out of `variables.tf`.
* Separated variable definitions from variable values.
* Updated variables to remove default values.
* Learned Terraform variable precedence.
* Formatted, validated, and planned the Terraform configuration.

These activities only modify the local Terraform configuration and do **not** provision any AWS resources.

---

# `terraform.tfvars` Does Not Create Infrastructure

The `terraform.tfvars` file is a configuration file that provides values for variables declared in `variables.tf`.

It can define values such as:

* Project Name
* Environment
* AWS Region
* Instance Type
* CIDR Blocks
* Database Configuration

The file simply supplies input values to Terraform.

It does **not**:

* Create AWS resources
* Modify existing infrastructure
* Delete infrastructure
* Generate AWS charges

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

# AWS Billing Summary

| AWS Service               | Status      | Estimated Monthly Cost |
| ------------------------- | ----------- | ---------------------: |
| Amazon VPC                | Not Created |                  $0.00 |
| Amazon EC2                | Not Created |                  $0.00 |
| Amazon RDS                | Not Created |                  $0.00 |
| Application Load Balancer | Not Created |                  $0.00 |
| Auto Scaling Group        | Not Created |                  $0.00 |
| Amazon S3                 | Not Created |                  $0.00 |
| Amazon DynamoDB           | Not Created |                  $0.00 |
| Amazon CloudWatch         | Not Created |                  $0.00 |

---

# Cost Optimization Notes

* `terraform.tfvars` only supplies input values to Terraform.
* Changing values in `terraform.tfvars` affects configuration, not infrastructure.
* Running `terraform fmt`, `terraform validate`, or `terraform plan` does not create AWS resources.
* AWS charges begin only after infrastructure is provisioned using `terraform apply`.

---

# Step Summary

| Item                          | Status    |
| ----------------------------- | --------- |
| AWS Resources Created         | ❌ None    |
| `terraform.tfvars` Configured | ✅ Yes     |
| Infrastructure Provisioned    | ❌ No      |
| Estimated Monthly AWS Cost    | **$0.00** |
| Safe to Continue              | ✅ Yes     |

---

## ✅ Conclusion

**Phase 2 – Step 2.7 (`terraform.tfvars`)** introduces environment-specific configuration through the `terraform.tfvars` file. Since it only supplies variable values and **does not create infrastructure**, the **estimated monthly AWS cost remains $0.00**.

---

# AWS Cost

## Phase 2 – Step 2.8: `main.tf`

### Estimated AWS Cost

| Resource                         | Status      | Estimated Monthly Cost |
| -------------------------------- | ----------- | ---------------------: |
| AWS Resources                    | Not Created |              **$0.00** |
| **Total Estimated Monthly Cost** |             |              **$0.00** |

---

# Resources Created

**None**

This step focuses on creating the **Root Module** (`main.tf`) and preparing the project for a modular Terraform architecture. No AWS infrastructure is created, modified, or deleted.

---

# Why the Cost Is $0.00

During **Step 2.8**, you:

* Created the `main.tf` file.
* Learned the purpose of the Root Module.
* Designed the project for reusable Terraform modules.
* Documented the future module orchestration.
* Formatted and validated the Terraform configuration.
* Verified the execution plan.

These tasks affect only the local Terraform configuration and do **not** provision any AWS resources.

---

# `main.tf` Does Not Provision Infrastructure

At this stage, the `main.tf` file serves only as the entry point for the Terraform project.

It currently:

* Documents the project structure.
* Prepares the Root Module.
* Defines the future orchestration strategy.

It does **not**:

* Create resources
* Modify infrastructure
* Delete infrastructure
* Generate AWS charges

Actual infrastructure provisioning will begin in the next phase when reusable Terraform modules are implemented.

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

# AWS Billing Summary

| AWS Service               | Status      | Estimated Monthly Cost |
| ------------------------- | ----------- | ---------------------: |
| Amazon VPC                | Not Created |                  $0.00 |
| Amazon EC2                | Not Created |                  $0.00 |
| Amazon RDS                | Not Created |                  $0.00 |
| Application Load Balancer | Not Created |                  $0.00 |
| Auto Scaling Group        | Not Created |                  $0.00 |
| Amazon S3                 | Not Created |                  $0.00 |
| Amazon DynamoDB           | Not Created |                  $0.00 |
| Amazon CloudWatch         | Not Created |                  $0.00 |

---

# Cost Optimization Notes

* `main.tf` currently contains documentation only.
* No Terraform modules have been invoked.
* No AWS API calls create infrastructure during this step.
* Running `terraform fmt`, `terraform validate`, and `terraform plan` does not incur infrastructure provisioning costs.
* AWS billing begins only after resources are created with `terraform apply` in later phases.

---

# Step Summary

| Item                       | Status    |
| -------------------------- | --------- |
| AWS Resources Created      | ❌ None    |
| Root Module Prepared       | ✅ Yes     |
| Terraform Modules Created  | ❌ Not Yet |
| Infrastructure Provisioned | ❌ No      |
| Estimated Monthly AWS Cost | **$0.00** |
| Safe to Continue           | ✅ Yes     |

---

## ✅ Conclusion

**Phase 2 – Step 2.8 (`main.tf`)** completes the Terraform project foundation by establishing the Root Module and preparing the project for modular infrastructure. Since **no AWS resources are created**, the **estimated monthly AWS cost remains $0.00**.

---

# AWS Cost

## Phase 3.1 – VPC Design & Architecture

### Estimated AWS Cost

| Resource                         | Status      | Estimated Monthly Cost |
| -------------------------------- | ----------- | ---------------------: |
| AWS Resources                    | Not Created |              **$0.00** |
| **Total Estimated Monthly Cost** |             |              **$0.00** |

---

# Resources Created

**None**

This step focuses entirely on **planning and designing** the AWS network architecture.

No AWS resources are provisioned, modified, or deleted during this phase.

---

# Why the Cost Is $0.00

During **Phase 3.1**, you:

* Designed the AWS network architecture.
* Planned the VPC CIDR block.
* Planned Public and Private Subnets.
* Designed the High Availability strategy.
* Planned the security architecture.
* Defined the module structure.
* Updated project documentation.
* Prepared the infrastructure for Terraform implementation.

These activities involve documentation and architectural planning only.

---

# No AWS Infrastructure Provisioned

At this stage, **Terraform has not created any AWS resources**.

The following services are still in the design phase:

* Amazon VPC
* Public Subnets
* Private Application Subnets
* Private Database Subnets
* Internet Gateway
* NAT Gateway
* Route Tables
* Security Groups
* IAM Roles
* Application Load Balancer
* Auto Scaling Group
* Amazon EC2
* Amazon RDS
* Amazon CloudWatch

Since no infrastructure exists yet, **no AWS charges are incurred**.

---

# AWS Billing Summary

| AWS Service               | Status      | Estimated Monthly Cost |
| ------------------------- | ----------- | ---------------------: |
| Amazon VPC                | Not Created |                  $0.00 |
| Public & Private Subnets  | Not Created |                  $0.00 |
| Internet Gateway          | Not Created |                  $0.00 |
| NAT Gateway               | Not Created |                  $0.00 |
| Route Tables              | Not Created |                  $0.00 |
| Security Groups           | Not Created |                  $0.00 |
| Amazon EC2                | Not Created |                  $0.00 |
| Application Load Balancer | Not Created |                  $0.00 |
| Auto Scaling Group        | Not Created |                  $0.00 |
| Amazon RDS                | Not Created |                  $0.00 |
| Amazon CloudWatch         | Not Created |                  $0.00 |

---

# Cost Optimization Notes

* Architecture design and documentation are free.
* Planning CIDR blocks, subnet layouts, and networking strategies does not generate AWS charges.
* AWS billing begins only after infrastructure is provisioned using `terraform apply`.
* Designing before implementation helps prevent costly architecture changes later.

---

# Step Summary

| Item                       | Status    |
| -------------------------- | --------- |
| Architecture Designed      | ✅ Yes     |
| Documentation Updated      | ✅ Yes     |
| Terraform Code Written     | ❌ No      |
| AWS Resources Created      | ❌ None    |
| Infrastructure Provisioned | ❌ No      |
| Estimated Monthly AWS Cost | **$0.00** |

---

## ✅ Conclusion

**Phase 3.1 – VPC Design & Architecture** is a planning and design phase. No AWS resources are created during this step, so the **estimated monthly AWS cost remains $0.00**. This design provides the architectural foundation for implementing a secure, scalable, and production-ready AWS network in the following Terraform phases.

---