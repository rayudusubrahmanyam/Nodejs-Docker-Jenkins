
output "demo-develop-webserver-id" {
  value = aws_instance.demo-develop-webserver.id
}

output "ec2-public-ip" {
  value = aws_instance.demo-develop-webserver.public_ip
}