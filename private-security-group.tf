resource "aws_security_group" "demo-develop-private-sg" {
   vpc_id = aws_vpc.demo-develop-vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.VPC-CIDR-BLOCK]
  }

  tags = {
    Name = "${var.TAGNAME}-private-sg"
  }
}
