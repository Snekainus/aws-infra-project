variable "asg_name" {
    description = "Auto Scaling group Name to monitor"
    type = string
  
}

variable "region" {
    description = "AWS region"
    type= string
  
}

variable "alert_email" {
    description = "Email address for the SNS alert"
    type=string
  
}

variable "log_retention" {
    description = "Retention period for logs"
    type = number
    default = 14
  
}
variable "config_role_arn" {
    description = "IAM role ARN for AWS Config"
    type = string
  
}
