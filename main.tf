
##LOCAL VARIABLES AND DATA SOURCES##
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
data "aws_ssoadmin_instances" "test-sso-instance" {}

locals {
  account_id        = data.aws_caller_identity.current.account_id
  region            = var.region != "" ? var.region : data.aws_region.current.name
  sso_instance_arn  = tolist(data.aws_ssoadmin_instances.test-sso-instance.arns)[0]
  identity_store_id = tolist(data.aws_ssoadmin_instances.test-sso-instance.identity_store_ids)[0]
}

##CREATE THE PERMISSION SETS##
resource "aws_ssoadmin_permission_set" "uc2-test-premission" {
  name             = var.permission_set_name
  description      = var.permission_set_description
  instance_arn     = local.sso_instance_arn
  relay_state      = var.relay_state
  session_duration = var.session_duration
  tags             = var.tags
}

##ATTACH INLINE POLICIES##
resource "aws_ssoadmin_permission_set_inline_policy" "inline-policy" {
  for_each = var.inline_policy
  inline_policy      = templatefile(each.value.inline_policy_json, { ACCOUNT_ID_INTERPOLATE_NAME = local.account_id, REGION_INTERPOLATE = local.region, })
  instance_arn       = local.sso_instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.uc2-test-premission.arn
}

##ATTACH MANAGED POLICIES##
resource "aws_ssoadmin_managed_policy_attachment" "managed-policy" {
  for_each           = { for arns in var.managed_policy_arns : arns => arns }
  instance_arn       = local.sso_instance_arn
  managed_policy_arn = each.key
  permission_set_arn = aws_ssoadmin_permission_set.uc2-test-premission.arn
}


