#############################################
# Launch Template
#############################################

resource "aws_launch_template" "main" {

  name_prefix = "${local.name_prefix}-"

  image_id = data.aws_ssm_parameter.amazon_linux.value

  instance_type = var.instance_type

  update_default_version = true

  iam_instance_profile {
    name = var.instance_profile_name
  }

  vpc_security_group_ids = [
    var.ec2_security_group_id
  ]

  user_data = base64encode(
    file("${path.module}/user-data.sh")
  )

  monitoring {
    enabled = true
  }

  metadata_options {

    http_endpoint = "enabled"

    http_tokens = "required"

    http_put_response_hop_limit = 2

  }

  block_device_mappings {

    device_name = "/dev/xvda"

    ebs {

      volume_size = 20

      volume_type = "gp3"

      encrypted = true

      delete_on_termination = true

    }

  }

  tag_specifications {

    resource_type = "instance"

    tags = merge(
      var.common_tags,
      {
        Name = "${local.name_prefix}-ec2"
      }
    )

  }

  tags = merge(
    var.common_tags,
    {
      Name = "${local.name_prefix}-launch-template"
    }
  )

}