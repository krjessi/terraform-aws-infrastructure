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

# 🚀 Phase 2 – Step 2.5: Create `data.tf`

**Duration:** 45–60 Minutes

---

# 🎯 Goal

Learn how to **read existing information from AWS** without creating or modifying any infrastructure.

Terraform can retrieve information such as:

- AWS Account ID
- AWS Region
- Availability Zones
- Latest Amazon Linux AMI
- Existing VPCs
- Existing Security Groups
- Existing IAM Roles

These are called **Data Sources**.

---

# ⭐ Golden Rule

Terraform has two important concepts:

- **Resource** → Creates or manages infrastructure.
- **Data Source** → Reads existing infrastructure or metadata.

Remember this distinction throughout your Terraform journey.

---

# 📖 Theory

## What is a Data Source?

A **Data Source** allows Terraform to retrieve information that already exists.

Terraform reads information from AWS but **does not create, modify, or delete** anything.

Examples include:

- Current AWS Account ID
- Current AWS Region
- Availability Zones
- Latest Amazon Linux AMI
- Existing VPC
- Existing Security Groups
- Existing IAM Roles

Data sources make Terraform configurations dynamic and portable.

---

# Resource vs Data Source

| Resource | Data Source |
|----------|-------------|
| Creates infrastructure | Reads existing infrastructure |
| Managed by Terraform | Read-only |
| Can modify AWS resources | Cannot modify AWS resources |
| Example: `aws_vpc` | Example: `aws_availability_zones` |

---

## Example: Resource

```hcl
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}
```

This creates a new Amazon VPC.

---

## Example: Data Source

```hcl
data "aws_availability_zones" "available" {}
```

This asks AWS:

> "Which Availability Zones are available in the selected AWS Region?"

Nothing is created.

Terraform simply retrieves the information.

---

# Why Do Enterprise Teams Use Data Sources?

Hardcoding values is considered a bad practice.

For example:

```hcl
ami = "ami-0abcd1234"
```

Problems with hardcoding:

- AMI IDs change over time.
- AMIs are Region-specific.
- Older AMIs may contain security vulnerabilities.
- Infrastructure becomes difficult to maintain.

Instead, Terraform can dynamically discover the latest AMI or retrieve other AWS metadata.

This results in more flexible and reliable infrastructure.

---

# What We'll Create

In this step, we'll create three commonly used AWS data sources:

| Data Source | Purpose |
|-------------|---------|
| `aws_caller_identity` | Retrieves the current AWS account information. |
| `aws_region` | Retrieves the current AWS Region. |
| `aws_availability_zones` | Retrieves available Availability Zones. |

> **Note**
>
> We'll configure the Amazon Linux AMI data source later when building the EC2 module, where it can be explained in more detail.

---

# Create `data.tf`

Navigate to:

```text
terraform/
```

Open or create:

```text
data.tf
```

---

# Add the Following Code

```hcl
#############################################
# AWS Caller Identity
#############################################

data "aws_caller_identity" "current" {}

#############################################
# AWS Region
#############################################

data "aws_region" "current" {}

#############################################
# Availability Zones
#############################################

data "aws_availability_zones" "available" {
  state = "available"
}
```

---

# Understanding Every Data Source

## 1. AWS Caller Identity

```hcl
data "aws_caller_identity" "current" {}
```

This data source retrieves information about the AWS account currently authenticated with Terraform.

### Information Returned

- AWS Account ID
- User ARN
- User ID

### Example

```text
Account ID: 123456789012

ARN:
arn:aws:iam::123456789012:user/terraform-user
```

### Common Use Cases

- Building IAM policies
- Creating globally unique S3 bucket names
- Naming account-specific resources
- Verifying the active AWS account

---

## 2. AWS Region

```hcl
data "aws_region" "current" {}
```

This retrieves the currently configured AWS Region.

### Example Output

```text
ap-south-1
```

Instead of hardcoding:

```text
Mumbai
```

Terraform queries AWS directly.

### Benefits

- Supports multi-region deployments
- Eliminates hardcoded values
- Improves portability

---

## 3. Availability Zones

```hcl
data "aws_availability_zones" "available" {
  state = "available"
}
```

This retrieves all available Availability Zones in the selected AWS Region.

### Example Output

```text
ap-south-1a

ap-south-1b

ap-south-1c
```

### Future Use Cases

Later in the project, these Availability Zones will be used to create:

- Public Subnets
- Private Application Subnets
- Private Database Subnets

This makes the infrastructure portable across different AWS Regions.

---

# How We'll Use These Later

Example:

```hcl
availability_zone = data.aws_availability_zones.available.names[0]
```

Terraform automatically selects:

```text
ap-south-1a
```

No hardcoding is required.

If the deployment Region changes, Terraform automatically retrieves the appropriate Availability Zones.

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

---

## Validate the Configuration

Run:

```bash
terraform validate
```

### Expected Output

```text
Success! The configuration is valid.
```

> **Note**
>
> `terraform validate` only checks the syntax of the configuration.
>
> The data sources are actually queried during:
>
> - `terraform plan`
> - `terraform apply`

---

# Project Structure

After this step, your Terraform directory should look like:

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

## Data Sources

Include the following topics:

- What is a Data Source?
- Resource vs Data Source
- Benefits of Dynamic Values
- Why Avoid Hardcoded AMIs?
- Why Avoid Hardcoded Availability Zones?

---

# Best Practices

- Prefer data sources over hardcoded values.
- Use data sources to retrieve dynamic AWS information.
- Avoid storing Region-specific values directly in the code.
- Use data sources to improve portability across AWS Regions.
- Keep data source definitions in a dedicated `data.tf` file.
- Validate the configuration after every change.

---

# Common Issues

| Issue | Cause | Solution |
|-------|-------|----------|
| Authentication failed | Invalid AWS credentials | Verify credentials using `aws sts get-caller-identity`. |
| No Availability Zones returned | Incorrect or unsupported AWS Region | Verify the configured Region in `provider.tf` or `variables.tf`. |
| Access denied | Insufficient IAM permissions | Ensure the IAM user or role has permission to query AWS metadata. |

---

# Summary

In this step, you:

- Created the `data.tf` file.
- Learned the purpose of Terraform Data Sources.
- Understood the difference between Resources and Data Sources.
- Retrieved the current AWS Account information.
- Retrieved the current AWS Region.
- Retrieved available Availability Zones.
- Learned why enterprise Terraform projects avoid hardcoded values.
- Successfully validated the Terraform configuration.

Using Data Sources makes Terraform configurations more dynamic, portable, and maintainable while reducing reliance on hardcoded infrastructure values.

---

# Next Step

In **Step 2.6**, you'll create **`outputs.tf`**, where you'll learn how to display useful information after Terraform operations, such as:

- AWS Account ID
- AWS Region
- Availability Zones
- Resource IDs
- Public IP Addresses
- Load Balancer DNS Names

Outputs make Terraform deployments easier to verify and integrate with other modules or automation workflows.

---

# 🚀 Phase 2 – Step 2.6: Create `outputs.tf`

**Duration:** 45–60 Minutes

---

# 🎯 Goal

Learn how to expose useful information from Terraform after a deployment.

Outputs are one of the most important Terraform concepts because they allow you to:

- Display useful information
- Pass values between modules
- Integrate with CI/CD pipelines
- Debug infrastructure
- Feed values into other Terraform configurations

---

# 📖 Theory

## What are Outputs?

Outputs are values that Terraform displays after a successful deployment.

They make it easy to view important resource information without searching through the AWS Management Console.

Example:

```text
Apply complete!

Outputs:

vpc_id = "vpc-0abc123"

alb_dns_name = "linkedin-dev-alb-123456.ap-south-1.elb.amazonaws.com"

rds_endpoint = "linkedin-db.xxxxx.amazonaws.com"
```

Instead of manually locating these values in AWS, Terraform displays them automatically.

---

# Why Use Outputs?

Imagine your infrastructure creates:

- Amazon VPC
- Amazon EC2
- Application Load Balancer
- Amazon RDS

Without outputs:

- You must search AWS Console for IDs.
- You must manually copy DNS names.
- You must locate database endpoints.

With outputs:

Terraform automatically displays this information after deployment.

This saves time and reduces mistakes.

---

# Enterprise Use Cases

Outputs are commonly used to expose:

- VPC ID
- Public Subnet IDs
- Private Subnet IDs
- Security Group IDs
- Application Load Balancer DNS Name
- RDS Endpoint
- IAM Role ARN
- EC2 Instance IDs

