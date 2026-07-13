#############################################
# EC2 Security Group
#############################################

resource "aws_security_group" "ec2" {

  name = "${var.project_name}-${var.environment}-ec2-sg"

  description = "Security Group for EC2"

  vpc_id = var.vpc_id

  ingress {

    description = "Spring Boot Application"

    from_port = 8080
    to_port   = 8080

    protocol = "tcp"

    security_groups = [
      aws_security_group.alb.id
    ]
  }

  egress {

    from_port = 0
    to_port   = 0

    protocol = "-1"

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-ec2-sg"
    }
  )
}