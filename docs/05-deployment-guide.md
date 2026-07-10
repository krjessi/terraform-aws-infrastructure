# Deployment Guide

## Overview

This guide explains how to deploy the **Terraform AWS Infrastructure Automation** project from start to finish.

It covers:

- Project setup
- Terraform initialization
- Validation
- Planning
- Infrastructure deployment
- Verification
- Updating infrastructure
- Destroying infrastructure
- Troubleshooting

---

# Prerequisites

Before deploying, ensure the following are completed.

- Git installed
- Terraform installed
- AWS CLI installed
- Docker installed
- Java 21+ installed
- AWS account configured
- GitHub repository cloned
- Visual Studio Code installed

Verify the installations:

```bash
terraform version

aws --version

git --version

docker --version

java --version
```

---

# Project Structure

```text
terraform-aws-infrastructure/
│
├── README.md
├── docs/
├── architecture/
├── images/
└── terraform/
    ├── versions.tf
    ├── provider.tf
    ├── variables.tf
    ├── terraform.tfvars
    ├── locals.tf
    ├── data.tf
    ├── outputs.tf
    ├── main.tf
    ├── backend.tf
    ├── modules/
    └── environments/
```

---

# Step 1 – Clone the Repository

Clone the GitHub repository.

```bash
git clone https://github.com/<your-username>/terraform-aws-infrastructure.git
```

Move into the project directory.

```bash
cd terraform-aws-infrastructure
```

Navigate to the Terraform directory.

```bash
cd terraform
```

---

# Step 2 – Configure AWS CLI

Configure AWS credentials.

```bash
aws configure
```

Provide:

```text
AWS Access Key ID
AWS Secret Access Key
Default Region: ap-south-1
Output Format: json
```

Verify authentication.

```bash
aws sts get-caller-identity
```

Expected output:

```json
{
  "Account": "123456789012",
  "Arn": "arn:aws:iam::123456789012:user/terraform-user"
}
```

---

# Step 3 – Review Configuration

Verify the following files exist:

```text
versions.tf
provider.tf
variables.tf
terraform.tfvars
locals.tf
data.tf
outputs.tf
main.tf
```

Review:

- AWS Region
- Environment
- Project Name

inside:

```text
terraform.tfvars
```

Example:

```hcl
project_name = "linkedin"

environment = "dev"

aws_region = "ap-south-1"
```

---

# Step 4 – Format Terraform Code

Format all Terraform files.

```bash
terraform fmt
```

To format recursively:

```bash
terraform fmt -recursive
```

---

# Step 5 – Initialize Terraform

Initialize the working directory.

```bash
terraform init
```

Terraform will:

- Download providers
- Create `.terraform/`
- Generate `.terraform.lock.hcl`
- Prepare the working directory

Expected output:

```text
Terraform has been successfully initialized!
```

---

# Step 6 – Validate Configuration

Validate the Terraform configuration.

```bash
terraform validate
```

Expected output:

```text
Success! The configuration is valid.
```

---

# Step 7 – Generate an Execution Plan

Preview the infrastructure changes.

```bash
terraform plan
```

Terraform displays:

- Resources to create
- Resources to update
- Resources to destroy
- Output values

No changes are made during this step.

---

# Step 8 – Deploy Infrastructure

Deploy the infrastructure.

```bash
terraform apply
```

Terraform prompts:

```text
Do you want to perform these actions?
```

Type:

```text
yes
```

Terraform provisions the AWS infrastructure.

---

# Step 9 – View Outputs

Display Terraform outputs.

```bash
terraform output
```

Example:

```text
aws_account_id

aws_region

availability_zones
```

Display a specific output:

```bash
terraform output aws_region
```

JSON format:

```bash
terraform output -json
```

---

# Step 10 – Verify Resources

Verify the resources in the AWS Management Console.

Typical resources include:

- Amazon VPC
- Subnets
- Internet Gateway
- NAT Gateway
- Security Groups
- IAM Roles
- EC2 Instances
- Application Load Balancer
- Auto Scaling Group
- Amazon RDS

---

# Step 11 – Make Configuration Changes

