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

  enable_nat_gateway = var.enable_nat_gateway

  vpc_cidr    = var.vpc_cidr
  common_tags = local.common_tags

  availability_zones       = var.availability_zones
  public_subnet_cidrs      = var.public_subnet_cidrs
  private_app_subnet_cidrs = var.private_app_subnet_cidrs
  private_db_subnet_cidrs  = var.private_db_subnet_cidrs
}

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

#############################################
# IAM Module
#############################################

module "iam" {

  source = "./modules/iam"

  project_name = var.project_name

  environment = var.environment

  common_tags = local.common_tags
}

#############################################
# Launch Template Module
#############################################

module "launch_template" {

  source = "./modules/launch-template"

  project_name = var.project_name
  environment  = var.environment

  ec2_security_group_id = module.security.ec2_security_group_id

  instance_profile_name = module.iam.instance_profile_name

  common_tags = local.common_tags
}

#############################################
# Auto Scaling Module
#############################################

module "autoscaling" {

  source = "./modules/autoscaling"

  project_name = var.project_name
  environment  = var.environment

  launch_template_id      = module.launch_template.launch_template_id
  launch_template_version = module.launch_template.launch_template_latest_version

  private_subnet_ids = module.vpc.private_app_subnet_ids

  common_tags = local.common_tags

}


# - Application Load Balancer
# - EC2
# - RDS
# - CloudWatch Monitoring
#
# All infrastructure resources will be created inside dedicated modules
# located under the modules/ directory.