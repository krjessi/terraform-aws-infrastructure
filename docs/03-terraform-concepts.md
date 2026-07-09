# Step 2.1 – Create `versions.tf`

## 🎯 Objective

In this step, you'll create the **`versions.tf`** file, which defines:

- The required Terraform version
- The required provider versions
- The Terraform configuration block

This is one of the most important files in every Terraform project because it ensures that all team members use compatible versions of Terraform and its providers.

---

# 📖 Theory

## What is `versions.tf`?

Terraform does **not** require a file to be named `versions.tf`.

For example, you could place the same configuration in:

```text
terraform.tf
```

or

```text
abc.tf
```

Terraform automatically loads **all `.tf` files** in the working directory, regardless of their names.

So technically, both would work.

---

## Why Do We Use `versions.tf`?

Enterprise teams follow naming conventions to improve readability and maintainability.

When another engineer opens the project and sees:

```text
versions.tf
```

they immediately know this file contains:

- Terraform version constraints
- Provider version constraints

This makes the project easier to understand and maintain.

> **Enterprise Best Practice**
>
> Use descriptive filenames so that every file has a clear and specific purpose.

---

# Why Version Constraints Matter

Imagine your team consists of three engineers.

| Engineer | Terraform Version |
|----------|-------------------|
| Mukesh | 1.15 |
| Alice | 1.13 |
| Bob | 1.16 |

Without version constraints, the same Terraform code may behave differently.

### Mukesh

```text
terraform apply
        │
        ▼
     ✅ Works
```

### Alice

```text
terraform apply
        │
        ▼
     ❌ Fails
```

Now the team spends time debugging version differences instead of building infrastructure.

Version constraints eliminate these inconsistencies by ensuring everyone uses supported versions.

---

# Understanding the Terraform Block

Your first Terraform configuration block is:

```hcl
terraform {
}
```

This is **not** an AWS resource.

Instead, it configures Terraform itself.

Inside this block, we can define:

- Required Terraform version
- Required providers
- Backend configuration (later)
- Experimental features (rarely used)

---

# Create `versions.tf`

Navigate to the Terraform directory.

```text
terraform/
```

Create the following file.

```text
versions.tf
```

---

# Add the Following Code

```hcl
terraform {
  required_version = ">= 1.15.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.2"
    }
  }
}
```

---

# Line-by-Line Explanation

## Terraform Block

```hcl
terraform {
```

This block configures Terraform itself.

It is used to define:

- Version requirements
- Required providers
- Backend configuration
- Other Terraform settings

---

## Required Version

```hcl
required_version = ">= 1.15.0"
```

This specifies the minimum Terraform version required for the project.

### Supported Versions

| Version | Allowed |
|---------|---------|
| 1.15.0 | ✅ |
| 1.15.8 | ✅ |
| 1.16.x | ✅ |
| 1.14.x | ❌ |

If someone uses Terraform 1.14.x, Terraform will stop execution and display an error.

---

## Required Providers

```hcl
required_providers {
```

Providers allow Terraform to communicate with external platforms.

Terraform supports many providers, including:

- AWS
- Microsoft Azure
- Google Cloud Platform
- GitHub
- Docker
- Kubernetes
- Helm
- Cloudflare
- Datadog

For this project, we will use the **AWS provider**.

---

## Source

```hcl
source = "hashicorp/aws"
```

This tells Terraform to download the official AWS provider published by HashiCorp.

---

## Version

```hcl
version = "~> 6.2"
```

The `~>` operator is called the **pessimistic version constraint**.

It allows patch updates but blocks newer minor and major versions.

### Allowed Versions

- ✅ 6.2.0
- ✅ 6.2.5
- ✅ 6.2.20

### Not Allowed

- ❌ 6.3.0
- ❌ 7.0.0

This protects the project from unexpected breaking changes introduced in newer releases.

---

# Validation

After creating `versions.tf`, verify that the configuration is correct.

## Step 1 – Navigate to the Terraform Directory

```bash
cd terraform
```

---

## Step 2 – Format the Configuration

```bash
terraform fmt
```

This formats the Terraform files according to the official style guide.

---

## Step 3 – Initialize Terraform

```bash
terraform init
```

This command will:

- Download the required AWS provider
- Create the `.terraform/` directory
- Generate the `.terraform.lock.hcl` file
- Prepare the working directory

