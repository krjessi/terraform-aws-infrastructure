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

# Troubleshooting

This document records common issues encountered during the Terraform project, along with their causes, resolutions, and recommended best practices.

---

# Issue: Error Reading AWS Data Source

## Problem

While running:

```bash
terraform plan
```

or

```bash
terraform apply
```

Terraform displays an error similar to:

```text
Error: reading AWS data source

Error: failed to query AWS API
```

or

```text
Error: No valid credential sources found
```

or

```text
AccessDenied
```

---

## Cause

Terraform cannot authenticate with AWS because the configured credentials are:

* Invalid
* Missing
* Expired
* Incorrectly configured
* Missing required IAM permissions

Since data sources communicate directly with AWS APIs, authentication must succeed before Terraform can retrieve information.

---

## Solution

### Step 1: Verify AWS Credentials

Run:

```bash
aws sts get-caller-identity
```

Expected output:

```json
{
  "UserId": "AIDXXXXXXXXXXXXXXX",
  "Account": "123456789012",
  "Arn": "arn:aws:iam::123456789012:user/terraform-user"
}
```

If this command fails, Terraform will also fail to authenticate.

---

### Step 2: Reconfigure AWS CLI (if necessary)

```bash
aws configure
```

Provide:

* AWS Access Key ID
* AWS Secret Access Key
* Default Region
* Output Format

---

### Step 3: Verify IAM Permissions

Ensure the IAM user or IAM role has permission to read AWS resources.

Typical permissions include:

* `sts:GetCallerIdentity`
* `ec2:DescribeAvailabilityZones`
* `ec2:DescribeRegions`

---

### Step 4: Retry

Run:

```bash
terraform plan
```

Terraform should now successfully retrieve the required data sources.

---

# Issue: No Availability Zones Returned

## Problem

Terraform displays an error similar to:

```text
No Availability Zones found
```

or returns an empty list for:

```hcl
data.aws_availability_zones.available.names
```

---

## Cause

Common causes include:

* Incorrect AWS Region configured
* Unsupported AWS Region
* Insufficient IAM permissions
* AWS account restrictions

Terraform can only retrieve Availability Zones that are available in the configured Region and accessible to the authenticated account.

---

## Solution

### Step 1: Verify the AWS Region

Check your provider configuration.

Example:

```hcl
provider "aws" {
  region = var.aws_region
}
```

Confirm that the value of `aws_region` is valid.

Example:

```text
ap-south-1
```

---

### Step 2: Verify the Current Region

Run:

```bash
aws configure get region
```

Or inspect the Terraform variable value.

---

### Step 3: Verify IAM Permissions

The IAM identity should have permission to execute:

* `ec2:DescribeAvailabilityZones`

Without this permission, Terraform cannot retrieve Availability Zone information.

---

### Step 4: Test with the AWS CLI

Run:

```bash
aws ec2 describe-availability-zones
```

If this command succeeds, Terraform should also be able to retrieve the Availability Zones.

---

# Troubleshooting Summary

| Issue                              | Cause                                                 | Solution                                                                                                                                                   |
| ---------------------------------- | ----------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Error reading AWS data source**  | Invalid, missing, or expired AWS credentials.         | Verify authentication using `aws sts get-caller-identity`, reconfigure the AWS CLI if necessary, and ensure the IAM identity has the required permissions. |
| **No Availability Zones returned** | Incorrect AWS Region or insufficient IAM permissions. | Verify the configured AWS Region and confirm the IAM identity can call `ec2:DescribeAvailabilityZones`.                                                    |

---

# Best Practices

* Verify AWS authentication before running Terraform commands.
* Test AWS CLI access using `aws sts get-caller-identity`.
* Use valid AWS Region codes such as `ap-south-1`.
* Grant only the minimum IAM permissions required (principle of least privilege).
* Validate Terraform configuration before planning or applying.
* Keep AWS CLI and Terraform using the same AWS profile when appropriate.

---

# Verification Commands

```bash
# Verify AWS authentication
aws sts get-caller-identity

# Display configured AWS Region
aws configure get region

# List Availability Zones
aws ec2 describe-availability-zones

# Format Terraform configuration
terraform fmt

# Validate Terraform configuration
terraform validate

# Preview infrastructure changes
terraform plan
```

---

# Related Files

```text
terraform/
│
├── data.tf
├── provider.tf
├── variables.tf
├── locals.tf
├── versions.tf
├── outputs.tf
└── main.tf
```

