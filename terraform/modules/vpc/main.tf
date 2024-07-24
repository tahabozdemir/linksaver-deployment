resource "aws_vpc" "linksaver_vpc" {
  cidr_block           = var.linksaver_vpc_cidr
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "Linksaver VPC"
  }
}

resource "aws_internet_gateway" "linksaver_igw" {
  vpc_id = aws_vpc.linksaver_vpc.id
  tags = {
    Name = "Linksaver Internet Gateway"
  }
}

resource "aws_route_table" "linksaver_rt_public" {
  vpc_id = aws_vpc.linksaver_vpc.id
  tags = {
    Name = "Linksaver Public Route Table"
  }
}

resource "aws_route" "linksaver_route_public" {
  route_table_id         = aws_route_table.linksaver_rt_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.linksaver_igw.id
}

resource "aws_subnet" "linksaver_subnet_public" {
  vpc_id            = aws_vpc.linksaver_vpc.id
  cidr_block        = var.linksaver_subnet_public_cidr
  availability_zone = "eu-west-1a"

  tags = {
    Name = "Linksaver Public Subnet eu-west-1a"
  }
}

resource "aws_route_table_association" "linksaver_subnet_association_public" {
  subnet_id      = aws_subnet.linksaver_subnet_public.id
  route_table_id = aws_route_table.linksaver_rt_public.id
}