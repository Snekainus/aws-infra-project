#Project name
variable "project_name" {
    type=string
    description = "Name of the project"
    default= "aws-infra-project"
  
}

#AWS region
# variable "aws_region" {
#     type=string
#     description = "Name of the region"
#     default= "us-east-1"
  
# }

#VPC Configuration
# variable "vpc_cidr" {
#     type=string
#     description = "VPC CIDR Block"
#     default= "10.0.0.0/16"
  
# }

# variable "public_subnet_cidrs" {
#     description = "CIDR block of public subnets"
#     type=list(string)
#     default= ["10.0.1.0/24","10.0.2.0/24"]
  
# }

# variable "private_subnet_cidrs" {
#     description = "CIDR block of private subnets"
#     type=list(string)
#     default= ["10.0.3.0/24","10.0.4.0/24"]
  
# }

#EC2 Instance configuration
# variable "Instance_type" {
#     description = "EC2 instance type"
#     type=string
#     default= "t2.micro"
  
# }
# variable "key_pair_name" {
#     description = "EC2 key pair name"
#     type=string
    
# }
#kms and IAM
# variable "kms_key_arn" {
#     description = "ARN of the KMS key used for encryption"
#     type=string  
# }
# variable "backup_role_arn" {
#     description = "IAM role ARN for AWS backup"
#     type=string
  
# }
#TAgs
variable "tags"{
    description = "Common tags for all resources"
    type=map(string)
    default = {
      "Environment" = "Dev"
      Project="aws-infra-project"
    }

}

