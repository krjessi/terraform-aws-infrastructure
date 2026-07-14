#############################################
# IAM Outputs
#############################################

output "role_name" {
  description = "EC2 IAM Role."

  value = aws_iam_role.ec2.name
}

output "instance_profile_name" {
  description = "EC2 Instance Profile."

  value = aws_iam_instance_profile.ec2.name
}

output "instance_profile_arn" {
  description = "EC2 Instance Profile ARN."

  value = aws_iam_instance_profile.ec2.arn
}