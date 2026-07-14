#############################################
# Project
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

variable "vpc_id" {
  description = "VPC ID."
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnet IDs."
  type        = list(string)
}

#############################################
# Security
#############################################

variable "alb_security_group_id" {
  description = "ALB Security Group."
  type        = string
}

#############################################
# Tags
#############################################

variable "common_tags" {
  description = "Common tags."
  type        = map(string)
}