### Expected Output

```text
Terraform has been successfully initialized!
```

---

## Step 4 – Validate the Configuration

```bash
terraform validate
```

### Expected Output

```text
Success! The configuration is valid.
```

This confirms that the Terraform configuration is syntactically correct.

---

# Project Structure After This Step

```text
terraform/
│
├── versions.tf
├── .terraform/
└── .terraform.lock.hcl
```

---

# Documentation

Update the following documentation file.

```text
docs/terraform-concepts.md
```

Add the following topics.

## Topics Covered

- What is `versions.tf`?
- Why use version constraints?
- What is a Terraform provider?
- What is the `terraform {}` block?
- What happens during `terraform init`?

---

# Best Practices

- Always specify a minimum Terraform version.
- Pin provider versions to avoid unexpected changes.
- Use descriptive filenames such as `versions.tf`.
- Run `terraform fmt` before committing code.
- Run `terraform validate` after every configuration change.
- Commit the generated `.terraform.lock.hcl` file to Git for consistent provider versions across all environments.

---

# Common Issues

| Issue | Resolution |
|-------|------------|
| `terraform: command not found` | Verify Terraform is installed and available in your system `PATH`. |
| `Unsupported Terraform version` | Install a Terraform version that satisfies the `required_version` constraint. |
| `Missing required provider` | Run `terraform init` to download the required providers. |
| `Failed to query provider packages` | Check your internet connection and verify access to the Terraform Registry. |

---

# Interview Questions

### 1. Is `versions.tf` a mandatory filename?

No. Terraform reads all `.tf` files regardless of their names. Using `versions.tf` is an enterprise convention that improves readability.

---

### 2. Why do we use version constraints?

Version constraints ensure consistent behavior across environments and prevent compatibility issues caused by different Terraform or provider versions.

---

### 3. What does the `terraform {}` block do?

It configures Terraform itself by defining version requirements, providers, backend configuration, and other settings.

---

### 4. What is a provider in Terraform?

A provider is a plugin that enables Terraform to interact with external platforms such as AWS, Azure, Kubernetes, Docker, and GitHub.

---

### 5. Why do we pin provider versions?

Pinning provider versions prevents unexpected breaking changes caused by automatic upgrades while still allowing tested patch releases.

---

# Summary

In this step, you learned:

- The purpose of `versions.tf`
- Why enterprise projects follow naming conventions
- Why version constraints are important
- How the `terraform {}` block works
- How to define provider requirements
- How to initialize and validate a Terraform project

You also created the first foundational Terraform configuration file that will be used throughout the remainder of the project.

---

# Next Step

In **Step 2.2**, you'll create **`provider.tf`**, where you'll configure the AWS provider and connect Terraform to your AWS account.

---

# 🚀 Phase 2 – Step 2.2: Create `provider.tf`

**Duration:** 30–45 Minutes

---

# 🎯 Learning Objectives

By the end of this step, you will understand:

- What is a Terraform Provider?
- How Terraform authenticates with AWS
- Why providers are separated from resources
- How to configure AWS regions
- Enterprise tagging strategy
- Provider best practices
- Common validation errors
- Interview questions
- Troubleshooting

---

# What is a Provider?

Terraform itself **cannot create AWS resources**.

Terraform is simply an **Infrastructure as Code (IaC) engine**.

To communicate with AWS, Terraform requires a **Provider**.

A provider acts as a bridge between Terraform and the AWS APIs.

```text
Terraform
      │
      ▼
AWS Provider
      │
      ▼
AWS APIs
      │
      ▼
AWS Resources
```

Without the AWS Provider, Terraform has no idea how to create or manage resources such as:

- Amazon VPC
- Amazon EC2
- Amazon RDS
- Application Load Balancer (ALB)
- IAM Roles and Policies
- Security Groups
- Route Tables
- Subnets
- Internet Gateway

Every cloud platform or service requires its own provider.

Examples include:

| Provider | Platform |
|-----------|----------|
| AWS | Amazon Web Services |
| Azure | Microsoft Azure |
| Google | Google Cloud Platform |
| Kubernetes | Kubernetes Clusters |
| Docker | Docker Engine |
| GitHub | GitHub Repositories |
| Helm | Kubernetes Package Manager |
| Cloudflare | DNS & CDN |

