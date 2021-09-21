# Target Group
resource "aws_lb_target_group" "demo-develop-tg" {
  name     = "demo-develop-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.demo-develop-vpc.id
}

# Application Load Balancer
resource "aws_lb" "demo-develop-alb" {
  name               = "demo-develop-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_default_security_group.demo-develop-default-sg.id]
  subnets            = [aws_subnet.demo-develop-subnet-1.id, aws_subnet.demo-develop-subnet-2.id]

  # enable_deletion_protection = true

  tags = {
    Environment = "production"
  }
}

# Target Group & Load Balancer Attachment
resource "aws_lb_target_group_attachment" "demo-develop" {
  target_group_arn = aws_lb_target_group.demo-develop-tg.arn
  target_id        = aws_instance.demo-develop-webserver.id
  port             = 8080
}

# Load Balancer Listener
resource "aws_lb_listener" "demo-develop-listener" {
  load_balancer_arn = aws_lb.demo-develop-alb.arn
  port              = "8080"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.demo-develop-tg.arn
  }
}


