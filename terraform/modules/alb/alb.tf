#############################################
# Application Load Balancer
#############################################

resource "aws_lb" "main" {

  name = "${local.name_prefix}-alb"

  internal = false

  load_balancer_type = "application"

  security_groups = [
    var.alb_security_group_id
  ]

  subnets = var.public_subnet_ids

  enable_deletion_protection = false

  idle_timeout = 60

  tags = merge(
    var.common_tags,
    {
      Name = "${local.name_prefix}-alb"
    }
  )

}