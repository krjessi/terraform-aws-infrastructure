# Phase 1 – Planning & Project Setup

**Duration:** 2–3 Hours

## 🎯 Goal

Prepare everything required before writing any Terraform code.

---

# ✅ Deliverables

By the end of this phase, you will have:

- GitHub repository created
- Professional project folder structure
- AWS account ready
- Terraform installed
- AWS CLI configured
- VS Code configured
- Git initialized
- Initial README created
- First Git commit pushed

---

# Step 1: Prerequisites

Ensure the following software is installed on your system.

## Required Software

Verify the installations by running:

```bash
terraform version
aws --version
git --version
docker --version
java --version
```

### Expected Output

| Tool | Status |
|------|--------|
| Git | ✅ |
| Terraform | ✅ |
| AWS CLI | ✅ |
| Docker | ✅ |
| Java | ✅ |

---

# Step 2: Create GitHub Repository

## Repository Name

```text
terraform-aws-infrastructure
```

## Description

```text
Enterprise-grade AWS Infrastructure Automation using Terraform with modular architecture, ALB, Auto Scaling, EC2, RDS, CloudWatch, and remote state management.
```

## Repository Type

- Public

## Do NOT Initialize With

- ❌ README
- ❌ .gitignore
- ❌ License

> We'll create these ourselves.

---

# Step 3: Clone Repository

```bash
git clone https://github.com/<your-username>/terraform-aws-infrastructure.git

cd terraform-aws-infrastructure
```

---

# Step 4: Create Project Folder Structure

Create the following structure exactly as shown.

```text
terraform-aws-infrastructure/
│
├── README.md
├── LICENSE
├── .gitignore
│
├── architecture/
│
├── docs/
│
├── images/
│
└── terraform/
    │
    ├── backend.tf
    ├── provider.tf
    ├── versions.tf
    ├── variables.tf
    ├── outputs.tf
    ├── locals.tf
    ├── data.tf
    ├── main.tf
    │
    ├── modules/
    │
    └── environments/
        │
        ├── dev/
        ├── stage/
        └── prod/
```

---

# Step 5: Install VS Code Extensions

Install the following extensions.

| Extension | Purpose |
|-----------|----------|
| HashiCorp Terraform | Terraform syntax support |
| AWS Toolkit | AWS integration |
| Docker | Container support |
| GitLens | Git history and insights |
| Error Lens | Better error highlighting |
| YAML | YAML support |
| Markdown All in One | Markdown productivity |
| Prettier | Code formatting |

---

# Step 6: Configure AWS CLI

Run:

```bash
aws configure
```

Provide the following information:

```text
AWS Access Key ID
AWS Secret Access Key
Default Region: ap-south-1
Default Output Format: json
```

## Verify Configuration

```bash
aws sts get-caller-identity
```

### Expected Output

```json
{
  "UserId": "...",
  "Account": "123456789012",
  "Arn": "arn:aws:iam::123456789012:user/your-user"
}
```

---

# Step 7: Verify Terraform Installation

Run:

```bash
terraform version
```

---

# Step 8: Configure Git

Set your Git identity.

```bash
git config --global user.name "Mukesh Kumar"

git config --global user.email "your-email@example.com"
```

Verify the configuration.

```bash
git config --list
```

---

# Step 9: Create `.gitignore`

Create a `.gitignore` file with the following contents.

```gitignore
# Terraform
.terraform/
*.tfstate
*.tfstate.*
crash.log
terraform.tfvars
*.tfvars
override.tf
override.tf.json
*_override.tf
*_override.tf.json
.terraform.lock.hcl

# Environment files
.env

# IDE
.vscode/
.idea/

# macOS
.DS_Store

# Logs
*.log
```

> **Note:** In production, many teams commit `.terraform.lock.hcl` to ensure consistent provider versions across environments. We'll revisit this in **Phase 2**.

---

# Step 10: Create LICENSE

Use the **MIT License**.

---

# Step 11: Create Initial README

Create a simple `README.md`.

---

# Step 12: Create Documentation Files

To keep the project organized and maintain proper documentation, create the following Markdown files inside the `docs/` directory.

## Folder Structure

