variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "ec2_ami_id" {
    description = "AMI id for the EC2 instance"
    #default = "ami-00a929b66ed6e0de6"
    type = string  
}

variable "instance_type" {
    description = "The EC2 instance type"
    #default = "t2.micro"
    type=string
  
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs for ALB"
  type        = list(string)
}

variable "ec2_key_name" {
  type        = string
  description = "Name of the key pair to use for EC2 instances"
}

