resource "aws_vpc" "Group1VPC" {                # Creating VPC here
   cidr_block       = var.vpc_cidr     # Defining the CIDR block use 10.0.0.0/24 for demo
   instance_tenancy = "default"
   tags = {
      Name = "Group1VPC"
   }
}

resource "aws_internet_gateway" "Group1IGW" {    # Creating Internet Gateway
    vpc_id =  aws_vpc.Group1VPC.id               # vpc_id will be generated after we create VPC
    tags = {
      Name = "Group1IGW"
   }
}


resource "aws_subnet" "Group1publicsubnets1" {    # Creating Public Subnets
   vpc_id =  aws_vpc.Group1VPC.id
   cidr_block = "${var.public_subnets1}"        # CIDR block of public subnets
   tags = {
      Name = "Group1publicsubnets1"
   }
}

resource "aws_subnet" "Group1publicsubnets2" {    # Creating Public Subnets
   vpc_id =  aws_vpc.Group1VPC.id
   cidr_block = "${var.public_subnets2}"        # CIDR block of public subnets
   tags = {
      Name = "Group1publicsubnets2"
   }
}

resource "aws_route_table" "Group1PublicRT" {    # Creating RT for Public Subnet
    vpc_id =  aws_vpc.Group1VPC.id
    route {
    cidr_block = "0.0.0.0/0"               # Traffic from Public Subnet reaches Internet via Internet Gateway
    gateway_id = aws_internet_gateway.Group1IGW.id
    }
    tags = {
      Name = "Group1PublicRT"
   }
    
}

resource "aws_route_table_association" "Group1PublicRTassociation1" {
    subnet_id = aws_subnet.Group1publicsubnets1.id
    route_table_id = aws_route_table.Group1PublicRT.id
}

resource "aws_route_table_association" "Group1PublicRTassociation2" {
    subnet_id = aws_subnet.Group1publicsubnets2.id
    route_table_id = aws_route_table.Group1PublicRT.id
}

