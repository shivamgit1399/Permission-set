terraform {
  ### Minimum terraform version required for planning and applying the resources
  required_version = "1.5.3"
  required_providers {
    ### Minimum Hashicorp/AWS Provider version
    aws = {
      source  = "hashicorp/aws"
      version = "5.8.0"
    }
  }
}
