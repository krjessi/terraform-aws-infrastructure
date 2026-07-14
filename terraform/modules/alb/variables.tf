#############################################
# Project
#############################################

variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

#############################################
# Networking
#############################################

variable "vpc_id" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}

#############################################
# Security
#############################################

variable "alb_security_group_id" {
  type = string
}

#############################################
# Tags
#############################################

variable "common_tags" {
  type = map(string)
}