In CI/CD pipelines, these outputs are often consumed by later deployment stages.

---

# What We'll Output in Phase 2

Since no AWS resources have been created yet, we'll expose values from the AWS Data Sources configured in `data.tf`.

The outputs will include:

| Output | Source |
|---------|--------|
| AWS Account ID | `aws_caller_identity` |
| AWS Region | `aws_region` |
| Availability Zones | `aws_availability_zones` |

---

# Create `outputs.tf`

Navigate to:

```text
terraform/
```

Open or create:

```text
outputs.tf
```

---

# Add the Following Code

```hcl
#############################################
# AWS Account Information
#############################################

output "aws_account_id" {
  description = "AWS Account ID currently in use."
  value       = data.aws_caller_identity.current.account_id
}

#############################################
# AWS Region
#############################################

output "aws_region" {
  description = "AWS Region where Terraform is running."
  value       = data.aws_region.current.name
}

#############################################
# Availability Zones
#############################################

output "availability_zones" {
  description = "Available Availability Zones in the selected AWS region."
  value       = data.aws_availability_zones.available.names
}
```

---

# Understanding Every Output

## 1. AWS Account ID

```hcl
output "aws_account_id"
```

This output retrieves the AWS Account ID from:

```hcl
data.aws_caller_identity.current.account_id
```

### Example Output

```text
123456789012
```

### Common Use Cases

- IAM Policies
- Globally unique S3 bucket names
- Multi-account deployments
- Account-specific automation

---

## 2. AWS Region

```hcl
output "aws_region"
```

This output displays the AWS Region currently configured in the provider.

### Example Output

```text
ap-south-1
```

Because the value comes from a Data Source, Terraform always reports the actual Region being used.

---

## 3. Availability Zones

```hcl
output "availability_zones"
```

This output lists all available Availability Zones in the configured AWS Region.

### Example Output

```text
[
  "ap-south-1a",
  "ap-south-1b",
  "ap-south-1c"
]
```

### Future Use Cases

These Availability Zones will later be used when creating:

- Public Subnets
- Private Application Subnets
- Private Database Subnets

Using dynamic values makes the infrastructure portable across AWS Regions.

---

# How Outputs Are Used Later

Outputs become especially valuable when working with modules.

For example, the VPC module may expose the VPC ID:

```hcl
output "vpc_id" {
  value = aws_vpc.main.id
}
```

Another module can then reference it:

```hcl
module.vpc.vpc_id
```

This is one of the core principles of modular Terraform design.

Modules communicate with one another through outputs.

---

# Root Outputs vs Module Outputs

Terraform supports two common types of outputs.

| Type | Purpose |
|------|---------|
| Root Outputs | Display information after `terraform apply` |
| Module Outputs | Share values between Terraform modules |

Both use the same `output` block syntax.

---

# Outputs in CI/CD Pipelines

Outputs are frequently consumed by deployment automation.

Examples include:

- Passing the ALB DNS name to application deployment jobs.
- Supplying the RDS endpoint to configuration management.
- Sharing VPC IDs with downstream Terraform modules.
- Providing infrastructure details to automated testing pipelines.

Outputs simplify integration between infrastructure and application deployment workflows.

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

---

## Validate the Configuration

Run:

```bash
terraform validate
```

### Expected Output

```text
Success! The configuration is valid.
```

---

## Preview the Outputs

Run:

```bash
terraform plan
```

Depending on whether the values can be resolved during planning, Terraform may display the outputs.

After applying the configuration:

```bash
terraform apply
```

Terraform displays the output values automatically.

You can also retrieve outputs later using:

```bash
terraform output
```

---

# Project Structure

After this step, your Terraform directory should look like:

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

## Outputs

Cover the following topics:

- What are Outputs?
- Why use Outputs?
- Root Outputs
- Module Outputs
- CI/CD Integration

---

# Best Practices

- Output only information that users or other modules require.
- Use meaningful output names.
- Add descriptions to every output.
- Avoid exposing sensitive values unless necessary.
- Use outputs for module communication.
- Keep `outputs.tf` dedicated to output definitions.
- Validate the configuration after adding new outputs.

---

# Common Issues

| Issue | Cause | Solution |
|-------|-------|----------|
| Output value not found | Incorrect resource or data source reference | Verify the referenced resource or data source exists. |
| Output shows `(known after apply)` | Value depends on resources that have not yet been created | Run `terraform apply` to resolve the value. |
| Incorrect output value | Wrong attribute referenced | Verify the attribute name in the Terraform documentation. |

---

# Summary

In this step, you:

- Created the `outputs.tf` file.
- Learned the purpose of Terraform Outputs.
- Displayed AWS Account ID.
- Displayed the current AWS Region.
- Displayed available Availability Zones.
- Learned how outputs enable communication between modules.
- Understood how outputs integrate with CI/CD pipelines.
- Successfully validated the Terraform configuration.

Outputs are a fundamental part of Terraform because they make infrastructure easier to understand, simplify module integration, and support automation across enterprise environments.

---

# Next Step

In **Step 2.7**, you'll create **`main.tf`**, where you'll prepare the root Terraform configuration that will later connect all infrastructure modules such as:

- VPC
- Security Groups
- EC2
- Application Load Balancer
- Auto Scaling Group
- Amazon RDS

This completes the Terraform project foundation and prepares the project for infrastructure provisioning in the next phase.

---

# 🚀 Phase 2 – Step 2.7: Create `terraform.tfvars`

**Duration:** 30–45 Minutes

---

# 🎯 Goal

Move environment-specific values out of the Terraform code and into a dedicated variables file.

This follows enterprise best practices by separating:

- Variable **definitions**
- Variable **values**

This makes the Terraform configuration reusable across multiple environments.

---

# 📖 Theory

## What is `terraform.tfvars`?

When Terraform detects a file named:

```text
terraform.tfvars
```

it automatically loads the variable values from that file.

Instead of running:

```bash
terraform apply \
-var="project_name=linkedin" \
-var="environment=dev"
```

you simply create a file containing:

```hcl
project_name = "linkedin"
environment  = "dev"
aws_region   = "ap-south-1"
```

Terraform automatically reads these values during execution.

---

# Variable Flow

```text
variables.tf
        │
        ▼
Defines Variables

        │
        ▼
terraform.tfvars

Provides Values

        │
        ▼
provider.tf
locals.tf
modules
resources
```

---

# Why Use `.tfvars` Files?

Imagine your infrastructure supports three environments.

- Development
- Staging
- Production

Without `.tfvars`:

```text
Edit variables.tf

↓

Deploy

↓

Edit again

↓

Deploy

↓

Edit again

↓

Deploy
```

This is error-prone and difficult to maintain.

---

With `.tfvars`:

```text
dev.tfvars

stage.tfvars

prod.tfvars
```

Simply choose the appropriate file during deployment.

No Terraform code changes are required.

---

# Create `terraform.tfvars`

Navigate to:

```text
terraform/
```

Create:

```text
terraform.tfvars
```

---

# Add the Following Code

```hcl
#############################################
# Project Configuration
#############################################

project_name = "linkedin"

environment = "dev"

#############################################
# AWS Configuration
#############################################

aws_region = "ap-south-1"
```

---

# What Happens Now?

Terraform automatically loads:

```hcl
project_name = "linkedin"
```

This value is assigned to:

```hcl
variable "project_name"
```

Next:

```hcl
local.name_prefix
```

becomes:

```text
linkedin-dev
```

Finally, the AWS Provider reads:

```hcl
region = var.aws_region
```

which becomes:

```text
ap-south-1
```

No manual command-line variables are required.

---

# Variable Precedence

Terraform resolves variables using the following order of precedence.

| Priority | Source |
|-----------|--------|
| **1** | Command-line arguments (`-var`, `-var-file`) |
| **2** | `*.auto.tfvars` |
| **3** | `terraform.tfvars` |
| **4** | Environment Variables (`TF_VAR_*`) |
| **5** | Default values in `variables.tf` |

Terraform always uses the highest-priority value available.

---

# Enterprise Best Practice

At this point, your variables may still look like this:

```hcl
variable "project_name" {
  description = "Name of the project."
  type        = string
  default     = "linkedin"
}
```

Since values are now supplied through `terraform.tfvars`, the default values are no longer required.

---

# Update `variables.tf`

Change:

```hcl
variable "project_name" {
  description = "Name of the project."
  type        = string
  default     = "linkedin"
}
```

to:

```hcl
variable "project_name" {
  description = "Name of the project."
  type        = string
}
```

---

Do the same for:

- `environment`
- `aws_region`

---