```text
docs/
│
├── setup.md
├── terraform-concepts.md
├── architecture.md
├── deployment.md
├── troubleshooting.md
└── interview-notes.md
```

## Purpose of Each File

| File | Purpose |
|------|---------|
| `setup.md` | Documents project setup instructions, prerequisites, software installation, and environment configuration. |
| `terraform-concepts.md` | Contains Terraform fundamentals, syntax, workflow, providers, modules, state management, and important concepts. |
| `architecture.md` | Describes the AWS infrastructure architecture, networking components, security design, and deployment diagrams. |
| `deployment.md` | Records deployment procedures, Terraform commands, execution workflow, validation steps, and rollback procedures. |
| `troubleshooting.md` | Maintains solutions for common Terraform, AWS, and infrastructure issues encountered during the project. |
| `interview-notes.md` | Stores Terraform interview questions, AWS interview notes, important concepts, and practical scenarios. |

> **Note**
>
> Leave these files empty for now. We will gradually document each topic as we progress through the project.

---

# Step 13: Create Architecture Folder

Create an `architecture/` directory to store all architecture-related documentation and diagrams.

## Folder Structure

```text
architecture/
│
└── README.md
```

## Purpose

This folder will contain:

- AWS Architecture Diagrams
- Terraform Workflow Diagrams
- Infrastructure Design Documents
- Network Topology
- VPC Design
- Security Architecture
- Deployment Flow Diagrams
- High-Level Design (HLD)
- Low-Level Design (LLD)

### README.md

The `README.md` file will serve as an index for all architecture diagrams and design documents created during the project.

> **Note**
>
> AWS architecture diagrams and Terraform workflow diagrams will be added in later phases.

---

# Step 14: First Git Commit

Once the initial project structure has been created, save your work to Git by making the first commit.

## Stage All Files

Add all newly created files to the Git staging area.

```bash
git add .
```

## Commit Changes

Create your first commit with a meaningful commit message.

```bash
git commit -m "Initial project structure for enterprise Terraform AWS infrastructure"
```

## Push to GitHub

Push the commit to the remote GitHub repository.

```bash
git push origin main
```

## Verify

After pushing the code:

- Open your GitHub repository.
- Confirm that all folders and files have been uploaded successfully.
- Verify that the latest commit appears in the commit history.

## Expected Repository Structure

```text
terraform-aws-infrastructure/
│
├── architecture/
│   └── README.md
│
├── docs/
│   ├── architecture.md
│   ├── deployment.md
│   ├── interview-notes.md
│   ├── setup.md
│   ├── terraform-concepts.md
│   └── troubleshooting.md
│
├── images/
│
├── terraform/
│
├── .gitignore
├── LICENSE
└── README.md
```

> **Best Practice**
>
> Use clear and descriptive commit messages that explain the purpose of your changes. Small, frequent commits make it easier to track project history and collaborate with others.

---

## ✅ Phase 1 Completion Checklist

Before moving to the next phase, ensure the following tasks are complete:

- [x] GitHub repository created
- [x] Repository cloned locally
- [x] Professional folder structure created
- [x] AWS CLI configured
- [x] Terraform installation verified
- [x] Git configured
- [x] VS Code extensions installed
- [x] `.gitignore` created
- [x] MIT License added
- [x] Initial `README.md` created
- [x] Documentation files created
- [x] Architecture folder created
- [x] First Git commit completed
- [x] Changes pushed to GitHub

---

## 🎉 Congratulations!

You have successfully completed **Phase 1 – Planning & Project Setup**.

Your project is now ready for **Phase 2**, where you will begin configuring Terraform, providers, backend settings, variables, and initialize your first Infrastructure as Code (IaC) project.

````markdown
# Terraform AWS Infrastructure Automation

Enterprise-grade Infrastructure as Code (IaC) project using Terraform to provision production-ready AWS infrastructure.

## Planned Infrastructure

- VPC
- Public and Private Subnets
- Internet Gateway
- NAT Gateway
- Route Tables
- Security Groups
- IAM Roles
- EC2
- Application Load Balancer
- Auto Scaling Group
- PostgreSQL RDS
- CloudWatch
- S3 Remote Backend
- DynamoDB State Lock

## Application

LinkedIn Clone (Spring Boot)

## Status

🚧 Phase 1 - Planning