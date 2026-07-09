# Phase 2 – Terraform Fundamentals

**Duration:** 3–4 Hours

---

# 🎯 Goal

Build the foundation of our Terraform project by creating the core configuration files and understanding how Terraform works.

> **Important**
>
> In this phase, we **will not create any AWS resources**.
>
> Our focus is to establish a clean, reusable, and enterprise-grade project structure that all future Terraform modules will follow.

A well-structured foundation makes the infrastructure easier to maintain, scale, and troubleshoot.

---

# 📚 Learning Objectives

During this phase, you will learn:

- Terraform project structure
- Terraform workflow
- Version constraints
- AWS provider configuration
- Input variables
- Local values
- Data sources
- Output values
- Common tagging strategy
- Validation techniques
- Terraform formatting and validation
- Enterprise best practices

---

# ✅ Phase 2 Deliverables

By the end of this phase, you will have:

- ✅ Terraform root configuration
- ✅ AWS provider configuration
- ✅ Version constraints
- ✅ Input variables
- ✅ Local values
- ✅ Output values
- ✅ Data sources
- ✅ Common tags
- ✅ Variable validation
- ✅ Project documentation
- ✅ Git commit
- ✅ Interview preparation notes
- ✅ Troubleshooting documentation

---

# Why This Phase Matters

Before provisioning infrastructure, every enterprise Terraform project requires a solid foundation.

Rather than placing everything into a single file, Terraform projects are organized into multiple files, each with a specific responsibility.

This approach provides:

- Better readability
- Easier maintenance
- Team collaboration
- Reusability
- Consistent coding standards
- Easier debugging
- Scalable infrastructure design

---

# Terraform Project Structure

Inside the `terraform/` directory, we'll gradually build the following files:

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
│
├── modules/
│
└── environments/
    ├── dev/
    ├── stage/
    └── prod/
```

---

# Understanding Each Terraform File

Before writing any code, let's understand the purpose of each file.

| File | Purpose |
|------|----------|
| `versions.tf` | Defines Terraform and provider version constraints to ensure consistent deployments. |
| `provider.tf` | Configures the AWS provider and specifies the target AWS region. |
| `variables.tf` | Declares reusable input variables used throughout the project. |
| `locals.tf` | Stores reusable computed values, naming conventions, and common tags. |
| `data.tf` | Retrieves information about existing AWS resources without creating new ones. |
| `outputs.tf` | Displays useful values after Terraform operations complete. |
| `main.tf` | Acts as the primary entry point that will later connect all Terraform modules. |

---

# Enterprise Terraform Workflow

Every Terraform project follows the same workflow.

```text
Write Terraform Code
        │
        ▼
terraform fmt
        │
        ▼
terraform validate
        │
        ▼
terraform init
        │
        ▼
terraform plan
        │
        ▼
terraform apply
        │
        ▼
terraform output
        │
        ▼
terraform destroy
```

---

# Terraform Command Overview

## 1. terraform fmt

Formats Terraform files according to Terraform's standard style.

**Purpose**

- Keeps code clean
- Improves readability
- Ensures consistent formatting

---

## 2. terraform validate

Checks whether the Terraform configuration is syntactically correct.

**Purpose**

- Detects syntax errors
- Verifies configuration integrity
- Does not contact AWS

---

## 3. terraform init

Initializes the Terraform working directory.

This command:

- Downloads required providers
- Initializes backend configuration
- Creates the `.terraform/` directory
- Prepares the project for deployment

---

## 4. terraform plan

Generates an execution plan.

Terraform compares:

- Current infrastructure
- Desired configuration

Then displays what changes will occur.

---

## 5. terraform apply

Creates or updates infrastructure based on the execution plan.

---

## 6. terraform output

Displays output values defined in `outputs.tf`.

Examples include:

- VPC ID
- Public IP
- Load Balancer DNS
- Database Endpoint

---

## 7. terraform destroy

Deletes all resources managed by Terraform.

Use this command carefully.

---

# Enterprise Best Practices

During this project, we will follow industry-standard practices, including:

- Separate configuration files by responsibility
- Use reusable variables
- Store common values in locals
- Apply consistent resource tagging
- Validate input variables
- Follow version constraints
- Keep code modular
- Document every phase
- Commit code frequently
- Write meaningful Git commit messages

---

# Phase 2 Roadmap

We will build the Terraform foundation one file at a time.

```text
Step 1
versions.tf

        │
        ▼

Step 2
provider.tf

        │
        ▼

Step 3
variables.tf

        │
        ▼

Step 4
locals.tf

        │
        ▼

Step 5
data.tf

        │
        ▼

Step 6
outputs.tf

        │
        ▼

Step 7
main.tf
```

Each step builds upon the previous one, creating a clean and maintainable Terraform project.

---

# What We'll Accomplish

By the end of Phase 2, our project will include:

- Terraform version management
- AWS provider configuration
- Reusable variables
- Local values
- Data source configuration
- Output definitions
- Base project structure
- Common tagging strategy
- Validation rules
- Documentation updates
- Git history
- Interview notes
- Troubleshooting guide

Although no AWS infrastructure will be deployed in this phase, we will have a production-ready Terraform foundation that supports all future modules.

---

# Expected Project Structure After Phase 2

```text
terraform/
│
├── backend.tf
├── provider.tf
├── versions.tf
├── variables.tf
├── locals.tf
├── data.tf
├── outputs.tf
├── main.tf
│
├── modules/
│
└── environments/
    ├── dev/
    ├── stage/
    └── prod/
```

---

# 📌 Next Steps

In the next section, we will begin with **Step 1 – Creating `versions.tf`**, where we will define:

- Terraform version constraints
- AWS provider version constraints
- Best practices for version management
- Compatibility considerations
- Why version locking is important in enterprise environments

---

# 🎯 Phase 2 Success Criteria

Before moving to the next phase, ensure that you:

- Understand the purpose of each Terraform file.
- Understand the Terraform workflow.
- Know when to use each Terraform command.
- Have the project structure ready.
- Are prepared to begin writing Terraform configuration files.

Once these objectives are complete, you'll be ready to configure the project and start provisioning AWS infrastructure in the upcoming phases.