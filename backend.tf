terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  // Uncomment for remote state management

  backend "s3" {
    bucket       = "terraform-state-bucket-6785"
    key          = "keyfolder/terraform.tfstate"
    region       = "ap-south-1"
    use_lockfile = "terraform-lock"
    encrypt      = true
  }
}
