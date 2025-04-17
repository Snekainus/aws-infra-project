output "vpc_id" {
    description = "VPC_id"
    value=module.networking.vpc_id  
}

output"load_balancer_dns_name"{
    description = "DNS name of the load balancer"
    value=module.compute.load_balancer_dns_name
}

output"guardduty_detector_id"{
    description = "ID of the guard detector"
    value=module.security.guardduty_detector_id
}

output "securityhub_status"{
    description = "SecurityHub is enabled"
    value = module.security.securityhub_status
    
}

output"sns_topic_arn"{
    value=module.monitoring.sns_topic_arn
    description = "ARN for the SNS topic for Alerts"
}

output"dashboard_name"{
    value=module.monitoring.dashboard_name
    description = "Cloudwatch dashboard name"
}
output "backup_vault_name" {
    value = module.backup.backup_vault_name
    description = "Backup Vault name"
  
}