---

## 📌 Note

Terraform Data Sources rely on successful communication with AWS APIs. Before troubleshooting Terraform itself, always verify that the AWS CLI can authenticate and retrieve the same information. If the AWS CLI works correctly, Terraform is much more likely to function as expected.

---

# Troubleshooting

This document records common issues encountered during the Terraform project, along with their causes, solutions, and recommended best practices.

---

# Issue: Output References Missing Resource

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
Error: Reference to undeclared resource

A managed resource "aws_vpc" "main" has not been declared in the root module.
```

or

```text
Error: Reference to undeclared data resource

A data resource "aws_region" "current" has not been declared.
```

---

## Cause

The output block references a resource or data source that does not exist.

Example:

```hcl
output "vpc_id" {
  value = aws_vpc.main.id
}
```

If `aws_vpc.main` has not been defined, Terraform cannot resolve the reference.

The same applies to data sources.

Example:

```hcl
output "aws_region" {
  value = data.aws_region.current.name
}
```

If `data.aws_region.current` has not been declared in `data.tf`, Terraform reports an error.

---

## Solution

### Step 1: Verify the Referenced Resource or Data Source

Ensure the referenced object exists.

Example:

```hcl
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}
```

or

```hcl
data "aws_region" "current" {}
```

---

### Step 2: Verify the Reference Name

Terraform references must match exactly.

Correct:

```hcl
aws_vpc.main.id
```

Incorrect:

```hcl
aws_vpc.vpc.id
```

---

### Step 3: Verify the Correct File

Confirm that the resource or data source is defined in the appropriate Terraform file.

Example project structure:

```text
terraform/
│
├── provider.tf
├── variables.tf
├── locals.tf
├── data.tf
├── outputs.tf
└── main.tf
```

---

### Step 4: Validate the Configuration

Run:

```bash
terraform fmt

terraform validate
```

Terraform should now successfully resolve the output reference.

---

# Issue: Output Value Is Null

## Problem

Terraform completes successfully, but an output displays:

```text
null
```

or

```text
(known after apply)
```

---

## Cause

The referenced value is not yet available.

Common reasons include:

* The resource has not been created.
* The value is generated only during deployment.
* The referenced object does not exist.
* The output depends on another resource that has not yet been provisioned.

Example:

```hcl
output "instance_public_ip" {
  value = aws_instance.web.public_ip
}
```

Before the EC2 instance is created, the public IP is unknown.

---

## Solution

### Step 1: Create the Resource

Run:

```bash
terraform apply
```

Terraform provisions the infrastructure and retrieves the output value.

---

### Step 2: Verify the Resource Exists

Check that the referenced resource has been created successfully.

Example:

```bash
terraform state list
```

If the resource is missing, verify that it exists in the Terraform configuration.

---

### Step 3: Display the Outputs

Run:

```bash
terraform output
```

Terraform displays all available output values.

---

### Step 4: Inspect a Specific Output

Example:

```bash
terraform output aws_region
```

or

```bash
terraform output availability_zones
```

This helps verify that the expected value is being returned.

---

# Troubleshooting Summary

| Issue                                  | Cause                                                                                            | Solution                                                                                     |
| -------------------------------------- | ------------------------------------------------------------------------------------------------ | -------------------------------------------------------------------------------------------- |
| **Output references missing resource** | The referenced resource or data source has not been declared or the reference name is incorrect. | Verify the resource or data source exists and ensure the output references the correct name. |
| **Output value is null**               | The resource has not been created yet or the value is not available until deployment.            | Run `terraform apply` or verify that the referenced resource exists.                         |

---

# Best Practices

* Always define resources and data sources before referencing them in outputs.
* Use descriptive output names.
* Validate the Terraform configuration after creating new outputs.
* Verify references carefully to avoid typographical errors.
* Use `terraform output` to confirm output values after deployment.
* Keep all output definitions in a dedicated `outputs.tf` file.

---

# Verification Commands

```bash
# Format Terraform configuration
terraform fmt

# Validate Terraform configuration
terraform validate

# Preview infrastructure changes
terraform plan

# Apply infrastructure
terraform apply

# Display all outputs
terraform output

# Display a specific output
terraform output aws_region

