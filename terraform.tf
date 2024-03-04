provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

terraform {
  backend "s3" {
    bucket  = "greenup-tf"
    key     = "greenup.tfstate"
    region  = "us-east-1"
    encrypt = true
    profile = "default"
  }
}
