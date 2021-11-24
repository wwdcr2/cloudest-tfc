### VPC 및 기본 네트워크 구성
#Create the VPC
resource "aws_vpc" "apr-vpc-01" {
  cidr_block = var.apr_vpc_01_cidr
  enable_dns_hostnames = false
  enable_dns_support = true
  tags = {
    Name = "vpc_a"
  }
}

#Define the subnet
resource "aws_subnet" "apr-subnet-private-vpc01-prd-a01" {
  vpc_id = aws_vpc.apr-vpc-01.id
  cidr_block = var.apr_subnet_private_vpc01_prd_a01
  availability_zone = var.apr_az_a
  tags = {
    Name = "apr-subnet-private-vpc01-prd-a01"
  }
}

#Define the internet gateway
resource "aws_internet_gateway" "apr-igw-vpc01" {
  vpc_id = aws_vpc.apr-vpc-01.id
  tags = {
    Name = "apr-igw-vpc01"
  }
}
##########################################################################################
# #Create route tables
resource "aws_route_table" "apr-rtb-public-vpc01-prd-a01" {
  vpc_id = aws_vpc.apr-vpc-01.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.apr-igw-vpc01.id
  }
  tags = {
    Name = "apr-rtb-public-vpc01-prd-a01"
  }
}

#########################################################################################
#Assign the public route table to the subnet
resource "aws_route_table_association" "apr-rtb-public-vpc01-prd-a01-attach"{
  subnet_id = aws_subnet.apr-subnet-private-vpc01-prd-a01.id
  route_table_id = aws_route_table.apr-rtb-public-vpc01-prd-a01.id
}
