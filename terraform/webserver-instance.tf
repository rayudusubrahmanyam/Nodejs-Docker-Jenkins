resource "aws_instance" "demo-develop-webserver" {
  ami                         = var.AMIS[var.REGION-ID]
  instance_type               = var.INSTANCE-TYPE
  key_name                    = "my-webapp-key"
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.demo-develop-subnet-1.id
  vpc_security_group_ids      = [aws_default_security_group.demo-develop-default-sg.id]
  availability_zone			      = var.AVAIL-ZONE-1

  user_data = <<-EOF
  #!/bin/bash
  cat /etc/issue
  sudo apt update && install curl
  sudo curl -sL https://deb.nodesource.com/setup_10.x -o nodesource_setup.sh
  sudo apt install nodejs -y
  sudo apt install npm -y
  sudo apt-get update
  sudo apt-get install apt-transport-https
  sudo apt-get upgrade -y
  sudo apt install docker.io -y
  sudo usermod -aG docker ubuntu
  sudo systemctl enable docker
  sudo systemctl start docker
  EOF   

  tags = {
  Name = "demo-develop-webserver"
  }

}