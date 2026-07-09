#############################################
# AWS Account Information
#############################################

output "aws_account_id" {
  description = "AWS Account ID currently in use."
  value       = data.aws_caller_identity.current.account_id
}

#############################################
# AWS Region
#############################################

output "aws_region" {
  description = "AWS Region where Terraform is running."
  value       = data.aws_region.current.region
}

#############################################
# Availability Zones
#############################################

output "availability_zones" {
  description = "Available Availability Zones in the selected AWS region."
  value       = data.aws_availability_zones.available.names
}