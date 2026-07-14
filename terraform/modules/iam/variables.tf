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
# Common Tags
#############################################

variable "common_tags" {
  description = "Common tags."
  type        = map(string)
}