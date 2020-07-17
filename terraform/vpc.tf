resource "aws_vpc" "ichihara_VPC" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "false"
  enable_dns_hostnames = "false"
  tags = {
    Name = "ichihara_VPC"
  }
}

resource "aws_internet_gateway" "ichihara_GateWay" {
  vpc_id = "${aws_vpc.ichihara_VPC.id}"
}

resource "aws_subnet" "ichihara_Subnet" {
  vpc_id            = "${aws_vpc.ichihara_VPC.id}"
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-east-1a"
}


resource "aws_subnet" "purchase_app_RDS1" {
  vpc_id            = "${aws_vpc.ichihara_VPC.id}"
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "private-purchase_app_RDS1"
  }
}

resource "aws_subnet" "purchase_app_RDS2" {
  vpc_id            = "${aws_vpc.ichihara_VPC.id}"
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "private-purchase_app_RDS2"
  }
}

resource "aws_route_table" "ichihara_Route_Table" {
  vpc_id = "${aws_vpc.ichihara_VPC.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.ichihara_GateWay.id}"
  }
}

resource "aws_route_table_association" "ass"{
  subnet_id      = "${aws_subnet.ichihara_Subnet.id}"
  route_table_id = "${aws_route_table.ichihara_Route_Table.id}"
}

resource "aws_security_group" "ichihara_security_group" {
  name   = "ichihara_security_group"
  vpc_id = "${aws_vpc.ichihara_VPC.id}"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "SG_for_purchase_app_RDS" {
  name   = "SG_for_purchase_app_RDS"
  vpc_id = "${aws_vpc.ichihara_VPC.id}"
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_eip" "web" {
  instance = "${aws_instance.Ichihara_instance.id}"
  vpc      = true
}
