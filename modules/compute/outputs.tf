output "load_balancer_dns_name" {
    description = "DNS name of the load balancer"
    value = aws_alb.app_alb.dns_name  
}

output "asg_name" {
    description = "Name of the Auto Scaling Group"
    value = aws_autoscaling_group.ec2_asg.name
  
}