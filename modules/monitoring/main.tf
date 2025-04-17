#Cloudwatch Log groups
resource "aws_cloudwatch_log_group" "ec2_logs" {
    name="/aws/ec2/app"
    retention_in_days = var.log_retention
  
}

#cloudwatch Alarms- EC2 CPU Usage
resource "aws_cloudwatch_metric_alarm" "ec2_cpu_high" {
    alarm_name = "HighEC2CPU"
    comparison_operator = "GreaterThanThreshold"
    evaluation_periods = 2
    metric_name = "CPUutilization"
    namespace = "AWS/EC2"
    period = 120
    statistic = "Average"
    threshold = 75
    alarm_description = "CPU utilization exceed 75% for EC2"
    dimensions = {
        AutoScalingGroupName=var.asg_name
    }
    alarm_actions = [aws_sns_topic.alerts.arn]
  
}

#Cloudwatch Dashboard
resource "aws_cloudwatch_dashboard" "main" {
    dashboard_name = "InfraMonitoring"
   dashboard_body = jsonencode({
    widgets=[
        {
            type="metric",
            x=0,
            y=0,
            width=12,
            height=6,
            properties={
                metrics=[
                    ["AWS/EC2","CPUUtilization","AutoScalingGroupName",var.asg_name]
                ],
                period=300,
                stat="Average",
                region=var.region,
                title="EC2 CPU Utilization"
            }

        }
    ]
   })
}

#AWS Config
resource "aws_config_configuration_recorder" "main" {
    name="default"
    role_arn = var.config_role_arn
  
}

resource "aws_config_configuration_recorder_status" "main" {
    name=aws_config_configuration_recorder.main.name
    is_enabled = true
  
}

#SNS for alerting
resource "aws_sns_topic" "alerts" {
    name="cloudwatch_alerts"
  
}

resource "aws_sns_topic_subscription" "email" {
    topic_arn = aws_sns_topic.alerts.arn
    protocol="email"
    endpoint=var.alert_email  
}