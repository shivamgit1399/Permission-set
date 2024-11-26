provider "aws" {
  region = "us-east-1"
}

module "permission_sets" {
  source = "../"

  #Attach AWS Managed Policies to IAM Role
  managed_policy_arns = ["arn:aws:iam::aws:policy/AdministratorAccess", "arn:aws:iam::aws:policy/CloudWatchFullAccess", ]

  inline_policy = {
    "Inline_Policy1" = {
      inline_policy_json = "../uc2.0-inline-policy/ps-uc2-cim-l2.json"
    }
  }
  permission_set_name        = "ps-uc2-cim-l2-test"
  permission_set_description = "CIM Team admin access"

  tags = {
    BU          = "GT"
    CostCode    = "H3HFCE"
    Owner       = "XXXXXXXX"
    Project     = "UC2.0"
    Environment = "Test"
    createdby   = "Git-Terraform"
    Backup      = "N"
  }
}

output "permission_sets" {
  description = "EC2 Instance outputs"
  value       = module.permission_sets.permission_sets
}


