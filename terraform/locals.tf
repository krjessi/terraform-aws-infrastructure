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

    ManagedBy = "Terraform"
    Owner     = "Mukesh Kumar"

    Repository = "terraform-aws-infrastructure"

    CreatedBy = "Terraform"

    Terraform = "true"
  }

}