---

# Why Separate `provider.tf`?

Could the provider configuration be placed inside `main.tf`?

**Yes.**

Should it?

**No.**

Enterprise Terraform projects separate responsibilities into dedicated files.

| File | Responsibility |
|------|----------------|
| `versions.tf` | Terraform and Provider version constraints |
| `provider.tf` | Provider configuration and authentication |
| `variables.tf` | Input variables |
| `locals.tf` | Local values and common tags |
| `data.tf` | Existing infrastructure lookups |
| `outputs.tf` | Output values |
| `main.tf` | Infrastructure resources and module calls |

Keeping the provider configuration in its own file improves:

- Readability
- Maintainability
- Collaboration
- Scalability
- Code organization

---

# Create `provider.tf`

Navigate to:

```text
terraform/provider.tf
```

Create the file if it doesn't already exist.

---

# Add the Following Code

```hcl
provider "aws" {
  region = var.aws_region

  default_tags {
    tags = local.common_tags
  }
}
```

---

# Understanding Every Line

## Provider Block

```hcl
provider "aws" {
```

This tells Terraform:

> "Use the AWS Provider whenever AWS resources are created."

Every AWS resource in this project will use this provider configuration.

If the project later interacts with other platforms, additional provider blocks can be added.

Example:

```hcl
provider "github" {}

provider "docker" {}

provider "kubernetes" {}
```

Terraform supports multiple providers in the same project.

---

## Region

```hcl
region = var.aws_region
```

Notice that the AWS region is **not hardcoded**.

Instead of:

```hcl
region = "ap-south-1"
```

we use an input variable:

```hcl
var.aws_region
```

### Why?

Imagine the infrastructure needs to be deployed in different AWS regions.

Examples:

| Region | Code |
|---------|------|
| Mumbai | `ap-south-1` |
| Singapore | `ap-southeast-1` |
| Frankfurt | `eu-central-1` |
| Ohio | `us-east-2` |

Changing a single variable is much easier than updating multiple files.

This approach improves flexibility and reusability.

---

# Default Tags

```hcl
default_tags {
  tags = local.common_tags
}
```

This is one of the most useful features of the AWS Provider.

Instead of manually defining tags for every resource:

```hcl
resource "aws_vpc" "main" {
  tags = {
    Project = "LinkedIn Clone"
    Owner   = "Mukesh Kumar"
  }
}
```

the provider automatically applies the same tags to all supported AWS resources.

This eliminates duplicate code and ensures consistency.

---

# What Are Tags?

Tags are **key-value pairs** attached to AWS resources.

They help organize, identify, and manage infrastructure.

### Example

| Key | Value |
|-----|-------|
| Project | LinkedIn Clone |
| Environment | dev |
| Owner | Mukesh Kumar |
| ManagedBy | Terraform |
| CreatedBy | Terraform |
| CostCenter | Learning |

---

# Benefits of Tags

Using tags consistently provides several advantages.

- Cost allocation and tracking
- Resource filtering
- Automation
- Governance and compliance
- Easier troubleshooting
- Better inventory management
- Simplified reporting

Most enterprise organizations require tagging on every resource.

---

# Why Use Variables for the Region?

The variable `var.aws_region` has not been created yet.

This is expected.

It will be defined in:

```text
terraform/variables.tf
```

Using variables makes the configuration reusable across different environments.

---

# Why Use Local Values for Tags?

Similarly, the local value:

```hcl
local.common_tags
```

does not exist yet.

It will be created later in:

```text
terraform/locals.tf
```

Using locals allows common values to be defined once and reused throughout the project.

---

# Expected Validation Errors

At this stage, Terraform cannot resolve the variable or local value because they haven't been created yet.

This is completely normal.

Enterprise Terraform projects are built incrementally.

---

# Validation

Move to the Terraform directory.

```bash
cd terraform
```

---

## Format the Configuration

Run:

```bash
terraform fmt
```

This formats the configuration according to Terraform's style guidelines.

---

## Validate the Configuration

Run:

```bash
terraform validate
```

### Expected Errors

You will likely see messages similar to:

```text
Reference to undeclared input variable
```

and

```text
Reference to undeclared local value
```

These errors occur because:

- `variables.tf` has not been created yet.
- `locals.tf` has not been created yet.

