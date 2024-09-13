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
    bucket = "terraform-state-storage20240104230827817100000001"
    region = "eu-central-1"
    key    = "landingzone/terraform.tfstate"
    dynamodb_table = "terraform-state-storage"
    encrypt        = true
    kms_key_id     = "alias/terraform-state-storage"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-central-1"
  assume_role {
    role_arn = "arn:aws:iam::268702346055:role/RoleForAutomationPipeline"
  }
  #alias  = "management-account-role"
}