Keep the validation block for `environment`, but remove the default value.

Example:

```hcl
variable "environment" {
  description = "Deployment environment."
  type        = string

  validation {
    condition = contains(
      ["dev", "stage", "prod"],
      var.environment
    )

    error_message = "Environment must be one of: dev, stage, or prod."
  }
}
```

---

# Why Remove Defaults?

Removing default values makes the variables **required**.

Benefits include:

- Prevents accidental deployments
- Forces explicit configuration
- Supports multiple environments
- Follows production best practices
- Improves deployment reliability

Enterprise Terraform projects commonly use this approach.

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

---

## Validate the Configuration

Run:

```bash
terraform validate
```

Expected output:

```text
Success! The configuration is valid.
```

---

## Generate an Execution Plan

Run:

```bash
terraform plan
```

Expected behavior:

Terraform automatically loads values from:

```text
terraform.tfvars
```

The outputs should remain the same as before because the variable values are now coming from the `.tfvars` file instead of defaults.

---

# Project Structure

After this step, your project should look like:

```text
terraform/
│
├── versions.tf
├── provider.tf
├── variables.tf
├── terraform.tfvars
├── locals.tf
├── data.tf
├── outputs.tf
├── main.tf
├── modules/
└── environments/
```

---

## `terraform.tfvars`

Include the following topics:

- What is `terraform.tfvars`?
- Purpose of `.tfvars` files
- Variable precedence
- Why separate variable definitions from values?
- Environment-specific configuration
- Enterprise best practices

---

# Best Practices

- Keep variable definitions in `variables.tf`.
- Store environment-specific values in `.tfvars` files.
- Remove unnecessary default values for production deployments.
- Use separate `.tfvars` files for different environments.
- Never commit sensitive `.tfvars` files containing secrets.
- Validate the configuration after every change.

---

# Common Issues

| Issue | Cause | Solution |
|-------|-------|----------|
| Variable value not loaded | `terraform.tfvars` is missing or incorrectly named | Ensure the file is named exactly `terraform.tfvars`. |
| Missing required variable | Default value removed and no value supplied | Add the value to `terraform.tfvars` or provide it using `-var` or `-var-file`. |
| Validation error for `environment` | Invalid environment value | Use `dev`, `stage`, or `prod`. |

---

# Summary

In this step, you:

- Created the `terraform.tfvars` file.
- Learned how Terraform automatically loads variable values.
- Separated variable definitions from variable values.
- Removed default values from `variables.tf`.
- Learned Terraform variable precedence.
- Adopted an enterprise-friendly configuration approach.
- Successfully validated and planned the Terraform configuration.

Using `terraform.tfvars` keeps Terraform configurations clean, reusable, and ready for multi-environment deployments. It is a standard practice in enterprise Infrastructure as Code projects.

---

# Next Step

In the next phase, you'll begin creating actual AWS infrastructure using reusable Terraform modules, starting with networking components such as:

- Amazon VPC
- Public and Private Subnets
- Internet Gateway
- NAT Gateway
- Route Tables

The strong foundation built in Phase 2 will now support scalable, modular, and production-ready infrastructure provisioning.

---

# 🚀 Phase 2 – Step 2.8: Create `main.tf`

**Duration:** 20–30 Minutes

---

# 🎯 Goal

Create the **Root Module orchestration layer** for the Terraform project.

### Enterprise Rule

`main.tf` should **not** contain all your AWS resources.

Instead, it should orchestrate reusable Terraform modules.

This is one of the biggest differences between a **beginner Terraform project** and a **production-ready enterprise project**.

---

# 📖 Theory

## What is `main.tf`?

`main.tf` is the **entry point** of a Terraform project.

Although Terraform doesn't require a file named `main.tf`, it is the industry-standard convention used in almost every Terraform project.

Terraform automatically loads **all `.tf` files** in the current directory.

The filename itself is not important—the contents are.

---

# Enterprise Terraform File Structure

By convention, Terraform projects organize files like this:

| File | Responsibility |
|------|----------------|
| `versions.tf` | Terraform and Provider version constraints |
| `provider.tf` | Provider configuration |
| `variables.tf` | Input variables |
| `terraform.tfvars` | Variable values |
| `locals.tf` | Local values |
| `data.tf` | Data sources |
| `outputs.tf` | Outputs |
| `main.tf` | Root module orchestration |

Keeping responsibilities separated improves readability and maintainability.

---

# Beginner vs Enterprise

## ❌ Beginner Project

Everything is written inside one file.

```text
main.tf

├── VPC
├── Internet Gateway
├── Route Tables
├── EC2
├── Security Groups
├── ALB
├── Auto Scaling
├── RDS
├── IAM
└── CloudWatch
```

Problems:

- Huge file
- Difficult to maintain
- Hard to debug
- Poor reusability
- Difficult collaboration

---

## ✅ Enterprise Project

The root module only connects reusable modules.

```text
main.tf

│
├── module.vpc
├── module.security_group
├── module.iam
├── module.alb
├── module.ec2
├── module.autoscaling
├── module.rds
└── module.monitoring
```

Each module has:

- Its own folder
- Its own variables
- Its own outputs
- A single responsibility

This follows Terraform best practices.

---

# Why Use Modules?

Imagine building infrastructure for:

- LinkedIn
- Airbnb
- Netflix

Without modules:

You rewrite the VPC configuration three times.

With modules:

```text
modules/
└── vpc/
```

The same module can be reused in every project.

---

## Benefits of Modules

- Reusable
- Easier testing
- Better maintenance
- Cleaner code
- Smaller files
- Easier collaboration
- Consistent architecture

Modules are the foundation of enterprise Terraform development.

---

# What Should `main.tf` Contain Today?

At this stage of the project:

- No VPC module exists.
- No EC2 module exists.
- No RDS module exists.

Therefore, **do not** add placeholder module blocks.

Instead, create a documented entry point that explains the future purpose of the file.

---

# Create `main.tf`

Navigate to:

```text
terraform/
```

Open:

```text
main.tf
```

Replace the contents with the following:

```hcl
#############################################
# Root Module
#############################################

# This file serves as the entry point for the Terraform configuration.
#
# As the project evolves, it will orchestrate reusable modules such as:
#
# - VPC
# - Security Groups
# - IAM
# - Application Load Balancer
# - EC2
# - Auto Scaling Group
# - RDS
# - CloudWatch Monitoring
#
# All infrastructure resources will be created inside dedicated modules
# located under the modules/ directory.
```

That's all.

No resources.

No modules.

Only documentation.

---

# Why Not Add Empty Modules?

Some tutorials suggest creating empty module blocks like this:

```hcl
module "vpc" {

}
```

This is **not valid**.

Terraform expects every module to have at least:

- A `source`
- A valid module directory
- Configuration

Without these, Terraform produces validation errors.

---

# Example of an Invalid Module

```hcl
module "vpc" {

}
```

Terraform cannot determine:

- Where the module is located.
- What resources it contains.
- What variables it requires.

---

# When Should Module Blocks Be Added?

Only after the module actually exists.

For example:

```text
modules/

└── vpc/
```

Once the module is created, the root module can reference it.

---

# How `main.tf` Will Look in Phase 3

After creating the VPC module, `main.tf` will evolve into something like this:

```hcl
module "vpc" {

  source = "./modules/vpc"

  project_name = var.project_name

  environment = var.environment

  common_tags = local.common_tags

}
```

Notice that the root module:

- Passes variables
- Passes locals
- Calls reusable modules

It does **not** define the actual AWS resources.

---

# Root Module Responsibilities

The root module should:

- Connect modules together.
- Pass variables to modules.
- Pass local values.
- Configure providers.
- Expose outputs.

It should **not** contain hundreds of AWS resources.

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

---

## Validate the Configuration

Run:

```bash
terraform validate
```

Expected output:

```text
Success! The configuration is valid.
```

---

## Generate the Execution Plan

Run:

```bash
terraform plan
```

Expected behavior:

Terraform should still display only the existing Outputs because no infrastructure resources have been defined yet.

---

# Project Structure

After this step, your project should look like:

```text
terraform/
│
├── versions.tf
├── provider.tf
├── variables.tf
├── terraform.tfvars
├── locals.tf
├── data.tf
├── outputs.tf
├── main.tf
├── modules/
└── environments/
```

---

## Root Module

Include the following topics:

- What is the Root Module?
- Why keep `main.tf` small?
- Why use Terraform Modules?
- How modules improve reusability
- Root Module vs Child Modules
- Enterprise Terraform project structure

---

# Best Practices

