**About This Module**
============================
This module is developed to automate premission sets creation in SSO - IAM Identity Center
Permission sets in master core account and attach AWS Managed Policies and the Inline Policies - Allow OR Deny.


---
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.8.0 |
---
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_inline_policy"></a> [inline\_policy](#input\_inline\_policy) | n/a | <pre>map(object({<br>    inline_policy_json = string<br>  }))</pre> | n/a | yes |
| <a name="input_managed_policy_arns"></a> [managed\_policy\_arns](#input\_managed\_policy\_arns) | AWS Managed Policy ARNs | `list(string)` | `[]` | no |
| <a name="input_permission_set_description"></a> [permission\_set\_description](#input\_permission\_set\_description) | n/a | `string` | `""` | no |
| <a name="input_permission_set_name"></a> [permission\_set\_name](#input\_permission\_set\_name) | n/a | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | Region to deploy AWS resources | `string` | `""` | no |
| <a name="input_relay_state"></a> [relay\_state](#input\_relay\_state) | n/a | `string` | `null` | no |
| <a name="input_session_duration"></a> [session\_duration](#input\_session\_duration) | n/a | `string` | `"PT12H"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to ec2 resources Required for every resources | `map(string)` | <pre>{<br>  "BU": "",<br>  "Backup": "",<br>  "CostCode": "",<br>  "Environment": "",<br>  "Owner": "",<br>  "Project": "",<br>  "createdby": ""<br>}</pre> | no |
---
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_permission_sets"></a> [permission\_sets](#output\_permission\_sets) | n/a |
---
## Examples
```hcl
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


```
