provider "aws" {
  region     = "us-east-1"
  access_key = ""
  secret_key = ""
}


resource "aws_vpc" "TEST_VPC" {
  cidr_block       = "10.20.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Test_VPC"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.TEST_VPC.id

  tags = {
    Name = "Test_IGW"
  }
}

resource "aws_subnet" "Test-1" {
  vpc_id     = aws_vpc.TEST_VPC.id
  cidr_block = "10.20.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "Public_Test-1"
  }
}

resource "aws_subnet" "Test-2" {
  vpc_id     = aws_vpc.TEST_VPC.id
  cidr_block = "10.20.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "Public_Test-2"
  }
}

resource "aws_route_table" "route-1" {
  vpc_id = aws_vpc.TEST_VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Test_Route"
  }
}


resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.Test-1.id
  route_table_id = aws_route_table.route-1.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.Test-1.id
  route_table_id = aws_route_table.route-1.id
}

resource "aws_security_group" "Sec_1" {
  vpc_id      = aws_vpc.TEST_VPC.id

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Test_Sec-1"
  }
}
