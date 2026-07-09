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

# Troubleshooting

This document records common issues encountered during the Terraform project along with their causes and recommended solutions.

---

# Issue: Reference to Undeclared Input Variable

## Problem

While running:

```bash
terraform validate
```

Terraform displays an error similar to:

```text
Error: Reference to undeclared input variable

A managed resource, data resource, or provider configuration
references an input variable that has not been declared.
```

---

## Cause

The Terraform configuration references a variable that has **not been declared**.

For example:

```hcl
provider "aws" {
  region = var.aws_region
}
```

If the following variable does not exist in `variables.tf`:

```hcl
variable "aws_region" {
}
```

Terraform cannot resolve `var.aws_region` and throws this error.

---

## Solution

Create the required variable in the `variables.tf` file.

Example:

```hcl
variable "aws_region" {
  description = "AWS Region where resources will be deployed."
  type        = string
  default     = "ap-south-1"
}
```

After creating the variable, run:

```bash
terraform fmt

terraform validate
```

The error should be resolved.

---

# Issue: Reference to Undeclared Local Value

## Problem

Terraform displays an error similar to:

```text
Error: Reference to undeclared local value

A local value with the given name has not been declared.
```

---

## Cause

The Terraform configuration references a local value that has **not yet been defined**.

Example:

```hcl
provider "aws" {

  default_tags {
    tags = local.common_tags
  }

}
```

If `locals.tf` does not contain:

```hcl
locals {
  common_tags = {
    ...
  }
}
```

Terraform cannot resolve `local.common_tags`.

---

## Solution

Define the required local value in `locals.tf`.

Example:

```hcl
locals {

  common_tags = {
    Project     = "LinkedIn Clone"
    Environment = "dev"
    Owner       = "Mukesh Kumar"
    ManagedBy   = "Terraform"
  }

}
```

Then verify the configuration:

```bash
terraform fmt

terraform validate
```

The validation error should disappear.

---

# Troubleshooting Summary

| Issue | Cause | Solution |
|-------|-------|----------|
| **Reference to undeclared input variable** | `variables.tf` has not been created or the required variable has not been declared. | Create the required variable in `variables.tf`. |
| **Reference to undeclared local value** | `locals.tf` has not been created or the required local value has not been defined. | Define the required local value in `locals.tf`. |

---

# Best Practices

- Declare all input variables before referencing them.
- Keep all reusable values inside `locals.tf`.
- Use meaningful variable names and descriptions.
- Validate your configuration frequently using:

```bash
terraform validate
```

- Format your Terraform files before committing:

```bash
terraform fmt
```

- Build Terraform projects incrementally. Temporary validation errors are expected while supporting files are still being created.

---

# Verification Commands

```bash
# Format Terraform configuration
terraform fmt

# Validate configuration
terraform validate

# Initialize Terraform (if not already initialized)
terraform init
```

---

# Related Files

```text
terraform/
│
├── provider.tf
├── variables.tf
├── locals.tf
├── versions.tf
├── outputs.tf
├── data.tf
└── main.tf
```

---

## 📌 Note

These errors are common during the early stages of a Terraform project. As you create `variables.tf` and `locals.tf` in subsequent steps, Terraform will be able to resolve these references, and the validation errors will disappear.

---

# Troubleshooting

This document records common issues encountered during the Terraform project, along with their causes and recommended solutions.

---

# Issue: Invalid Environment Value

## Problem

While running:

```bash
terraform validate
```

or

```bash
terraform plan
```

Terraform displays an error similar to:

```text
Error: Invalid value for variable

Environment must be one of: dev, stage, or prod.
```

---

## Cause

The value assigned to the `environment` variable does not satisfy the validation rule defined in `variables.tf`.

Example of an invalid value:

```hcl
environment = "testing"
```

The validation block only allows:

- `dev`
- `stage`
- `prod`

---

## Solution

Update the `environment` variable to one of the supported values.

Example:

```hcl
environment = "dev"
```

or

```hcl
environment = "stage"
```

or

```hcl
environment = "prod"
```

Then run:

```bash
terraform validate
```

The validation should complete successfully.

---

# Issue: Variable Not Found

## Problem

Terraform displays an error similar to:

```text
Error: Reference to undeclared input variable

An input variable with the name "aws_region"
has not been declared.
```

---

## Cause

Terraform is referencing a variable that has not been declared in `variables.tf`.

Example:

```hcl
provider "aws" {
  region = var.aws_region
}
```

If `variables.tf` does not contain:

```hcl
variable "aws_region" {
}
```

Terraform cannot resolve the variable.

---

## Solution

Declare the required variable in `variables.tf`.

Example:

```hcl
variable "aws_region" {
  description = "AWS region where resources will be deployed."
  type        = string
  default     = "ap-south-1"
}
```

After adding the variable, run:

```bash
terraform fmt

terraform validate
```

