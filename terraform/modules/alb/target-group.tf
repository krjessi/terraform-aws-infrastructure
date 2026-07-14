#############################################
# Target Group
#############################################

resource "aws_lb_target_group" "main" {

  name = "${local.name_prefix}-tg"

  port = 8080

  protocol = "HTTP"

  target_type = "instance"

  vpc_id = var.vpc_id

  health_check {

    enabled = true

    path = "/actuator/health"

    protocol = "HTTP"

    matcher = "200"

    interval = 30

    timeout = 5

    healthy_threshold = 2

    unhealthy_threshold = 2

  }

  tags = merge(
    var.common_tags,
    {
      Name = "${local.name_prefix}-tg"
    }
  )

}