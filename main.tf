
provider"aws"{
    region ="us-east-1"
}

module "networking"{
    source="./modules/networking"
    vpc_cidr ="10.0.0.0/16"
    public_subnet_cidrs=["10.0.1.0/24","10.0.2.0/24"]
    private_subnet_cidrs=["10.0.3.0/24","10.0.4.0/24"]
}

module "compute"{
    source="./modules/compute"
    vpc_id = module.networking.vpc_id
    public_subnet_ids = module.networking.public_subnet_ids
    ec2_ami_id= "ami-00a929b66ed6e0de6"
    instance_type="t2.micro"
    ec2_key_name = "terraform-key"
}
module "security"{
    source="./modules/security"
    region = "us-east-1"
}
module"monitoring"{
    source="./modules/monitoring"
    asg_name="ec2_asg"
    region="us-east-1"
    alert_email = "snekainus@gmail.com"
    log_retention=14
    config_role_arn="arn:aws:iam::846229150353:role/aws-service-role/config.amazonaws.com/AWSServiceRoleForConfig"

}
module "backup"{
    source="./modules/backup"
    backup_vault_name="infra_backup_vault"
    kms_key_arn="arn:aws:kms:us-east-1:846229150353:key/e3eebd26-3e68-4674-8445-c80ef55837b5"
    backup_role_arn="arn:aws:iam::846229150353:role/AWSBackupServiceRole"
}