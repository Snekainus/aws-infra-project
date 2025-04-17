output "guardduty_detector_id"{
    value = aws_guardduty_detector.main.id
    description = "GuardDuty detector id"
}

output "securityhub_status"{
    value = aws_securityhub_account.main.id
    description = "SecurityHub is enabled"
}