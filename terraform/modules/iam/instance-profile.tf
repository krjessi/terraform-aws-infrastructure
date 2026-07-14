#############################################
# Instance Profile
#############################################

resource "aws_iam_instance_profile" "ec2" {

  name = "${var.project_name}-${var.environment}-instance-profile"

  role = aws_iam_role.ec2.name

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-instance-profile"
    }
  )
}