- Keep `main.tf` focused on orchestration.
- Never place all AWS resources in the root module.
- Create reusable modules with a single responsibility.
- Pass variables and locals into modules instead of hardcoding values.
- Add module blocks only after the module exists.
- Validate the configuration after every change.

---

# Common Issues

| Issue | Cause | Solution |
|-------|-------|----------|
| Empty module block | Module has no `source` or configuration | Add module blocks only after creating the module. |
| Large `main.tf` file | All infrastructure defined in the root module | Move resources into reusable modules. |
| Duplicate infrastructure code | Resources copied between projects | Create reusable modules inside the `modules/` directory. |

---

# Summary

In this step, you:

- Created the `main.tf` file.
- Learned the purpose of the Root Module.
- Understood why enterprise Terraform projects keep `main.tf` small.
- Learned why reusable modules are essential.
- Prepared the project for modular infrastructure development.
- Successfully validated the Terraform configuration.

The Root Module acts as the **orchestrator** of the entire Terraform project. As the project grows, `main.tf` will connect reusable modules rather than defining infrastructure directly, resulting in a cleaner, more scalable, and production-ready Infrastructure as Code architecture.

---

# Next Step

Phase 2 is now complete.

In **Phase 3**, you'll begin creating reusable Terraform modules, starting with the **VPC module**, where you'll provision foundational networking components such as:

- Amazon VPC
- Public Subnets
- Private Subnets
- Internet Gateway
- NAT Gateway
- Route Tables

From this point onward, the project transitions from building the Terraform foundation to provisioning real AWS infrastructure using enterprise-grade modular design.

---

# 🚀 Phase 3.1 – VPC Design & Architecture

**Duration:** 2–3 Hours

---

# 🎯 Goal

Design a **production-ready AWS network architecture** for the **LinkedIn Clone** application before implementing it with Terraform.

In enterprise environments, infrastructure design comes **before** Infrastructure as Code (IaC). A well-designed architecture results in secure, scalable, and highly available deployments.

---

# 📖 Learning Objectives

By the end of this step, you will understand:

- What is a Virtual Private Cloud (VPC)?
- Why create a custom VPC?
- CIDR planning
- Public vs Private Subnets
- High Availability (HA)
- Internet Gateway
- NAT Gateway (Design Only)
- Route Tables
- Security considerations
- Enterprise networking best practices

---

# Business Requirement

Imagine your manager gives you the following requirement:

> **"Deploy our LinkedIn Clone application on AWS with high availability, security, scalability, and a production-ready architecture."**

Before opening VS Code or writing Terraform code, the first step is to design the architecture.

Infrastructure should always be planned before implementation.

---

# Application Architecture

Our application consists of three logical layers.

```text
Internet Users
        │
        ▼
Application Load Balancer
        │
        ▼
Spring Boot Application
        │
        ▼
PostgreSQL Database
```

Now let's map this application architecture to AWS networking components.

---

# AWS Network Architecture

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

This architecture follows AWS Well-Architected Framework recommendations for production deployments.

---

# Why This Design?

Every architectural decision should have a clear justification.

Interviewers often evaluate your reasoning more than your Terraform syntax.

---

# 1. Custom VPC

### CIDR Block

```text
10.0.0.0/16
```

### Why?

A custom VPC provides complete control over:

- IP Addressing
- Subnet Design
- Route Tables
- Security
- Internet Connectivity
- Network Isolation

Using a custom VPC also avoids relying on the AWS default VPC, which is generally not recommended for production workloads.

---

### Interview Answer

> "A Virtual Private Cloud (VPC) is a logically isolated virtual network within AWS. It allows us to control IP addressing, routing, network security, and connectivity for our applications."

---

# 2. Public Subnets

### Purpose

Public Subnets host resources that must communicate directly with the Internet.

Resources include:

- Application Load Balancer
- NAT Gateway (introduced later)

Traffic flow:

```text
Internet
     │
     ▼
Internet Gateway
     │
     ▼
Public Subnets
```

Public Subnets have routes that allow internet connectivity through the Internet Gateway.

---

# 3. Private Application Subnets

### Purpose

Private Application Subnets host the application layer.

Resources include:

- Amazon EC2
- Auto Scaling Group

---

### Question

Should users access EC2 instances directly?

**No.**

Users should only access the:

```text
Application Load Balancer
```

The ALB distributes traffic to private EC2 instances.

---

### Benefits

- Better security
- No public EC2 IP addresses
- Centralized traffic management
- Simplified Auto Scaling
- Reduced attack surface

---

# 4. Private Database Subnets

### Purpose

Private Database Subnets host the PostgreSQL database.

Resources include:

- Amazon RDS PostgreSQL

---

### Database Traffic Flow

Correct flow:

```text
Internet
     │
     ▼
Application Load Balancer
     │
     ▼
EC2
     │
     ▼
Amazon RDS
```

Incorrect flow:

```text
Internet
     │
     ▼
Amazon RDS
```

Databases should never be directly exposed to the public Internet.

---

# CIDR Planning

Proper IP address planning is a fundamental networking skill.

The following CIDR blocks will be used.

| Resource | CIDR |
|----------|------|
| VPC | `10.0.0.0/16` |
| Public Subnet A | `10.0.1.0/24` |
| Public Subnet B | `10.0.2.0/24` |
| Private App Subnet A | `10.0.11.0/24` |
| Private App Subnet B | `10.0.12.0/24` |
| Private DB Subnet A | `10.0.21.0/24` |
| Private DB Subnet B | `10.0.22.0/24` |

---

# Why Use `/16` for the VPC?

A `/16` CIDR block provides:

- 65,536 IP addresses
- Flexibility for future growth
- Support for multiple subnet tiers
- Enterprise scalability

It is a common choice for production environments.

---

# Why Use `/24` for Each Subnet?

Each `/24` subnet provides:

- 256 IP addresses
- Clear separation of network tiers
- Easy subnet management
- A widely adopted production design pattern

---

# Availability Zones

The infrastructure will span two Availability Zones.

| Availability Zone | Resources |
|-------------------|-----------|
| `ap-south-1a` | Public, Application, Database Subnets |
| `ap-south-1b` | Public, Application, Database Subnets |

---

# Why Only Two Availability Zones?

Using two Availability Zones provides:

- High Availability
- Fault Tolerance
- Multi-AZ deployment support
- Lower cost than spanning three Availability Zones
- Sufficient redundancy for this project

---

# Network Flow

Every user request follows this path.

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
PostgreSQL RDS
```

This layered architecture improves scalability and security.

---

# Security Design

The infrastructure follows the principle of **least exposure**.

| Layer | Publicly Accessible |
|-------|:-------------------:|
| Application Load Balancer | ✅ Yes |
| EC2 Instances | ❌ No |
| PostgreSQL Database | ❌ No |

Only the Application Load Balancer accepts traffic from the Internet.

Application servers and databases remain private.

---

# Future Networking Components

The following networking resources will be implemented in upcoming steps.

```text
Internet Gateway
        │
        ▼
NAT Gateway
        │
        ▼
Route Tables
        │
        ▼
Security Groups
        │
        ▼
IAM Roles
        │
        ▼
CloudWatch
```

The design is completed first, followed by implementation.

---

# VPC Module Structure

The VPC will be implemented as a reusable Terraform module.

```text
terraform/
└── modules/
    └── vpc/
        ├── main.tf
        ├── variables.tf
        ├── outputs.tf
        └── README.md
```

This modular structure promotes:

- Code reuse
- Easier maintenance
- Independent testing
- Cleaner project organization

Future modules such as **ALB**, **EC2**, **RDS**, and **IAM** will follow the same pattern.

---

# Best Practices

- Design the architecture before writing Terraform.
- Use a custom VPC instead of the default VPC.
- Keep databases in private subnets.
- Place internet-facing resources only in public subnets.
- Deploy across multiple Availability Zones.
- Follow a layered network architecture.
- Build reusable Terraform modules.
- Plan CIDR ranges carefully to support future expansion.

---

# Phase Summary

After completing **Phase 3.1 – VPC Design & Architecture**, you will have:

- Designed a production-ready AWS network.
- Understood VPC architecture and subnet design.
- Planned CIDR allocation for the entire infrastructure.
- Learned the purpose of public and private subnets.
- Designed a Multi-AZ architecture for High Availability.
- Applied security-first networking principles.
- Prepared the project for implementing the reusable Terraform VPC module.

This architectural foundation will guide every networking component created in the upcoming Terraform implementation phases.

---

# 🚀 Phase 3.2 – Build the VPC Module

**Duration:** 2–4 Hours

---

# 🎯 Goal

Create a reusable **Terraform VPC Module** that provisions:

- ✅ Custom Amazon VPC
- ✅ DNS Support
- ✅ DNS Hostnames
- ✅ Enterprise Resource Tags
- ✅ Module Outputs

> **Note:**  
> In this step, we will **only create the VPC**. Public Subnets, Private Subnets, Internet Gateway, NAT Gateway, and Route Tables will be implemented in the upcoming steps to understand each networking component individually.

---

# 📖 Learning Objectives

By the end of this step, you will understand:

- Terraform Modules
- Root Module vs Child Module
- Module Inputs
- Module Outputs
- Amazon VPC Fundamentals
- AWS DNS Configuration
- Enterprise Tagging Strategy
- Terraform Module Best Practices

---

# What Is a Terraform Module?

A **Terraform Module** is a reusable collection of Terraform configuration files.

Instead of writing infrastructure repeatedly, we package related resources into modules.

Example:

```text
VPC Module

