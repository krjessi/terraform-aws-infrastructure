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
# EC2 Configuration
#############################################

variable "instance_type" {

  description = "EC2 instance type"

  type = string

  default = "t3.micro"

  validation {

    condition = contains(
      [
        "t3.micro",
        "t3.small"
      ],
      var.instance_type
    )

    error_message = "Only t3.micro and t3.small are supported."

  }

}

#############################################
# Networking
#############################################

variable "ec2_security_group_id" {
  description = "EC2 Security Group ID."
  type        = string
}

#############################################
# IAM
#############################################

variable "instance_profile_name" {
  description = "IAM Instance Profile."
  type        = string
}

#############################################
# Tags
#############################################

variable "common_tags" {
  description = "Common tags."
  type        = map(string)
}