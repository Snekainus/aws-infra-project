variable"vpc_cidr"{
    description = "CIDR block for VPC"
    type=string
    default="10.0.0.0/16"
}

variable "public_subnet_cidrs"{
    description = "CIDR block for public subnets"
    type=list(string)
    default=["10.0.1.0/24","10.0.2.0/24"]
}

variable "private_subnet_cidrs"{
    description = "CIDR block for private subnets"
    type=list(string)
    default = [ "10.0.3.0/24","10.0.4.0/24" ]
}