There is no need to fix them now.

They will disappear after the next steps.

---

# Documentation

Update the following documentation file:

```text
docs/terraform-concepts.md
```

Add the following topics:

## Topics Covered

- AWS Provider
- What is a Provider?
- Why does Terraform need Providers?
- Why separate Provider configuration?
- What are Default Tags?
- Why should AWS Regions be configurable?

---

# Best Practices

- Keep provider configuration in a dedicated `provider.tf` file.
- Never hardcode AWS regions unless absolutely necessary.
- Use variables for values that may change between environments.
- Apply common tags using `default_tags`.
- Follow a consistent tagging strategy across all resources.
- Keep provider configuration simple and centralized.

---

# Common Issues

| Issue | Cause | Solution |
|-------|-------|----------|
| `Reference to undeclared input variable` | `aws_region` has not been declared yet. | Create `variables.tf` in the next step. |
| `Reference to undeclared local value` | `common_tags` has not been defined yet. | Create `locals.tf` in a later step. |
| Provider authentication failed | AWS CLI credentials are missing or invalid. | Verify credentials using `aws sts get-caller-identity`. |
| Invalid AWS region | Incorrect region name specified. | Use a valid AWS region code such as `ap-south-1`. |

---

# Interview Questions

1. What is a Terraform Provider?
2. Why does Terraform require a Provider?
3. Why should Provider configuration be separated from resources?
4. Why shouldn't AWS Regions be hardcoded?
5. What are Default Tags?
6. Why are Tags important in AWS?
7. What happens if `var.aws_region` doesn't exist?
8. What happens if `local.common_tags` doesn't exist?
9. Can a Terraform project use multiple Providers?
10. What are some examples of Terraform Providers?

---

# Summary

In this step, you learned:

- What a Terraform Provider is.
- How Terraform communicates with AWS.
- Why provider configuration belongs in a separate file.
- Why variables should be used for configurable values like AWS Regions.
- How `default_tags` simplify resource tagging.
- Why enterprise projects use centralized tagging strategies.
- Why validation errors are expected until supporting files are created.

At this point, the project has a clean provider configuration and is ready for the next step.

---

# Next Step

In **Step 2.3**, you'll create **`variables.tf`**, where you'll define reusable input variables such as:

- AWS Region
- Environment
- Project Name
- Application Name
- Resource Naming Standards

These variables will make the Terraform configuration flexible, reusable, and suitable for multiple environments.

---

# 🚀 Phase 2 – Step 2.3: Create `variables.tf`

**Duration:** 45–60 Minutes

---

# 🎯 Goal

Create a clean, scalable, and reusable `variables.tf` file that supports multiple environments such as **development**, **staging**, and **production** without requiring changes to the Terraform code.

By using variables, our Terraform configuration becomes:

- Reusable
- Flexible
- Environment-independent
- Easier to maintain
- Suitable for enterprise deployments

---

# 📖 Theory

## What Are Variables?

Variables allow you to **parameterize** your Terraform configuration.

Instead of hardcoding values directly into the code, you reference variables whose values can change depending on the deployment environment.

### Hardcoded Example

```hcl
provider "aws" {
  region = "ap-south-1"
}
```

Every time you need to deploy to another region, you must edit the Terraform code.

---

### Variable-Based Example

```hcl
provider "aws" {
  region = var.aws_region
}
```

Now the AWS Region is controlled by a variable.

Changing the deployment region no longer requires modifying the code.

---

# Why Use Variables?

Imagine your infrastructure is deployed in multiple environments.

| Environment | AWS Region |
|-------------|------------|
| Development | `ap-south-1` |
| Staging | `ap-southeast-1` |
| Production | `us-east-1` |

### Without Variables

You would manually update:

```hcl
region = "..."
```

before every deployment.

This approach is:

- Error-prone
- Difficult to maintain
- Not scalable

---

### With Variables

The same Terraform code works everywhere.

Only the input value changes.

This makes deployments:

- Faster
- More reliable
- Easier to automate

---

# Enterprise Variable Standards

Enterprise Terraform projects follow a consistent standard when defining variables.

Every variable should include:

- ✅ A meaningful description
- ✅ A data type
- ✅ A default value (when appropriate)
- ✅ Validation rules (when appropriate)

---