↓

Reusable

↓

LinkedIn Project

↓

Airbnb Project

↓

Netflix Project
```

The module remains unchanged.

Only the input values change.

---

# Root Module vs Child Module

## Root Module

The Root Module is the entry point of the Terraform project.

Responsibilities:

- Configure providers
- Pass variables
- Call modules
- Expose outputs

Example:

```text
terraform/
│
├── main.tf
├── variables.tf
├── outputs.tf
└── terraform.tfvars
```

---

## Child Module

A Child Module contains reusable infrastructure.

Example:

```text
modules/
└── vpc/
```

Responsibilities:

- Create AWS resources
- Accept input variables
- Return outputs

---

# Module Structure

Create the following directory structure.

```text
terraform/
└── modules/
    └── vpc/
        ├── main.tf
        ├── variables.tf
        ├── outputs.tf
        └── README.md
```

> **Note:**  
> We will **not** create a `locals.tf` file inside the module at this stage.  
> Local values will continue to be managed by the Root Module.

---

# Step 1 – Create the Module Folder

Create the following directory.

```text
terraform/
└── modules/
    └── vpc/
```

---

# Step 2 – Create `modules/vpc/variables.tf`

Create:

```text
terraform/modules/vpc/variables.tf
```

Add the following code.

```hcl
#############################################
# VPC Variables
#############################################

variable "project_name" {
  description = "Project name."
  type        = string
}

variable "environment" {
  description = "Deployment environment."
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
}

variable "common_tags" {
  description = "Common tags applied to all resources."
  type        = map(string)
}
```

---

# Why These Variables?

The module is designed to be reusable.

Today:

```text
Project = LinkedIn
```

Tomorrow:

```text
Project = Airbnb
```

Next month:

```text
Project = Netflix
```

The module remains exactly the same.

Only the input values change.

This is one of the core principles of modular Terraform design.

---

# Step 3 – Create `modules/vpc/main.tf`

Create:

```text
terraform/modules/vpc/main.tf
```

Add:

```hcl
#############################################
# VPC
#############################################

resource "aws_vpc" "main" {

  cidr_block           = var.vpc_cidr

  enable_dns_support   = true

  enable_dns_hostnames = true

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-vpc"
    }
  )
}
```

---

# Understanding Every Line

## `cidr_block`

```hcl
cidr_block = var.vpc_cidr
```

We avoid hardcoding values.

Instead of:

```text
10.0.0.0/16
```

the Root Module provides the CIDR block.

Benefits:

- Reusability
- Flexibility
- Environment independence

---

## `enable_dns_support`

```hcl
enable_dns_support = true
```

Enables AWS DNS resolution inside the VPC.

Without this:

- EC2 instances cannot resolve AWS DNS names.
- Many AWS-managed services will not function correctly.

### Recommendation

Always enable DNS support unless you have a specific architectural reason not to.

---

## `enable_dns_hostnames`

```hcl
enable_dns_hostnames = true
```

Allows EC2 instances to receive DNS hostnames.

Example:

```text
ip-10-0-1-15.ap-south-1.compute.internal
```

Required for many AWS services and internal communication.

---

## Enterprise Tags

```hcl
tags = merge(
  var.common_tags,
  {
    Name = "${var.project_name}-${var.environment}-vpc"
  }
)
```

The `merge()` function combines:

Shared tags from the Root Module:

- Project
- Environment
- ManagedBy
- Owner
- Repository

with the resource-specific tag:

```text
Name = linkedin-dev-vpc
```

Final result:

```text
Project     = linkedin
Environment = dev
ManagedBy   = Terraform
Owner       = Mukesh Kumar
Repository  = terraform-aws-infrastructure
Name        = linkedin-dev-vpc
```

---

# Step 4 – Create `modules/vpc/outputs.tf`

Create:

```text
terraform/modules/vpc/outputs.tf
```

Add:

```hcl
#############################################
# VPC Outputs
#############################################

output "vpc_id" {
  description = "ID of the VPC."
  value       = aws_vpc.main.id
}

output "vpc_arn" {
  description = "ARN of the VPC."
  value       = aws_vpc.main.arn
}

output "vpc_cidr" {
  description = "CIDR block of the VPC."
  value       = aws_vpc.main.cidr_block
}
```

---

# Why Outputs?

Outputs expose important information from the Child Module.

Later modules such as:

- Public Subnets
- Security Groups
- EC2
- RDS

will consume the VPC ID.

Example:

```hcl
module.vpc.vpc_id
```

---

# Step 5 – Create `modules/vpc/README.md`

Create:

```text
terraform/modules/vpc/README.md
```

Add:

````markdown
# VPC Module

## Purpose

Creates a reusable AWS VPC.

## Resources

- AWS VPC

## Inputs

- project_name
- environment
- vpc_cidr
- common_tags

## Outputs

- vpc_id
- vpc_arn
- vpc_cidr
---

# 🚀 Phase 3.3 – Subnet Design

**Duration:** 2–3 Hours

---

# 🎯 Goal

Design the subnet architecture for the production VPC.

In this step, we'll prepare the Terraform module to support:

- ✅ Public Subnet A
- ✅ Public Subnet B
- ✅ Private Application Subnet A
- ✅ Private Application Subnet B
- ✅ Private Database Subnet A
- ✅ Private Database Subnet B

> **Note**
>
> In this step, we are **designing the subnet architecture and updating module inputs only**.
>
> The actual subnet resources (`aws_subnet`) will be created in the next step.

---

# 📖 Learning Objectives

By the end of this step, you'll understand:

- Why production VPCs use multiple subnets
- Public vs Private subnet design
- Application tier vs Database tier
- CIDR planning
- Availability Zones
- Terraform list variables
- Passing lists into modules
- Enterprise networking best practices

---

# Final Network Layout

```text
VPC
10.0.0.0/16

│

├── Public Subnet A

├── Public Subnet B

├── Private App Subnet A

├── Private App Subnet B

├── Private DB Subnet A

└── Private DB Subnet B
```

This network design provides logical separation between internet-facing resources, application servers, and the database layer.

---

# Why Six Subnets?

One of the most common AWS interview questions is:

> **"Why not create a single subnet?"**

Production workloads require much more than a single network.

Using six subnets provides:

- High Availability
- Better Security
- Network Isolation
- Separation of Responsibilities
- Scalability
- Easier Maintenance

Each subnet serves a dedicated purpose.

---

# Public Subnets

## Purpose

Public Subnets host resources that must communicate directly with the Internet.

Resources include:

- Application Load Balancer (ALB)
- NAT Gateway (added later)

Traffic flow:

```text
Internet
     │
     ▼
Internet Gateway
     │
     ▼
Public Subnets
```

Only internet-facing resources belong here.

---

# Private Application Subnets

## Purpose

Private Application Subnets host the application layer.

Resources include:

- Amazon EC2
- Auto Scaling Group

Characteristics:

- No public IP addresses
- Accessible only through the ALB
- Protected by Security Groups

Users never connect directly to these instances.

---

# Private Database Subnets

## Purpose

Private Database Subnets host the database layer.

Resources include:

- Amazon RDS PostgreSQL

Traffic flow:

```text
Internet
     │
     ▼
Application Load Balancer
     │
     ▼
EC2
     │
     ▼
