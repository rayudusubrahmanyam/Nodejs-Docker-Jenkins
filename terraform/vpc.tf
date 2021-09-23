
resource "aws_vpc" "demo-develop-vpc" {
  cidr_block = var.VPC-CIDR-BLOCK
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "${var.TAGNAME}-vpc"
  }
}

resource "aws_internet_gateway" "demo-develop-igw" {
  vpc_id = aws_vpc.demo-develop-vpc.id
  tags = {
    Name = "${var.TAGNAME}-igw"
  }
}

resource "aws_subnet" "demo-develop-subnet-1" {
  vpc_id            = aws_vpc.demo-develop-vpc.id
  cidr_block        = var.SUBNET-CIDR-BLOCK[0]
  map_public_ip_on_launch = true
  availability_zone = var.AVAIL-ZONE-1
  tags = {
    Name = "${var.TAGNAME}-subnet-1"
  }
}

resource "aws_subnet" "demo-develop-subnet-2" {
  vpc_id            = aws_vpc.demo-develop-vpc.id
  cidr_block        = var.SUBNET-CIDR-BLOCK[1]
  availability_zone = var.AVAIL-ZONE-2
  tags = {
    Name = "${var.TAGNAME}-subnet-2"
  }
}

resource "aws_default_route_table" "demo-develop-main-rtb" {
  default_route_table_id = aws_vpc.demo-develop-vpc.default_route_table_id

  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.demo-develop-igw.id
    }

  tags = {
    Name = "${var.TAGNAME}-main-rtb"
  }
}


resource "aws_route_table" "demo-develop-private-rtb" {
  vpc_id = aws_vpc.demo-develop-vpc.id
    
    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_nat_gateway.demo-develop-nat-gw.id
    }
  
  tags = {
    Name = "${var.TAGNAME}-private-rtb"
  }
}

resource "aws_route_table_association" "a-route-subnet" {
  subnet_id = aws_subnet.demo-develop-subnet-2.id
  route_table_id = aws_route_table.demo-develop-private-rtb.id
}

resource "aws_eip" "demo-develop-eip" {
   depends_on = [aws_internet_gateway.demo-develop-igw]
}

resource "aws_nat_gateway" "demo-develop-nat-gw"{
  allocation_id = aws_eip.demo-develop-eip.id
  subnet_id = aws_subnet.demo-develop-subnet-1.id
  tags = {
    Name = "NAT 1"
  }
}