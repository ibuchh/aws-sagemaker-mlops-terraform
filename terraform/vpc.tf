# ---------------------------------------------------------------------------------------------------------------------
# VPC & NETWORK DETAILS
# ---------------------------------------------------------------------------------------------------------------------

data "aws_availability_zones" "available" {}

# ---------------------------------------------------------------------------------------------------------------------
# VPC
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "${var.stack}-vpc"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# PUBLIC SUBNETS
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_subnet" "public" {
  count                   = var.az_count
  cidr_block              = cidrsubnet(aws_vpc.main.cidr_block, 8, var.az_count + count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  vpc_id                  = aws_vpc.main.id
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.stack}-PublicSubnet-${count.index + 1}"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# INTERNET GATEWAY
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.stack}-igw"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# ROUTE FOR PUBLIC SUBNETS
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_route" "public-route" {
  route_table_id         = aws_vpc.main.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