Amazon RDS
```

The database is never directly accessible from the Internet.

---

# CIDR Plan

The following CIDR allocation will be used throughout the project.

| Resource | CIDR | Availability Zone |
|-----------|------|-------------------|
| Public Subnet A | `10.0.1.0/24` | `ap-south-1a` |
| Public Subnet B | `10.0.2.0/24` | `ap-south-1b` |
| Private App Subnet A | `10.0.11.0/24` | `ap-south-1a` |
| Private App Subnet B | `10.0.12.0/24` | `ap-south-1b` |
| Private DB Subnet A | `10.0.21.0/24` | `ap-south-1a` |
| Private DB Subnet B | `10.0.22.0/24` | `ap-south-1b` |

---

# Why This CIDR Layout?

The subnet ranges are intentionally separated.

Benefits include:

- Easier identification
- Better organization
- Simpler troubleshooting
- Room for future expansion

Example:

```text
10.0.1.x

↓

Public

10.0.11.x

↓

Application

10.0.21.x

↓

Database
```

This structure is commonly used in enterprise AWS environments.

---

# First Improvement to the VPC Module

The current VPC module contains only the VPC resource.

Instead of hardcoding subnet CIDRs later, we'll make them configurable.

This makes the module reusable across:

- Development
- Staging
- Production
- Future projects

---

# Step 1 – Update `modules/vpc/variables.tf`

Add the following variables.

```hcl
#############################################
# Availability Zones
#############################################

variable "availability_zones" {
  description = "Availability Zones used by the VPC."
  type        = list(string)
}

#############################################
# Public Subnets
#############################################

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets."
  type        = list(string)
}

#############################################
# Private Application Subnets
#############################################

variable "private_app_subnet_cidrs" {
  description = "CIDR blocks for private application subnets."
  type        = list(string)
}

#############################################
# Private Database Subnets
#############################################

variable "private_db_subnet_cidrs" {
  description = "CIDR blocks for private database subnets."
  type        = list(string)
}
```

---

# Why Use Lists?

Each subnet category contains multiple values.

Example:

```text
Public Subnets

↓

10.0.1.0/24

10.0.2.0/24
```

Terraform stores these values as a list.

Example:

```hcl
public_subnet_cidrs = [

  "10.0.1.0/24",

  "10.0.2.0/24"

]
```

Lists make it easy to iterate over resources later using:

- `count`
- `for_each`

---

# Step 2 – Update Root `variables.tf`

Add the same variable definitions to the Root Module.

These variables allow the Root Module to pass subnet configuration into the Child Module.

The Root Module remains responsible for configuration.

The Child Module remains responsible for implementation.

---

# Step 3 – Update `terraform.tfvars`

Add the following values.

```hcl
#############################################
# Availability Zones
#############################################

availability_zones = [
  "ap-south-1a",
  "ap-south-1b"
]

#############################################
# Public Subnets
#############################################

public_subnet_cidrs = [
  "10.0.1.0/24",
  "10.0.2.0/24"
]

#############################################
# Private Application Subnets
#############################################

private_app_subnet_cidrs = [
  "10.0.11.0/24",
  "10.0.12.0/24"
]

#############################################
# Private Database Subnets
#############################################

private_db_subnet_cidrs = [
  "10.0.21.0/24",
  "10.0.22.0/24"
]
```

Keeping configuration in `terraform.tfvars` allows the same Terraform code to be reused across multiple environments.

---

# Step 4 – Update Root `main.tf`

Pass the new variables into the VPC Module.

```hcl
module "vpc" {

  source = "./modules/vpc"

  project_name = var.project_name

  environment = var.environment

  vpc_cidr = var.vpc_cidr

  common_tags = local.common_tags

  availability_zones = var.availability_zones

  public_subnet_cidrs = var.public_subnet_cidrs

  private_app_subnet_cidrs = var.private_app_subnet_cidrs

  private_db_subnet_cidrs = var.private_db_subnet_cidrs

}
```

The Root Module continues acting as the orchestrator.

The Child Module receives everything it needs through variables.

---

# Validation

Run the following commands from the `terraform/` directory.

```bash
terraform fmt -recursive

terraform validate

terraform plan
```

Since the subnet resources have not been created yet, the execution plan should still show only the VPC resource.

Validation should complete successfully.

---

# Best Practices

- Separate Public, Application, and Database networks.
- Never hardcode subnet CIDRs inside modules.
- Pass configuration through variables.
- Use list variables for multiple subnet values.
- Keep the Root Module responsible for configuration.
- Keep Child Modules reusable.
- Plan the network before writing Terraform resources.

---

# Phase Summary

After completing **Phase 3.3 – Subnet Design**, you will have:

- Designed a production-ready subnet architecture.
- Planned six subnets across two Availability Zones.
- Understood why production environments separate network tiers.
- Updated the VPC module to accept subnet configuration.
- Added reusable list variables.
- Configured subnet CIDRs using `terraform.tfvars`.
- Connected the subnet configuration to the Root Module.

In the next step, these subnet definitions will be used to create the actual **AWS Subnet resources** using Terraform.

---

# 🚀 Phase 3.4 – Create `subnets.tf`

**Duration:** 2–4 Hours

---

# 🎯 Goal

Create all **six AWS subnets** for the production VPC.

This step provisions:

- ✅ 2 Public Subnets
- ✅ 2 Private Application Subnets
- ✅ 2 Private Database Subnets

These subnets will be distributed across **two Availability Zones** to support a highly available architecture.

> **Note**
>
> In this step, we create only the subnets.
>
> Internet Gateway, NAT Gateway, Route Tables, and Route Associations will be implemented in later steps.

---

# 📖 Learning Objectives

By the end of this step, you will understand:

- AWS Subnets
- Public vs Private Subnets
- Multi-AZ networking
- Terraform `count`
- Terraform list indexing
- Dynamic subnet creation
- Terraform outputs
- Enterprise module organization

---

# Before We Write Code

Our current VPC module looks like this:

```text
modules/
└── vpc/
    ├── main.tf
    ├── variables.tf
    └── outputs.tf
```

As the project grows, placing every resource inside a single `main.tf` file becomes difficult to maintain.

---

# Enterprise Module Structure

A better organization is:

```text
modules/
└── vpc/
    ├── vpc.tf
    ├── subnets.tf
    ├── internet-gateway.tf
    ├── route-tables.tf
    ├── routes.tf
    ├── variables.tf
    ├── outputs.tf
    └── README.md
```

Each file has one responsibility.

Benefits:

- Easier navigation
- Cleaner code
- Better collaboration
- Simpler troubleshooting
- Scalable module design

---

# Step 1 – Refactor the Module

Rename:

```text
modules/vpc/main.tf
```

to:

```text
modules/vpc/vpc.tf
```

The contents remain exactly the same.

Terraform automatically loads every `.tf` file within the directory, so this change has no impact on functionality.

---

# Step 2 – Create `subnets.tf`

Create:

```text
terraform/modules/vpc/subnets.tf
```

This file will contain all subnet resources.

---

# Step 3 – Create Public Subnets

Add:

```hcl
#############################################
# Public Subnets
#############################################

resource "aws_subnet" "public" {

  count = length(var.public_subnet_cidrs)

  vpc_id = aws_vpc.main.id

  cidr_block = var.public_subnet_cidrs[count.index]

  availability_zone = var.availability_zones[count.index]

  map_public_ip_on_launch = true

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-public-subnet-${count.index + 1}"
      Type = "Public"
    }
  )
}
```

---

# Understanding the Configuration

## Why `count`?

Instead of creating two separate resources:

```hcl
resource "aws_subnet" "public_a" {}

resource "aws_subnet" "public_b" {}
```

we use a single resource block.

Terraform automatically creates multiple resources.

Example:

```text
count = 2
```

Results in:

```text
aws_subnet.public[0]

aws_subnet.public[1]
```

This approach is cleaner and easier to maintain.

---

## `map_public_ip_on_launch`

```hcl
map_public_ip_on_launch = true
```

Every EC2 instance launched inside a Public Subnet automatically receives a public IP address.

This is required for internet-facing resources.

---

# Step 4 – Create Private Application Subnets

Add:

```hcl
#############################################
# Private Application Subnets
#############################################

resource "aws_subnet" "private_app" {

  count = length(var.private_app_subnet_cidrs)

  vpc_id = aws_vpc.main.id

  cidr_block = var.private_app_subnet_cidrs[count.index]

  availability_zone = var.availability_zones[count.index]

  map_public_ip_on_launch = false

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-private-app-subnet-${count.index + 1}"
      Type = "Private-App"
    }
  )
}
```

---

# Why Disable Public IPs?

```hcl
map_public_ip_on_launch = false
```

Application servers should never be directly accessible from the Internet.

Traffic should always follow:

```text
Internet

↓

Application Load Balancer

↓

