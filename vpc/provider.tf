terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.17.0"
    }
  }

  backend "s3" {
    bucket = "terraform6055"
    key    = "terraform"
    region = "ap-south-1"
    dynamodb_table = "terraform-lock"
  }
}

provider "aws" {
  # Configuration options
  region = "ap-south-1"
}