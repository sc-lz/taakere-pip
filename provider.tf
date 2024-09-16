################################################################################
# Set required providers and version
################################################################################
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  
  backend "s3" {
    bucket = "terraform-state-storage120240913135406692500000001"
    region = "eu-central-1"
    key    = "landingzone/terraform.tfstate"
    dynamodb_table = "terraform-state-storage1"
    encrypt        = true
    kms_key_id     = "alias/terraform-state-storage1"
    profile = "Automation-Account"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-central-1"
  profile = "Automation-Account"
  assume_role {
    role_arn = "arn:aws:iam::268702346055:role/RoleForAutomationPipeline"
  }
  #alias  = "management-account-role"
}