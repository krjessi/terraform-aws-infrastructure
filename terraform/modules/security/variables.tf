#############################################
# Project Information
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
  description = "VPC ID where security groups will be created."
  type        = string
}

#############################################
# Common Tags
#############################################

variable "common_tags" {
  description = "Common resource tags."
  type        = map(string)
}