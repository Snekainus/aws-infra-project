
#create EC2 security group
resource "aws_security_group" "ec2_sg" {
    name="ec2_sg"
    vpc_id = var.vpc_id
    description = "Allow HTTP traffic for EC2 instances"

    ingress {
        from_port=80
        to_port=80
        protocol="tcp"
        cidr_blocks=["0.0.0.0/0"]
    }

        ingress {
        from_port=22
        to_port=22
        protocol="tcp"
        cidr_blocks=["73.150.144.159/32"]
    }

    egress{
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]

    }
  
}

#create ALB
resource "aws_alb" "app_alb" {
    name="app-alb"
    internal = false
    load_balancer_type = "application"
    security_groups = [aws_security_group.ec2_sg.id]
    subnets= var.public_subnet_ids
    enable_deletion_protection = false
    enable_cross_zone_load_balancing = true
    idle_timeout = 60
    tags={
        name="AppLoadBalancer"
    }
  
}

#create target group for EC2 instances
resource "aws_alb_target_group" "target_group" {
    name="app-target-group"
    port=80
    protocol = "HTTP"
    vpc_id = var.vpc_id

    health_check {
      path="/"
      port = "traffic-port"
      protocol = "HTTP"
      interval = 30
      timeout=5
      healthy_threshold = 2
      unhealthy_threshold = 2
    }
}

#create listener for the load balancer
resource "aws_alb_listener" "http_listener" {
    load_balancer_arn = aws_alb.app_alb.arn
    port=80
    protocol = "HTTP"

    default_action {
      type="forward"
      target_group_arn = aws_alb_target_group.target_group.arn      
    }
} 


#Launch Configuration for EC2 instance
resource "aws_launch_template" "ec2_launch_template" {
    name_prefix="ec2-launch-template"
    image_id = var.ec2_ami_id
    instance_type = var.instance_type
    key_name = var.ec2_key_name
    user_data = base64encode(<<-EOF
                #!/bin/bash
                yum install -y httpd
                service httpd start
                systemctl start httpd
                systemctl enable httpd

                # Add a simple index.html
                echo "<h1>Welcome from $(hostname). I love you Amma - Mithran & Dinesh</h1>" > /var/www/html/index.html
                EOF  
    )
    network_interfaces {
      associate_public_ip_address = true
      security_groups = [aws_security_group.ec2_sg.id]

    }
    tag_specifications {
      resource_type = "instance"
    
    tags = {
        Name="EC2Instance"
    }
}
}

#Auto Scaling Group based on load scaling policy
resource "aws_autoscaling_group" "ec2_asg" {
    desired_capacity = 2
    max_size = 5
    min_size = 1
    vpc_zone_identifier = var.public_subnet_ids
    launch_template{
        id= aws_launch_template.ec2_launch_template.id
        version = "$Latest"
        }
    instance_refresh {
      strategy = "Rolling"
      preferences {
        min_healthy_percentage = 90
        instance_warmup = 300
      }
    }
    health_check_type = "EC2"
    health_check_grace_period = 300
    target_group_arns = [ aws_alb_target_group.target_group.arn ]

   tag {
    key="Name"
    value="EC2instance"
    propagate_at_launch = true
   }
}

#Attach Alb to Asg
#resource "aws_alb_target_group_attachment" "asg_attachment" {
#     target_group_arn = aws_alb_target_group.target_group.arn
#     target_id = aws_instance.example.id
#     port=80  
# }

#output the loadbalancer DNS name
# output "load_balancer_dns_name" {
#     value = aws_alb.app_alb.dns_name  
# }
