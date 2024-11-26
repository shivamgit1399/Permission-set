
variable "region" {
  description = "Region to deploy AWS resources"
  type        = string
  default     = ""
}
variable "permission_set_name" {
  type    = string
  default = ""
}
variable "permission_set_description" {
  type    = string
  default = ""
}
variable "relay_state" {
  type    = string
  default = null
}
variable "session_duration" {
  type    = string
  default = "PT12H"
}

variable "managed_policy_arns" {
  description = "AWS Managed Policy ARNs"
  type        = list(string)
  default     = []
}

variable "inline_policy" {
  type = map(object({
    inline_policy_json = string
  }))
}

variable "tags" {
  type        = map(string)
  description = "Tags to ec2 resources Required for every resources"
  default = {
    BU          = ""
    CostCode    = ""
    Owner       = ""
    Project     = ""
    Environment = ""
    createdby   = ""
    Backup      = ""
  }
}