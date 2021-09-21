resource "aws_launch_configuration" "demo-develop-launch-config" {
  image_id        = var.AMIS[var.REGION-ID]
  instance_type   = var.INSTANCE-TYPE
  security_groups = [aws_default_security_group.demo-develop-default-sg.id]

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p ${var.server_port} &
              EOF

  # Required when using a launch configuration with an auto scaling group.
  # https://www.terraform.io/docs/providers/aws/r/launch_configuration.html
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "demo-develop-asg" {
  launch_configuration = aws_launch_configuration.demo-develop-launch-config.name
  vpc_zone_identifier  = data.aws_subnet_ids.demo-develop-vpc.ids

  target_group_arns = [aws_lb_target_group.asg.arn]
  health_check_type = "ELB"

  min_size = 2
  max_size = 10

  tag {
    key                 = "Name"
    value               = "demo-develop-asg"
    propagate_at_launch = true
  }
}

resource "aws_security_group" "demo-develop-asg-" {
  name = var.instance_security_group_name

  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}