EC2
```

This improves security and follows AWS best practices.

---

# Step 5 – Create Private Database Subnets

Add:

```hcl
#############################################
# Private Database Subnets
#############################################

resource "aws_subnet" "private_db" {

  count = length(var.private_db_subnet_cidrs)

  vpc_id = aws_vpc.main.id

  cidr_block = var.private_db_subnet_cidrs[count.index]

  availability_zone = var.availability_zones[count.index]

  map_public_ip_on_launch = false

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-private-db-subnet-${count.index + 1}"
      Type = "Private-DB"
    }
  )
}
```

---

# Database Network Design

Database Subnets are private.

Traffic flow:

```text
Internet

↓

Application Load Balancer

↓

EC2

↓

Amazon RDS
```

Databases should never receive direct internet traffic.

---

# Resources Created

Terraform will now create:

```text
aws_vpc.main

aws_subnet.public[0]

aws_subnet.public[1]

aws_subnet.private_app[0]

aws_subnet.private_app[1]

aws_subnet.private_db[0]

aws_subnet.private_db[1]
```

Total resources:

- **1 Amazon VPC**
- **6 Amazon Subnets**

---

# Step 6 – Update Module Outputs

Open:

```text
terraform/modules/vpc/outputs.tf
```

Add:

```hcl
#############################################
# Public Subnets
#############################################

output "public_subnet_ids" {
  description = "IDs of public subnets."
  value       = aws_subnet.public[*].id
}

#############################################
# Private Application Subnets
#############################################

output "private_app_subnet_ids" {
  description = "IDs of private application subnets."
  value       = aws_subnet.private_app[*].id
}

#############################################
# Private Database Subnets
#############################################

output "private_db_subnet_ids" {
  description = "IDs of private database subnets."
  value       = aws_subnet.private_db[*].id
}
```

These outputs expose subnet IDs to the Root Module.

---

# Step 7 – Update Root Outputs

Open:

```text
terraform/outputs.tf
```

Add:

```hcl
output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_app_subnet_ids" {
  value = module.vpc.private_app_subnet_ids
}

output "private_db_subnet_ids" {
  value = module.vpc.private_db_subnet_ids
}
```

Now other modules can easily consume subnet IDs.

Examples:

- ALB Module
- EC2 Module
- RDS Module

---

# Validation

Run the following commands:

```bash
terraform fmt -recursive

terraform init

terraform validate

terraform plan
```

---

# Expected Plan

Terraform should report approximately:

```text
Plan: 7 to add, 0 to change, 0 to destroy.
```

Resources created:

```text
1 Amazon VPC

2 Public Subnets

2 Private Application Subnets

2 Private Database Subnets
```

No Internet Gateway, NAT Gateway, Route Tables, or Security Groups are created in this step.

---

# Best Practices

- Organize Terraform modules into multiple files by responsibility.
- Use `count` to create similar resources efficiently.
- Avoid hardcoding subnet CIDRs.
- Use variables for reusable configurations.
- Keep application and database resources in private subnets.
- Expose reusable resource IDs through outputs.
- Validate the configuration after every change.

---

# Phase Summary

After completing **Phase 3.4 – Create `subnets.tf`**, you will have:

- Created six production-ready subnets.
- Distributed subnets across two Availability Zones.
- Used Terraform `count` to dynamically create resources.
- Applied consistent enterprise tagging.
- Refactored the VPC module into a cleaner structure.
- Exposed subnet IDs through module outputs.
- Prepared the networking layer for Internet Gateway, Route Tables, and NAT Gateway configuration in the next phases.

The network foundation is now in place, making it ready for configuring internet connectivity and routing.
---

# 🚀 Phase 3.5 – Internet Gateway

**Duration:** 1–2 Hours

---

# 🎯 Goal

Create an **Amazon Internet Gateway (IGW)** and attach it to the VPC.

By the end of this step, your Terraform module will provision:

- ✅ Internet Gateway
- ✅ Internet Gateway attached to the VPC
- ✅ Enterprise resource tags
- ✅ Module outputs

> **Important**
>
> Creating an Internet Gateway **does not automatically provide Internet access**.
>
> Route Tables and Routes are still required and will be created in the next phase.

---

# 📖 Theory

## What is an Internet Gateway?

An **Internet Gateway (IGW)** is a horizontally scaled, highly available AWS component that enables communication between resources inside a VPC and the public Internet.

Think of it as the **entry and exit point** for Internet traffic.

```text
Internet
     │
     ▼
Internet Gateway
     │
     ▼
Amazon VPC
```

Without an Internet Gateway:

- EC2 instances cannot communicate with the Internet.
- Application Load Balancers cannot receive Internet traffic.
- Public Subnets cannot function as public networks.

---

# Why Do We Need an Internet Gateway?

Imagine deploying:

- Application Load Balancer
- EC2 Instances
- Amazon RDS

Without an Internet Gateway:

```text
Internet

✖

Cannot reach the VPC
```

AWS has no path between your VPC and the Internet.

The Internet Gateway provides that connection.

---

# Public vs Private Subnets

A common misconception is:

```text
Public Subnet

=

Internet Access
```

This is **incorrect**.

A subnet becomes **public** only when **both** of the following conditions are met:

- A Route Table contains a route to an Internet Gateway (`0.0.0.0/0 → IGW`).
- Resources have public IP addresses (where applicable).

Without these conditions, it is simply another subnet.

---

# Current Network

After the previous phase, the network looks like this:

```text
VPC

├── Public Subnet A

├── Public Subnet B

├── Private App Subnet A

├── Private App Subnet B

├── Private DB Subnet A

└── Private DB Subnet B
```

No Internet connectivity exists yet.

---

# Network After This Step

```text
Internet
     │
     ▼
Internet Gateway
     │
     ▼
VPC
     │
     ▼
Subnets
```

The VPC is now connected to the Internet Gateway, but routing is still missing.

---

# Step 1 – Create `internet-gateway.tf`

Inside the VPC module, create:

```text
terraform/modules/vpc/internet-gateway.tf
```

Keeping networking resources in dedicated files follows enterprise Terraform practices.

---

# Step 2 – Add the Internet Gateway Resource

Add the following code.

```hcl
#############################################
# Internet Gateway
#############################################

resource "aws_internet_gateway" "main" {

  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-igw"
    }
  )
}
```

---

# Understanding Every Line

## Attach to the VPC

```hcl
vpc_id = aws_vpc.main.id
```

This attaches the Internet Gateway to the VPC created earlier.

A VPC can have only **one attached Internet Gateway** at a time.

Terraform automatically establishes the dependency because the Internet Gateway references the VPC ID.

---

## Enterprise Tags

```hcl
tags = merge(
  var.common_tags,
  {
    Name = "${var.project_name}-${var.environment}-igw"
  }
)
```

The `merge()` function combines:

Shared tags:

- Project
- Environment
- ManagedBy
- Owner
- Repository

with a resource-specific Name tag.

Example:

```text
linkedin-dev-igw
```

or

```text
linkedin-clone-dev-igw
```

depending on your project name.

---

# Step 3 – Add Module Output

Open:

```text
terraform/modules/vpc/outputs.tf
```

Add:

```hcl
#############################################
# Internet Gateway
#############################################

output "internet_gateway_id" {
  description = "ID of the Internet Gateway."
  value       = aws_internet_gateway.main.id
}
```

This output allows other modules or the Root Module to reference the Internet Gateway.

---

# Step 4 – Expose the Output in the Root Module

Open:

```text
terraform/outputs.tf
```

Add:

```hcl
output "internet_gateway_id" {
  description = "Internet Gateway ID."
  value       = module.vpc.internet_gateway_id
}
```

Now the Internet Gateway ID is available from the Root Module.

---

# Validation

Run the following commands:

```bash
terraform fmt -recursive

terraform validate

terraform plan
```

---

# Expected Plan

Terraform should report approximately:

```text
Plan: 8 to add, 0 to change, 0 to destroy.
```

Resources include:

- 1 Amazon VPC
- 6 Amazon Subnets
- 1 Internet Gateway

---

# Why Doesn't the Internet Work Yet?

Although the Internet Gateway has been created and attached to the VPC, Internet connectivity is still unavailable.

Why?

Because AWS still does not know **where Internet-bound traffic should go**.

A Route Table is required.

The Route Table must contain:

```text
Destination:

0.0.0.0/0

↓

Target:

Internet Gateway
```

Without this route:

```text
Internet

↓

Internet Gateway

↓

VPC

✖

Traffic Stops
```

No packets are forwarded to the Internet.

This is one of the most common AWS networking interview questions.

---

# AWS Networking Flow

Current architecture:

```text
Internet
     │
     ▼