Modify the Terraform configuration as needed.

Examples:

- Add a new resource
- Update tags
- Change instance type
- Modify security groups

Format the code:

```bash
terraform fmt
```

Validate:

```bash
terraform validate
```

Preview changes:

```bash
terraform plan
```

Apply changes:

```bash
terraform apply
```

---

# Step 12 – Destroy Infrastructure

When the infrastructure is no longer required, destroy it.

Preview the destroy operation:

```bash
terraform plan -destroy
```

Destroy resources:

```bash
terraform destroy
```

Confirm:

```text
yes
```

Terraform deletes all managed infrastructure.

---

# Deploying Multiple Environments

Example structure:

```text
terraform/
│
├── dev.tfvars
├── stage.tfvars
└── prod.tfvars
```

Deploy Development:

```bash
terraform apply -var-file="dev.tfvars"
```

Deploy Staging:

```bash
terraform apply -var-file="stage.tfvars"
```

Deploy Production:

```bash
terraform apply -var-file="prod.tfvars"
```

---

# Useful Terraform Commands

| Command | Purpose |
|----------|---------|
| `terraform fmt` | Format configuration |
| `terraform init` | Initialize project |
| `terraform validate` | Validate configuration |
| `terraform plan` | Preview changes |
| `terraform apply` | Deploy infrastructure |
| `terraform output` | Display outputs |
| `terraform state list` | List managed resources |
| `terraform show` | Display state details |
| `terraform destroy` | Remove infrastructure |

---

# Deployment Workflow

```text
Write Terraform Code
        │
        ▼
terraform fmt
        │
        ▼
terraform init
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
Verify AWS Resources
        │
        ▼
terraform output
```

---

# Troubleshooting

## `terraform init` Fails

**Cause**

- Internet connectivity
- Invalid provider configuration

**Solution**

```bash
terraform init -upgrade
```

---

## Validation Failed

**Cause**

- Syntax errors
- Missing variables

**Solution**

Run:

```bash
terraform validate
```

Review the reported errors and update the configuration.

---

## AWS Authentication Failed

**Cause**

Invalid AWS credentials.

**Solution**

Verify:

```bash
aws sts get-caller-identity
```

Reconfigure if necessary:

```bash
aws configure
```

---

## Wrong AWS Region

**Cause**

Incorrect region in:

```text
terraform.tfvars
```

**Solution**

Update:

```hcl
aws_region = "ap-south-1"
```

Run:

```bash
terraform plan
```

again.

---

## Provider Download Failed

**Cause**

Network issues or provider cache problems.

**Solution**

```bash
terraform init -upgrade
```

---

# Best Practices

- Always run `terraform fmt` before committing code.
- Validate every configuration change.
- Review the execution plan before applying.
- Use separate `.tfvars` files for different environments.
- Store Terraform state remotely in production.
- Protect sensitive values using secret management.
- Keep infrastructure modular.
- Commit Terraform code to Git regularly.

---

# Deployment Checklist

| Task | Status |
|------|:------:|
| Clone Repository | ☐ |
| Configure AWS CLI | ☐ |
| Review Variables | ☐ |
| Run `terraform fmt` | ☐ |
| Run `terraform init` | ☐ |
| Run `terraform validate` | ☐ |
| Run `terraform plan` | ☐ |
| Run `terraform apply` | ☐ |
| Verify AWS Resources | ☐ |
| Verify Outputs | ☐ |

---

# Expected Result

After deployment, the project will provision:

- Amazon VPC
- Public and Private Subnets
- Internet Gateway
- NAT Gateway
- Route Tables
- Security Groups
- IAM Roles
- EC2 Instances
- Application Load Balancer
- Auto Scaling Group
- Amazon RDS PostgreSQL
- Amazon CloudWatch
- Amazon S3 Backend (when configured)
- Amazon DynamoDB State Lock Table (when configured)

---

# Conclusion

Following this deployment guide ensures a consistent, repeatable, and production-ready Terraform workflow. By formatting, validating, planning, and applying changes in the correct order, you can safely provision and manage AWS infrastructure using Infrastructure as Code while following enterprise best practices.