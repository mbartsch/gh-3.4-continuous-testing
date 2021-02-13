#terraform {
#  backend "s3" {
#    bucket         = "bootcampdevops-terraform"
#    key            = "repositories/terraform.tfstate"
#    region         = "eu-west-1"
#  }
#}
provider "aws" {
  region = "eu-west-1"
}