The error should be resolved.

---

# Troubleshooting Summary

| Issue | Cause | Solution |
|-------|-------|----------|
| **Invalid environment value** | Variable validation failed because an unsupported environment name was provided. | Use one of the supported values: `dev`, `stage`, or `prod`. |
| **Variable not found** | The required variable has not been declared in `variables.tf`. | Define the missing variable in `variables.tf`. |

---

# Best Practices

- Always declare variables before referencing them.
- Use meaningful variable names such as `aws_region`, `project_name`, and `environment`.
- Add validation rules to prevent invalid input values.
- Use descriptive error messages to simplify troubleshooting.
- Run `terraform validate` after modifying `variables.tf`.
- Format Terraform files using:

```bash
terraform fmt
```

before committing changes.

---

# Verification Commands

```bash
# Format Terraform files
terraform fmt

# Validate Terraform configuration
terraform validate

# Display variable values (during planning)
terraform plan
```

---

# Related Files

```text
terraform/
│
├── variables.tf
├── provider.tf
├── locals.tf
├── versions.tf
├── outputs.tf
├── data.tf
└── main.tf
```

---

## 📌 Note

Validation errors are designed to protect your infrastructure by catching configuration mistakes before deployment. Defining variables correctly and applying validation rules are key practices for building reliable, maintainable, and enterprise-ready Terraform projects.

---

# Troubleshooting

This document records common issues encountered during the Terraform project, along with their causes, solutions, and best practices.

---

# Issue: Reference to Undeclared Local Value

## Problem

While running:

```bash
terraform validate
```

Terraform displays an error similar to:

```text
Error: Reference to undeclared local value

A local value with the given name has not been declared.
```

---

## Cause

The Terraform configuration references a local value that has not been defined in `locals.tf`.

Example:

```hcl
provider "aws" {

  default_tags {
    tags = local.common_tags
  }

}
```

If `locals.tf` does not contain:

```hcl
locals {
  common_tags = {
    ...
  }
}
```

Terraform cannot resolve `local.common_tags` and reports the error.

---

## Solution

Create the required local value in `locals.tf`.

Example:

```hcl
locals {

  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Owner       = "Mukesh Kumar"
    Repository  = "terraform-aws-infrastructure"
  }

}
```

After saving the file, verify the configuration.

```bash
terraform fmt

terraform validate
```

Expected output:

```text
Success! The configuration is valid.
```

---

# Issue: Repeated Tag Definitions

## Problem

Every AWS resource contains the same tag block.

Example:

```hcl
resource "aws_vpc" "main" {

  tags = {
    Project     = "linkedin"
    Environment = "dev"
    ManagedBy   = "Terraform"
  }

}
```

Copying this block into every resource leads to duplicated code.

---

## Cause

Tags are defined individually instead of using a centralized local value.

This makes the configuration:

* Difficult to maintain
* Error-prone
* Inconsistent across resources

---

## Solution

Create a reusable local value in `locals.tf`.

Example:

```hcl
locals {

  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Owner       = "Mukesh Kumar"
    Repository  = "terraform-aws-infrastructure"
  }

}
```

Then reference it wherever tags are required.

Example:

```hcl
tags = local.common_tags
```

Or configure it once in the AWS provider using `default_tags`:

```hcl
provider "aws" {

  default_tags {
    tags = local.common_tags
  }

}
```

Terraform will automatically apply these tags to all supported AWS resources.

---

# Troubleshooting Summary

| Issue                                   | Cause                                                         | Solution                                                                                                                 |
| --------------------------------------- | ------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------ |
| **Reference to undeclared local value** | The required local value has not been defined in `locals.tf`. | Create the local value inside `locals.tf`.                                                                               |
| **Repeated tag definitions**            | Tags are copied into every resource individually.             | Define tags once using `local.common_tags` and reuse them or apply them through the AWS Provider's `default_tags` block. |

---

# Best Practices

* Define reusable values inside `locals.tf`.
* Avoid duplicating tag definitions across resources.
* Use `local.common_tags` for consistent tagging.
* Configure `default_tags` in the AWS Provider whenever possible.
* Run `terraform fmt` and `terraform validate` after updating local values.
* Follow the **DRY (Don't Repeat Yourself)** principle to keep Terraform configurations clean and maintainable.

---

# Verification Commands

```bash
# Format Terraform configuration
terraform fmt

# Validate Terraform configuration
terraform validate

# Initialize Terraform (if required)
terraform init
```

---

# Related Files

```text
terraform/
│
├── locals.tf
├── provider.tf
├── variables.tf
├── versions.tf
├── data.tf
├── outputs.tf
└── main.tf
```

---

## 📌 Note

Centralizing reusable values in `locals.tf` improves consistency, reduces duplicate code, and makes future updates significantly easier. If a common value changes, you only need to update it in one place instead of modifying every resource.

---