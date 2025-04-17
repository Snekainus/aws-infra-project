#Create VPC
resource "aws_vpc" "main_vpc" {
    cidr_block= var.vpc_cidr
    enable_dns_support = true
    enable_dns_hostnames = true
    tags={
        name="main_vpc"
    }
  
}

#public subnets
resource "aws_subnet""public_subnet_1"{
    vpc_id = aws_vpc.main_vpc.id
    cidr_block = var.public_subnet_cidrs[0]
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true
    tags={
        name="public_subnet_1"
    }

}

resource"aws_subnet""public_subnet_2"{
    vpc_id = aws_vpc.main_vpc.id
    cidr_block = var.public_subnet_cidrs[1]
    availability_zone = "us-east-1b"
    map_public_ip_on_launch = true
    tags={
        name="public_subnet_2"
    }
}

#private subnets
resource"aws_subnet""private_subnet_1"{
    vpc_id = aws_vpc.main_vpc.id
    cidr_block = var.private_subnet_cidrs[0]
    availability_zone = "us-east-1a"
    tags = {
      name="private_subnet_1"
    }
}

resource"aws_subnet""private_subnet_2"{
    vpc_id=aws_vpc.main_vpc.id
    cidr_block = var.private_subnet_cidrs[1]
    availability_zone = "us-east-1b"
    tags = {
      name="private_subnet_2"
    }
}

#create internet gateway(public subnets)
resource "aws_internet_gateway" "internet_gateway" {
    vpc_id = aws_vpc.main_vpc.id
    tags={
        name="internet_gateway"
    }
  
}

#create NAT gateway(private subnets)
resource "aws_eip" "nat_eip" {
    domain = "vpc"
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet_1.id
  tags = {
    Name = "nat-gateway"
  }
}

#create route table(public subnets)
resource "aws_route_table""public_route_table"{
    vpc_id = aws_vpc.main_vpc.id
}

resource"aws_route""public_internet_route"{
    route_table_id = aws_route_table.public_route_table.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id

}

resource"aws_route_table_association""public_subnet_1_association"{
    subnet_id = aws_subnet.public_subnet_1.id
    route_table_id = aws_route_table.public_route_table.id
}

resource"aws_route_table_association""public_subnet_2_association"{
    subnet_id = aws_subnet.public_subnet_2.id
    route_table_id = aws_route_table.public_route_table.id
}

#create route table(private subnets)
resource "aws_route_table""private_route_table"{
    vpc_id = aws_vpc.main_vpc.id
}
resource "aws_route" "private_nat_route" {
    route_table_id = aws_route_table.private_route_table.id
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  
}
resource"aws_route_table_association""private_subnet_1_association"{
    subnet_id = aws_subnet.private_subnet_1.id
    route_table_id = aws_route_table.private_route_table.id
}
resource"aws_route_table_association""private_subnet_2_association"{
    subnet_id = aws_subnet.private_subnet_2.id
    route_table_id = aws_route_table.private_route_table.id
}

#create security group for EC2
resource "aws_security_group" "ec2_sg" {
    vpc_id = aws_vpc.main_vpc.id
    name="ec2-sg"
    description = "allow inbound HTTP and SSH Traffic"

    ingress{
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    egress{
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
  
}