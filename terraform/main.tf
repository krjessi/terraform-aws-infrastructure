#############################################
# Root Module
#############################################

# This file serves as the entry point for the Terraform configuration.
#
# As the project evolves, it will orchestrate reusable modules such as:

#############################################
# VPC Module
#############################################

module "vpc" {

  source = "./modules/vpc"

  project_name = var.project_name
  environment  = var.environment
  vpc_cidr     = var.vpc_cidr
  common_tags  = local.common_tags

  availability_zones       = var.availability_zones
  public_subnet_cidrs      = var.public_subnet_cidrs
  private_app_subnet_cidrs = var.private_app_subnet_cidrs
  private_db_subnet_cidrs  = var.private_db_subnet_cidrs
}

# - Security Groups
# - IAM
# - Application Load Balancer
# - EC2
# - Auto Scaling Group
# - RDS
# - CloudWatch Monitoring
#
# All infrastructure resources will be created inside dedicated modules
# located under the modules/ directory.

#############################################
# Security Module
#############################################

module "security" {

  source = "./modules/security"

  project_name = var.project_name

  environment = var.environment

  vpc_id = module.vpc.vpc_id

  common_tags = local.common_tags
}