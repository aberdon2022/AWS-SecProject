resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "VPC"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.public_subnet_cidr
  map_public_ip_on_launch = false
  availability_zone = "eu-west-3a"

  tags = {
    Name = "Public Subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.private_subnet_cidr
  availability_zone = "eu-west-3b"

  tags = {
    Name = "Private Subnet"
  }
  
}

resource "aws_vpc_endpoint" "s3_endpoint" {
  vpc_id = aws_vpc.vpc.id
  service_name = "com.amazonaws.${var.region}.s3"
  route_table_ids = [aws_route_table.public_route_table.id]
  vpc_endpoint_type = "Gateway"

  tags = {
    Name = "S3 Endpoint"
  }
}

resource "aws_security_group" "hpot_sg" {
  vpc_id = aws_vpc.vpc.id
  description = "Allow traffic to the honeypot"

  ingress {
    description = "Allow SSH traffic from anywhere"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    description = "Allow Telnet traffic from anywhere"
    from_port = 23
    to_port = 23
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    description = "Allow all traffic to anywhere"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "hpot_sg"
  }
}

resource "aws_internet_gateway" "Gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "Internet Gateway"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Gateway.id
  }

  tags = {
    Name = "Public Route Table"
  }
}

resource "aws_route_table_association" "public_rt_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}