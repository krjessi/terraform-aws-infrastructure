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