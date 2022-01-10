resource "aws_autoscaling_group" "web_server" {
  launch_configuration = aws_launch_configuration.web_server.name
  vpc_zone_identifier  = module.vpc.private_subnets

  target_group_arns = [aws_lb_target_group.webservers_tg.arn]
  health_check_type = "ELB"

  min_size = 1
  max_size = 3

  tag {
    key                 = "Name"
    value               = "web_server"
    propagate_at_launch = true
  }
}

resource "aws_launch_configuration" "web_server" {
  image_id             = data.aws_ami.webserver.id
  instance_type        = "t2.micro"
  iam_instance_profile = aws_iam_instance_profile.ec2_s3_access_profile.name
  security_groups      = [aws_security_group.webserver.id]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_policy" "web_policy_up" {
  name                   = "web_policy_up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.web_server.name
}

resource "aws_autoscaling_policy" "web_policy_down" {
  name                   = "web_policy_down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.web_server.name
}

data "aws_ami" "webserver" {
  most_recent = true
  owners      = ["self"]
  filter {
    name   = "name"
    values = ["nginx-cloudwatch-${var.region}"]
  }
}