## Bad Example

```hcl
variable "region" {}
```

This provides no information about the variable.

---

## Good Example

```hcl
variable "aws_region" {
  description = "AWS region where resources will be deployed."
  type        = string
  default     = "ap-south-1"
}
```

This clearly documents the purpose of the variable and provides a sensible default.

---

# Variables We'll Create

In this step, we'll define only the variables needed for the project foundation.

Additional variables for networking, compute, and databases will be added in later phases.

| Variable | Purpose |
|----------|---------|
| `project_name` | Project identifier |
| `environment` | Deployment environment (`dev`, `stage`, `prod`) |
| `aws_region` | AWS deployment region |

---

# Create `variables.tf`

Navigate to:

```text
terraform/
```

Create the following file.

```text
variables.tf
```

---

# Add the Following Code

```hcl
#############################################
# Project Variables
#############################################

variable "project_name" {
  description = "Name of the project."
  type        = string
  default     = "linkedin"
}

variable "environment" {
  description = "Deployment environment."
  type        = string
  default     = "dev"

  validation {
    condition = contains(
      ["dev", "stage", "prod"],
      var.environment
    )

    error_message = "Environment must be one of: dev, stage, or prod."
  }
}

#############################################
# AWS Variables
#############################################

variable "aws_region" {
  description = "AWS region where resources will be deployed."
  type        = string
  default     = "ap-south-1"
}
```

---

# Understanding Every Variable

## `project_name`

```hcl
variable "project_name"
```

This variable identifies the project.

Later, it will be used to generate consistent resource names.

### Example Resource Names

```text
linkedin-dev-vpc

linkedin-dev-alb

linkedin-dev-rds

linkedin-dev-ec2
```

Using a variable avoids hardcoding the project name throughout the Terraform configuration.

---

## `environment`

```hcl
variable "environment"
```

This variable specifies the deployment environment.

Supported values:

- `dev`
- `stage`
- `prod`

---

### Validation

The validation block ensures that only approved environment names are accepted.

```hcl
validation {
  condition = contains(
    ["dev", "stage", "prod"],
    var.environment
  )

  error_message = "Environment must be one of: dev, stage, or prod."
}
```

If someone provides:

```text
testing
```

Terraform stops with an error:

```text
Environment must be one of: dev, stage, or prod.
```

This prevents accidental deployment to invalid environments.

---

## `aws_region`

```hcl
variable "aws_region"
```

This variable defines the AWS Region where infrastructure will be deployed.

Instead of hardcoding:

```hcl
region = "ap-south-1"
```

the provider configuration references:

```hcl
region = var.aws_region
```

This allows the same configuration to be deployed in any AWS Region simply by changing the variable value.

---

# Variable Types

Terraform supports several data types.

| Type | Example |
|------|---------|
| `string` | `"ap-south-1"` |
| `number` | `3` |
| `bool` | `true` |
| `list` | `["a", "b"]` |
| `map` | `{ key = "value" }` |
| `object` | `{ name = "dev" }` |

In this step, we use the `string` type because all variable values are text.

---

# Variable Validation

Validation helps prevent invalid input values.

Benefits include:

- Early error detection
- Consistent deployments
- Better user experience
- Reduced configuration mistakes

Terraform checks validation rules before creating infrastructure.

---

# Variable Precedence

Terraform determines variable values using the following order of precedence.

| Priority | Source |
|----------|--------|
| 1 | Command-line arguments (`-var`) |
| 2 | `.tfvars` files |
| 3 | Environment variables (`TF_VAR_*`) |
| 4 | Default values in `variables.tf` |

During this phase, we will use the default values.

In later phases, we will introduce environment-specific `.tfvars` files.

---

# Validation

Navigate to the Terraform directory.

```bash
cd terraform
```

---

## Format the Configuration

Run:

```bash
terraform fmt
```

This formats the Terraform files according to the official style guide.

---

## Validate the Configuration

Run:

```bash
terraform validate
```

### Expected Result

Terraform will likely display an error similar to:

```text
Reference to undeclared local value
```

This is expected because `locals.tf` has not yet been created.

The configuration will be fully valid after completing the next step.

---

# Documentation

Update the following file.

```text
docs/terraform-concepts.md
```

Add the following topics.

## Topics Covered