Internet Gateway
     │
     ▼
VPC
     │
     ▼
Subnets
```

Still missing:

- Route Tables
- Routes
- Route Table Associations

These components will complete Internet connectivity in the next phase.

---

# Best Practices

- Attach only one Internet Gateway to a VPC.
- Separate Internet Gateway configuration into its own Terraform file.
- Use enterprise tagging for all networking resources.
- Expose reusable IDs using Terraform outputs.
- Keep networking components modular and easy to maintain.
- Understand that Internet connectivity requires both an Internet Gateway and proper routing.

---

# Phase Summary

After completing **Phase 3.5 – Internet Gateway**, you will have:

- Created an Amazon Internet Gateway.
- Attached the Internet Gateway to the VPC.
- Applied enterprise tagging standards.
- Exposed the Internet Gateway ID through module outputs.
- Understood the role of the Internet Gateway in AWS networking.
- Learned why an Internet Gateway alone does not provide Internet access.

The next phase will create **Route Tables and Routes**, allowing Public Subnets to communicate with the Internet.
---

# 🚀 Phase 3.6 – Route Tables & Route Associations

**Duration:** 2–4 Hours

---

# 🎯 Goal

Build the **routing layer** of the VPC by creating Route Tables, Routes, and Route Table Associations.

By the end of this step, the network will support Internet access for Public Subnets while preparing the Private Subnets for future NAT Gateway integration.

---

# 📚 Learning Objectives

By the end of this step, you'll understand:

- What is a Route Table?
- How AWS routing works
- Public vs Private routing
- Route Table Associations
- Internet routes
- Default routes
- Why Private Subnets do not have Internet routes
- Enterprise networking best practices

---

# Final Network After This Step

```text
                     Internet
                         │
                  Internet Gateway
                         │
                 Public Route Table
                         │
        ┌────────────────┴────────────────┐
        │                                 │
 Public Subnet A                  Public Subnet B

Private Route Tables

├── Private App Route Table
│       │
│       ├── Private App Subnet A
│       └── Private App Subnet B
│
└── Private DB Route Table
        │
        ├── Private DB Subnet A
        └── Private DB Subnet B
```

Private Route Tables are created now but **will not have Internet access** until a NAT Gateway is added in the next phase.

---

# 📖 Theory

## What is a Route Table?

A **Route Table** tells AWS where network traffic should go.

Think of it as **Google Maps for your network**.

Every packet checks the Route Table before leaving its subnet.

Example:

| Destination | Target |
|-------------|--------|
| `10.0.0.0/16` | Local VPC |
| `0.0.0.0/0` | Internet Gateway |

Without a Route Table, packets have no routing instructions.

---

# How Routing Works

Imagine an EC2 instance wants to reach the Internet.

AWS checks:

```text
EC2

↓

Subnet

↓

Route Table

↓

Internet Gateway

↓

Internet
```

If no matching route exists, traffic is dropped.

---

# Enterprise Route Table Design

We'll create **three Route Tables**.

```text
Public Route Table

↓

Public Subnets
```

```text
Private App Route Table

↓

Private App Subnets
```

```text
Private Database Route Table

↓

Private Database Subnets
```

Each Route Table serves a different purpose.

---

# Why Three Route Tables?

Different application layers have different networking requirements.

| Layer | Internet Access |
|--------|-----------------|
| Public | Yes |
| Application | Outbound only (via NAT Gateway later) |
| Database | No Internet access |

Keeping separate Route Tables provides:

- Better security
- Better control
- Easier troubleshooting
- Enterprise architecture

---

# Module File Structure

Create the following files inside the VPC module:

```text
terraform/
└── modules/
    └── vpc/
        ├── vpc.tf
        ├── subnets.tf
        ├── internet-gateway.tf
        ├── route-tables.tf
        ├── routes.tf
        ├── variables.tf
        ├── outputs.tf
        └── README.md
```

Each file has a single responsibility.

---

# Step 1 – Create `route-tables.tf`

Create:

```text
terraform/modules/vpc/route-tables.tf
```

---

# Step 2 – Create the Public Route Table

Add:

```hcl
#############################################
# Public Route Table
#############################################

resource "aws_route_table" "public" {

  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-public-rt"
    }
  )
}
```

This Route Table will later contain the route to the Internet Gateway.

---

# Step 3 – Create the Private Application Route Table

Add:

```hcl
#############################################
# Private Application Route Table
#############################################

resource "aws_route_table" "private_app" {

  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-private-app-rt"
    }
  )
}
```

This Route Table will later send outbound traffic through a NAT Gateway.

---

# Step 4 – Create the Private Database Route Table

Add:

```hcl
#############################################
# Private Database Route Table
#############################################

resource "aws_route_table" "private_db" {

  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-private-db-rt"
    }
  )
}
```

The Database Route Table intentionally has **no Internet route**.

This keeps the database isolated.

---

# Step 5 – Create `routes.tf`

Create:

```text
terraform/modules/vpc/routes.tf
```

---

# Step 6 – Add the Public Internet Route

Add:

```hcl
#############################################
# Public Internet Route
#############################################

resource "aws_route" "public_internet_access" {

  route_table_id = aws_route_table.public.id

  destination_cidr_block = "0.0.0.0/0"

  gateway_id = aws_internet_gateway.main.id
}
```

---

# Understanding the Default Route

```text
0.0.0.0/0
```

means:

**Any IPv4 destination**

Whenever traffic is not destined for the local VPC, AWS forwards it to the Internet Gateway.

Example:

```text
EC2

↓

Public Route Table

↓

0.0.0.0/0

↓

Internet Gateway

↓

Internet
```

---

# Step 7 – Associate the Public Route Table

Still inside `routes.tf`, add:

```hcl
#############################################
# Public Route Table Associations
#############################################

resource "aws_route_table_association" "public" {

  count = length(aws_subnet.public)

  subnet_id = aws_subnet.public[count.index].id

  route_table_id = aws_route_table.public.id
}
```

Terraform automatically associates both Public Subnets with the Public Route Table.

---

# Step 8 – Associate the Private Application Route Table

Add:

```hcl
#############################################
# Private App Associations
#############################################

resource "aws_route_table_association" "private_app" {

  count = length(aws_subnet.private_app)

  subnet_id = aws_subnet.private_app[count.index].id

  route_table_id = aws_route_table.private_app.id
}
```

These subnets remain private because no Internet route exists yet.

---

# Step 9 – Associate the Private Database Route Table

Add:

```hcl
#############################################
# Private DB Associations
#############################################

resource "aws_route_table_association" "private_db" {

  count = length(aws_subnet.private_db)

  subnet_id = aws_subnet.private_db[count.index].id

  route_table_id = aws_route_table.private_db.id
}
```

Database subnets are now associated with their dedicated Route Table.

---

# Network Flow

After this step, Internet traffic flows like this:

```text
Internet

↓

Internet Gateway

↓

Public Route Table

↓

Public Subnets
```

Private Route Tables exist but **do not yet contain Internet routes**.

This is intentional.

The NAT Gateway will be introduced later.

---

# Resources Created

At this stage, Terraform provisions:

- 1 Amazon VPC
- 6 Amazon Subnets
- 1 Internet Gateway
- 3 Route Tables
- 1 Internet Route
- 6 Route Table Associations

---

# Validation

Run the following commands:

```bash
terraform fmt -recursive

terraform validate

terraform plan
```

Review the execution plan carefully.

Verify that:

- Route Tables are created.
- Route Table Associations are created.
- The Public Route Table contains the default route (`0.0.0.0/0`).
- Private Route Tables do **not** contain Internet routes.

---

# Best Practices

- Use separate Route Tables for Public, Application, and Database tiers.
- Associate every subnet with the appropriate Route Table.
- Avoid Internet routes in Private Route Tables.
- Keep routing resources in dedicated Terraform files.
- Apply consistent enterprise tags to Route Tables.
- Use `count` for repeated Route Table Associations.
- Always validate the routing design before deployment.

---

# Phase Summary

After completing **Phase 3.6 – Route Tables & Route Associations**, you will have:

- Created three Route Tables.
- Created the default Internet route for Public Subnets.
- Associated all six subnets with the correct Route Tables.
- Built the routing layer for the VPC.
- Prepared Private Route Tables for future NAT Gateway integration.
- Completed another major component of a production-ready AWS network architecture.

In the next phase, you will add a **NAT Gateway** to provide secure outbound Internet access for Private Application Subnets while keeping them inaccessible from the public Internet.
---
