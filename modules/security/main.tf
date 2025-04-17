
#Enforce MFA
resource "aws_iam_account_password_policy" "strict_policy" {
    minimum_password_length = 14
    require_lowercase_characters = true
    require_numbers = true
    require_symbols = true
    require_uppercase_characters = true
    allow_users_to_change_password = true
    hard_expiry = false
    max_password_age = 90
    password_reuse_prevention = 5  
}

#Enable SecurityHUb
resource "aws_securityhub_account" "main" { 
}

resource "aws_securityhub_standards_subscription" "cis" {
    standards_arn = "arn:aws:securityhub:${var.region}::standards/cis-aws-foundations-benchmark/v/1.4.0"
    depends_on = [ aws_securityhub_account.main ]
    }

#Enable GuardDuty
resource "aws_guardduty_detector" "main" {
    enable = true
  
}

#IAM policy for least privilege for EC2
resource "aws_iam_policy" "ec2_limited_policy" {
    name = "EC2limitedAccesspolicy"
    description = "Least privilege for ec2 operation"
    policy = jsonencode({
        Version= "2012-10-17"
        Statement=[
            {
            Effect="Allow"
            Action=[
                "ec2:DescribeInstances",
                "ec2:StartInstances",
                "ec2:StopInstances"
            ]
            Resource="*"
        }]

    }

    )
  
}