- Variables
- What are Variables?
- Why use Variables?
- Variable Types
- Variable Validation
- Variable Precedence
- Enterprise Naming Conventions

---

# Best Practices

- Use descriptive variable names.
- Always include descriptions.
- Specify data types for all variables.
- Use validation whenever possible.
- Avoid hardcoding values.
- Keep environment-specific values outside the Terraform code.
- Follow consistent naming conventions.

---

# Common Issues

| Issue | Cause | Solution |
|-------|-------|----------|
| `Reference to undeclared local value` | `locals.tf` has not been created yet. | Create `locals.tf` in the next step. |
| Validation error for `environment` | An unsupported value was provided. | Use `dev`, `stage`, or `prod`. |
| Incorrect AWS Region | Invalid region value supplied. | Specify a valid AWS Region such as `ap-south-1`. |

---

# Summary

In this step, you:

- Created the `variables.tf` file.
- Defined reusable project variables.
- Learned why variables improve flexibility.
- Added validation for the deployment environment.
- Configured the AWS Region as a variable.
- Understood Terraform variable precedence.
- Prepared the project for environment-specific configurations.

Using variables makes Terraform configurations reusable, scalable, and easier to maintain across multiple environments.

---

# Next Step

In **Step 2.4**, you'll create **`locals.tf`**, where you'll define reusable local values such as:

- Common resource tags
- Naming conventions
- Computed values
- Project-wide reusable expressions

These local values will reduce code duplication and improve consistency across the entire Terraform project.

---

# 🚀 Phase 2 – Step 2.4: Create `locals.tf`

**Duration:** 45–60 Minutes

---

# 🎯 Goal

Create centralized naming conventions and common tags that can be reused across every Terraform module.

Using **locals** helps eliminate duplicate code, enforce consistent naming, and apply a standard tagging strategy throughout the project.

---

# 📖 Theory

## What are Locals?

Locals are values that are **computed inside the Terraform configuration**.

Unlike variables, local values are created and managed by Terraform itself.

Think of the workflow like this:

```text
User Input (Variables)
        │
        ▼
Terraform Logic (Locals)
        │
        ▼
AWS Resources
```

Variables provide input values, while locals transform or combine those values into reusable expressions.

---

# Variables vs Locals

| Variables | Locals |
|-----------|--------|
| Input provided by the user | Values calculated by Terraform |
| Can be overridden | Cannot be overridden |
| Used for configuration | Used for reuse and consistency |
| Example: AWS Region | Example: Resource Name Prefix |

Variables answer the question:

> **"What value should be used?"**

Locals answer the question:

> **"How should we reuse or combine those values?"**

---

# Why Use Locals?

Imagine creating 30 AWS resources.

Without locals, you might repeat the same tags everywhere.

```hcl
tags = {
  Project     = "linkedin"
  Environment = "dev"
  ManagedBy   = "Terraform"
}
```

Every resource contains the same block.

If tomorrow the project name changes from:

```text
linkedin
```

to

```text
linkedin-clone
```

you must update dozens of files.

Instead, define the values once and reference them everywhere.

---

# Enterprise Design

In enterprise Terraform projects, locals are commonly used for:

- Resource naming conventions
- Common resource tags
- Frequently reused expressions
- Computed values
- Environment-specific naming

Later in this project, every module will reuse these local values.

---

# Create `locals.tf`

Navigate to:

```text
terraform/
```

Create the following file:

```text
locals.tf
```

---

# Add the Following Code

```hcl
#############################################
# Local Values
#############################################

locals {

  ###########################################
  # Resource Naming
  ###########################################

  name_prefix = "${var.project_name}-${var.environment}"

  ###########################################
  # Common Tags
  ###########################################

  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Owner       = "Mukesh Kumar"
    Repository  = "terraform-aws-infrastructure"
  }

}
```

---

# Understanding Every Line

## Local Block

```hcl
locals {
```

The `locals` block defines reusable values that can be referenced anywhere within the Terraform configuration.

A local value is accessed using:

```hcl
local.<name>
```

Example:

```hcl
local.common_tags
```

---

## Resource Naming

```hcl
name_prefix = "${var.project_name}-${var.environment}"
```

This creates a reusable resource name prefix.

Suppose the variables are:

```text
project_name = "linkedin"

environment = "dev"
```

The result becomes:

