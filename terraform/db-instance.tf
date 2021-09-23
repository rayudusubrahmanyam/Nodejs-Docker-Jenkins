resource "aws_instance" "demo-develop-DBserver" {
  ami                         = var.AMIS[var.REGION-ID]
  instance_type               = var.INSTANCE-TYPE
  key_name                    = "my-webapp-key"
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.demo-develop-subnet-2.id
  vpc_security_group_ids      = [aws_security_group.demo-develop-private-sg.id]
  availability_zone			      = var.AVAIL-ZONE-2


  user_data = <<-EOF
  #!/bin/bash
  cat /etc/issue
  sudo apt update && install curl
  sudo apt-get update
  sudo apt-get install apt-transport-https
  sudo apt-get upgrade -y
  sudo apt install docker.io -y
  sudo usermod -aG docker ubuntu
  sudo systemctl enable docker
  sudo systemctl start docker
  sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
  sudo docker-compose --version
  sudo mkdir -pv /home/ubuntu/mongodb/database
  sudo echo "
  version: "3.8"
  services:
  mongodb:
  image : mongo
  container_name: mongodb
  environment:
  - PUID=1000
  - PGID=1000
  volumes:
  - /home/ubuntu/mongodb/database:/data/db
  ports:
  - 27017:27017
  restart: unless-stopped" >> /home/ubuntu/docker-compose.yml

  sudo docker-compose up -d
  EOF 

  
  tags = {
  Name = "demo-develop-DBserver"
  }

}

