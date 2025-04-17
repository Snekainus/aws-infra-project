#Backup Vault
resource "aws_backup_vault" "main" {
    name=var.backup_vault_name  
    kms_key_arn = var.kms_key_arn
} 

resource "aws_backup_plan" "main" {
    name="infra_backup_plan"
    rule {
        rule_name="daily_backup"
        target_vault_name=aws_backup_vault.main.name
        schedule="cron(0 5 * * ? *)"
        start_window=60
        completion_window=180
        lifecycle{
            delete_after=30
        }
    }
  
}

resource "aws_backup_selection" "ec2_selection" {
    iam_role_arn = var.backup_role_arn
    name = "ec2_backup_selection"
    plan_id = aws_backup_plan.main.id

    selection_tag {
      type = "STRINGEQUALS"
      key="backup"
      value="true"
    }
  
}
