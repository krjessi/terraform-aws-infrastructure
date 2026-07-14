#############################################
# Outputs
#############################################

output "autoscaling_group_name" {
  value = aws_autoscaling_group.main.name
}

output "autoscaling_group_arn" {
  value = aws_autoscaling_group.main.arn
}