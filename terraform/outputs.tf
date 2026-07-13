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

#############################################
# VPC Outputs
#############################################

output "vpc_id" {
  description = "ID of the created VPC."
  value       = module.vpc.vpc_id
}

output "vpc_cidr" {
  description = "CIDR block of the created VPC."
  value       = module.vpc.vpc_cidr
}

#############################################
# ALB Security Group
#############################################

output "alb_security_group_id" {
  description = "ALB Security Group ID."
  value       = module.security.alb_security_group_id
}

#############################################
# EC2 Security Group
#############################################

output "ec2_security_group_id" {
  description = "EC2 Security Group ID."
  value       = module.security.ec2_security_group_id
}

#############################################
# RDS Security Group
#############################################

output "rds_security_group_id" {
  description = "RDS Security Group ID."
  value       = module.security.rds_security_group_id
}