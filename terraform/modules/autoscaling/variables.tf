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
# Launch Template
#############################################

variable "launch_template_id" {
  type = string
}

variable "launch_template_version" {
  type = string
}

#############################################
# Networking
#############################################

variable "private_subnet_ids" {
  type = list(string)
}

#############################################
# Auto Scaling
#############################################

variable "desired_capacity" {
  type    = number
  default = 2
}

variable "min_size" {
  type    = number
  default = 2
}

variable "max_size" {
  type    = number
  default = 4
}

#############################################
# Tags
#############################################

variable "common_tags" {
  type = map(string)
}