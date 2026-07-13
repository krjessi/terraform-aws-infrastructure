#############################################
# VPC Outputs
#############################################

output "vpc_id" {
  description = "ID of the VPC."
  value       = aws_vpc.main.id
}

output "vpc_arn" {
  description = "ARN of the VPC."
  value       = aws_vpc.main.arn
}

output "vpc_cidr" {
  description = "CIDR block of the VPC."
  value       = aws_vpc.main.cidr_block
}

#############################################
# Public Subnets
#############################################

output "public_subnet_ids" {
  description = "IDs of public subnets."
  value       = aws_subnet.public[*].id
}

#############################################
# Private App Subnets
#############################################

output "private_app_subnet_ids" {
  description = "IDs of private application subnets."
  value       = aws_subnet.private_app[*].id
}

#############################################
# Private DB Subnets
#############################################

output "private_db_subnet_ids" {
  description = "IDs of private database subnets."
  value       = aws_subnet.private_db[*].id
}

#############################################
# Internet Gateway
#############################################

output "internet_gateway_id" {
  description = "ID of the Internet Gateway."
  value       = aws_internet_gateway.main.id
}

#############################################
# Public Route Table
#############################################

output "public_route_table_id" {
  description = "Public Route Table ID."
  value       = aws_route_table.public.id
}

#############################################
# Private Route Table
#############################################

output "private_app_route_table_id" {
  description = "Private Application Route Table ID."
  value       = aws_route_table.private_app.id
}

#############################################
# Private Database Route Table
#############################################

output "private_db_route_table_id" {
  description = "Private Database Route Table ID."
  value       = aws_route_table.private_db.id
}