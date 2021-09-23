resource "aws_security_group" "demo-develop-private-sg" {
   vpc_id = aws_vpc.demo-develop-vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.VPC-CIDR-BLOCK]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    prefix_list_ids = []
  }

  tags = {
    Name = "${var.TAGNAME}-private-sg"
  }
}
