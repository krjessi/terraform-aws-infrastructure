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

#############################################
# Networking
#############################################

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
}

variable "common_tags" {
  description = "Common tags applied to all resources."
  type        = map(string)
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
# Nat-Gateway
#############################################

variable "enable_nat_gateway" {
  description = "Enable NAT Gateway"
  type        = bool
  default     = false
}