# List resources in Terraform state
terraform state list
```

---

# Related Files

```text
terraform/
│
├── outputs.tf
├── data.tf
├── provider.tf
├── variables.tf
├── locals.tf
├── versions.tf
└── main.tf
```

---

## 📌 Note

Outputs depend on valid resources and data sources. If Terraform cannot resolve a referenced object, verify that it has been declared correctly. If an output displays `null` or `(known after apply)`, the required value may not exist until after `terraform apply` completes successfully.

---

# Troubleshooting

This document records common issues encountered during the Terraform project, along with their causes, solutions, and recommended best practices.

---

# Issue: Required Variable Not Set

## Problem

While running:

```bash
terraform plan
```

or

```bash
terraform apply
```

Terraform displays an error similar to:

```text
Error: No value for required variable

The root module input variable "project_name" is not set,
and has no default value.
```

---

## Cause

The variable is declared in `variables.tf`, but Terraform cannot find a value because:

* `terraform.tfvars` does not exist.
* The variable is missing from `terraform.tfvars`.
* No value was supplied using `-var`.
* No value was supplied using `-var-file`.
* The variable has no default value.

Example:

```hcl
variable "project_name" {
  description = "Name of the project."
  type        = string
}
```

Since there is no `default`, Terraform requires a value.

---

## Solution

### Option 1: Add the Variable to `terraform.tfvars`

```hcl
project_name = "linkedin"

environment = "dev"

aws_region = "ap-south-1"
```

---

### Option 2: Pass the Value Using `-var`

```bash
terraform plan \
-var="project_name=linkedin"
```

---

### Option 3: Use a Variable File

```bash
terraform plan -var-file="dev.tfvars"
```

This is the preferred approach for multi-environment deployments.

---

# Issue: Wrong Region Deployed

## Problem

Terraform plans or deploys resources in an unexpected AWS Region.

Example:

Expected:

```text
ap-south-1
```

Actual:

```text
us-east-1
```

---

## Cause

The `aws_region` value in `terraform.tfvars` (or another variable source) is incorrect.

Example:

```hcl
aws_region = "us-east-1"
```

The AWS Provider uses this value:

```hcl
provider "aws" {
  region = var.aws_region
}
```

As a result, Terraform targets the wrong Region.

---

## Solution

### Step 1: Verify `terraform.tfvars`

Open:

```text
terraform/terraform.tfvars
```

Ensure the Region is correct.

Example:

```hcl
aws_region = "ap-south-1"
```

---

### Step 2: Check the Execution Plan

Run:

```bash
terraform plan
```

Confirm the provider is using the expected Region.

---

### Step 3: Verify AWS CLI Configuration

Run:

```bash
aws configure get region
```

If you're relying on the AWS CLI configuration, ensure it matches the intended deployment Region.

---

# Troubleshooting Summary

| Issue                         | Cause                                                                          | Solution                                                                       |
| ----------------------------- | ------------------------------------------------------------------------------ | ------------------------------------------------------------------------------ |
| **Required variable not set** | No value supplied for a required variable.                                     | Add the value to `terraform.tfvars` or provide it using `-var` or `-var-file`. |
| **Wrong region deployed**     | Incorrect `aws_region` value in `terraform.tfvars` or another variable source. | Verify and update the `aws_region` value before running Terraform.             |

---

# Best Practices

* Store environment-specific values in `.tfvars` files.
* Remove default values for required production variables.
* Use separate variable files for `dev`, `stage`, and `prod`.
* Verify `aws_region` before running `terraform plan`.
* Validate the configuration after updating variables.
* Keep sensitive values out of version-controlled `.tfvars` files.

---

# Verification Commands

```bash
# Format Terraform configuration
terraform fmt

# Validate Terraform configuration
terraform validate

# Preview infrastructure changes
terraform plan

# Deploy using a custom variable file
terraform plan -var-file="stage.tfvars"

# Display configured AWS Region
aws configure get region
```

---

# Related Files

```text
terraform/
│
├── variables.tf
├── terraform.tfvars
├── provider.tf
├── locals.tf
├── data.tf
├── outputs.tf
├── versions.tf
└── main.tf
```

---

## 📌 Note

When variables no longer have default values, Terraform expects every required variable to be provided. Using `terraform.tfvars` (or environment-specific files such as `dev.tfvars`, `stage.tfvars`, and `prod.tfvars`) is the recommended enterprise approach because it keeps configuration separate from code and reduces the risk of deployment errors.

---