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