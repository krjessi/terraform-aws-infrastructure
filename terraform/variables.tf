#############################################
# Project Variables
#############################################

variable "project_name" {
  description = "Name of the project."
  type        = string
  default     = "linkedin-clone"
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

#############################################
# Networking
#############################################

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
}

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

#############################################
# Security
#############################################

variable "enable_security_module" {
  description = "Enable Security Module."
  type        = bool
  default     = true
}

#############################################
# Nat-Gateway
#############################################

variable "enable_nat_gateway" {
  description = "Enable NAT Gateway"
  type        = bool
  default     = false
}