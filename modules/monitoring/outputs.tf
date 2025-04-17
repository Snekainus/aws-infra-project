
output"sns_topic_arn"{
    value=aws_sns_topic.alerts.arn
    description = "ARN for the SNS topic for Alerts"
}

output"dashboard_name"{
    value=aws_cloudwatch_dashboard.main.dashboard_name
    description = "Cloudwatch dashboard name"
}