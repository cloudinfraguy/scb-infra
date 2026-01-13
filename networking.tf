/* VPC */
resource "aws_vpc" "main" {
  cidr_block           = local.config.vpc_cidr
  enable_dns_hostnames = true
}

/* Internet Gateway for public traffic */
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}

/* Public Subnet */
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = local.config.public_subnet_cidr
  map_public_ip_on_launch = true
  availability_zone       = "${var.region}${local.config.availability_zone}"
}

/* Private Subnet */
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = local.config.private_subnet_cidr
  availability_zone       = "${var.region}${local.config.availability_zone}"
}

/* Public route table */
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

/* Associate public subnet with its route table */
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

/* NAT Gateway for private subnet internet access */
resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public.id
}

/* Private route table */
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
}

/* Associate private subnet with its route table */
resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}
