#############################################
# Root Module
#############################################

# This file serves as the entry point for the Terraform configuration.
#
# As the project evolves, it will orchestrate reusable modules such as:
#
# - VPC
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