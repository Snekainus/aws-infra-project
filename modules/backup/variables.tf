variable "backup_vault_name" {
    type=string
    description = "AWS Backup Vault name"
    #default="infra_backup_vault"
  }

  variable "kms_key_arn" {
    type = string
    description = "KMS key arn for backup encryption"
    #default = "arn:aws:kms:us-east-1:846229150353:key/e3eebd26-3e68-4674-8445-c80ef55837b5"
  }

  variable "backup_role_arn" {
    type=string
    description = "IAM role ARN for backup"
   #default = "arn:aws:iam::846229150353:role/AWSBackupServiceRole"
    
  }