```text
linkedin-dev
```

Later, resources can use this prefix.

Examples:

```text
linkedin-dev-vpc

linkedin-dev-alb

linkedin-dev-rds

linkedin-dev-asg

linkedin-dev-ec2
```

This ensures consistent naming across the project.

---

## Common Tags

```hcl
common_tags = {
```

This creates a reusable map containing common tags.

Instead of defining tags for every resource, you simply reference:

```hcl
local.common_tags
```

This eliminates duplicate code.

---

## Project Tag

```hcl
Project = var.project_name
```

If:

```text
project_name = "linkedin"
```

Terraform creates:

```text
Project = linkedin
```

---

## Environment Tag

```hcl
Environment = var.environment
```

If:

```text
environment = "dev"
```

Terraform creates:

```text
Environment = dev
```

---

## ManagedBy Tag

```hcl
ManagedBy = "Terraform"
```

This identifies that the infrastructure is managed using Terraform.

Many enterprise organizations use this tag for automation and governance.

---

## Owner Tag

```hcl
Owner = "Mukesh Kumar"
```

For a personal portfolio project, using your name is perfectly acceptable.

In enterprise environments, this tag usually contains:

- Team name
- Department
- Email distribution group
- Application owner

---

## Repository Tag

```hcl
Repository = "terraform-aws-infrastructure"
```

This identifies the Git repository responsible for the infrastructure.

This is especially useful when multiple repositories manage different infrastructure components.

---

# Why Didn't We Add More Tags?

AWS supports many additional tags.

Examples include:

- CostCenter
- Department
- BusinessUnit
- Compliance
- Backup
- Application
- Team
- OwnerEmail

For this portfolio project, the current set of tags is sufficient.

Additional tags can easily be added later if required.

---

# Benefits of Locals

Using locals provides several advantages.

- Eliminates duplicate code
- Centralizes common values
- Improves readability
- Simplifies maintenance
- Standardizes naming
- Standardizes tagging
- Makes future updates easier

---

# Validation

Move to the Terraform directory.

```bash
cd terraform
```

---

## Format the Configuration

Run:

```bash
terraform fmt
```

---

## Validate the Configuration

Run:

```bash
terraform validate
```

### Expected Result

Validation should now succeed because:

- `versions.tf` is configured.
- `provider.tf` references `local.common_tags`.
- `variables.tf` defines the required variables.
- `locals.tf` defines the required local values.

Expected output:

```text
Success! The configuration is valid.
```

---

# Project Structure

After this step, your project should contain:

```text
terraform/
│
├── versions.tf
├── provider.tf
├── variables.tf
├── locals.tf
├── data.tf
├── outputs.tf
├── main.tf
├── modules/
└── environments/
```

---

# Documentation

Update:

```text
docs/terraform-concepts.md
```

Add the following topics.

## Topics Covered

- Local Values
- What are Locals?
- Variables vs Locals
- Why use Locals?
- Resource Naming Strategy
- Centralized Tagging

---

# Best Practices

- Keep reusable values inside `locals.tf`.
- Avoid repeating strings throughout the project.
- Use locals for naming conventions.
- Centralize common tags.
- Reference variables inside locals instead of hardcoding values.
- Use descriptive local names.
- Validate Terraform configuration after every change.

---

# Common Issues

| Issue | Cause | Solution |
|-------|-------|----------|
| `Reference to undeclared local value` | Local value not defined. | Add the required local value inside `locals.tf`. |
| Incorrect resource naming | Variables contain unexpected values. | Verify `project_name` and `environment` in `variables.tf`. |
| Missing tags | `default_tags` not configured or `local.common_tags` referenced incorrectly. | Verify `provider.tf` and `locals.tf`. |

---

# Summary

In this step, you:

- Created the `locals.tf` file.
- Learned the purpose of local values.
- Created a reusable naming convention.
- Defined common resource tags.
- Eliminated duplicate configuration.
- Improved maintainability through centralized values.
- Successfully validated the Terraform configuration.

Using locals is an essential enterprise practice that keeps Terraform configurations clean, consistent, and easy to maintain.

---

# Next Step

In **Step 2.5**, you'll create **`data.tf`**, where you'll learn how to retrieve information about existing AWS resources using **Terraform Data Sources** without creating new infrastructure.

---
