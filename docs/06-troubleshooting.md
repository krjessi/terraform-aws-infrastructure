# Troubleshooting

This section documents common issues encountered during the project setup along with their resolutions.

| Issue                                                       | Resolution                                                                                                                                                                                                              |
| ----------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **`terraform: command not found`**                          | Restarted Visual Studio Code (or opened a new terminal) so the updated `PATH` environment variable was reloaded. Verified the installation by running `terraform version`.                                              |
| **Winget installer hash mismatch for Microsoft OpenJDK 21** | Installed an alternative JDK distribution (such as Eclipse Temurin or Amazon Corretto) or downloaded the official installer directly from the vendor's website. Verified the installation using `java --version`.       |
| **AWS CLI configuration**                                   | Verified the AWS CLI configuration by running `aws sts get-caller-identity`. A successful response confirmed that the configured IAM credentials were valid and the CLI was authenticated with the correct AWS account. |

## Verification Commands

```bash
terraform version

java --version

aws sts get-caller-identity
```

## Best Practices

* Restart your terminal or IDE after installing Terraform or Java to ensure the updated `PATH` is loaded.
* Always verify installations immediately after setup.
* Use an IAM user with programmatic access instead of the AWS root account.
* Confirm your AWS identity before running any Terraform commands that interact with AWS resources.

---

# Troubleshooting

This document records common issues encountered during the project along with their causes and resolutions.

---

# Issue: Terraform Initialized in an Empty Directory

## Problem

When running Terraform commands, you may see a message similar to:

```text
Terraform initialized in an empty directory!

The directory has no Terraform configuration files.
```

---

## Cause

Terraform was executed from the **repository root directory** instead of the **`terraform/`** directory where the `.tf` configuration files are located.

Example:

```text
terraform-aws-infrastructure/
│
├── README.md
├── docs/
├── architecture/
└── terraform/
    ├── versions.tf
    ├── provider.tf
    └── ...
```

Running the following from the repository root:

```bash
terraform init
```

causes Terraform to search for `.tf` files in the wrong location.

Since none exist there, Terraform initializes an empty working directory.

---

## Solution

Navigate to the `terraform/` directory before running any Terraform commands.

```bash
cd terraform
```

Then execute:

```bash
terraform init

terraform validate

terraform plan
```

---

## Verification

Verify that you are inside the correct directory.

```bash
pwd
```

Example output (Linux/macOS):

```text
.../terraform-aws-infrastructure/terraform
```

Or on Windows Git Bash:

```text
/c/Users/username/terraform-aws-infrastructure/terraform
```

List the files to confirm the Terraform configuration is present.

```bash
ls
```

Expected output:

```text
backend.tf
provider.tf
versions.tf
variables.tf
locals.tf
data.tf
outputs.tf
main.tf
```

---

# Troubleshooting Summary

| Issue | Cause | Solution |
|------|-------|----------|
| Terraform initialized in an empty directory | Terraform commands were executed from the repository root instead of the `terraform/` directory. | Change to the `terraform/` directory using `cd terraform` before running Terraform commands. |

---

# Best Practices

- Always verify your current working directory before running Terraform commands.
- Keep all Terraform configuration files inside the `terraform/` directory.
- Run `terraform init`, `terraform validate`, `terraform plan`, and `terraform apply` from the same directory containing your `.tf` files.
- Use `pwd` (Linux/macOS/Git Bash) or `cd` (Windows Command Prompt) to confirm your current location.

---

# Related Commands

```bash
# Move to the Terraform directory
cd terraform

# Verify current location
pwd

# List Terraform files
ls

# Initialize Terraform
terraform init

# Validate configuration
terraform validate

# Preview infrastructure changes
terraform plan
```

---