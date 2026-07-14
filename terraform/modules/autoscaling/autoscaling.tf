#############################################
# Auto Scaling Group
#############################################

resource "aws_autoscaling_group" "main" {

  name = "${local.name_prefix}-asg"

  min_size = var.min_size
  max_size = var.max_size
  desired_capacity = var.desired_capacity

  health_check_type = "EC2"
  health_check_grace_period = 300

  vpc_zone_identifier = var.private_subnet_ids

  launch_template {
    id = var.launch_template_id
    version = var.launch_template_latest_version
  }

  capacity_rebalance = true

  force_delete = true

  termination_policies = [
    "OldestLaunchTemplate"
  ]

  enabled_metrics = [
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]

  lifecycle {
    create_before_destroy = true
  }

  dynamic "tag" {
    for_each = merge(
      var.common_tags,
      {
        Name = "${local.name_prefix}-ec2"
      }
    )

    content {
      key = tag.key
      value = tag.value
      propagate_at_launch = true
    }
  }
}