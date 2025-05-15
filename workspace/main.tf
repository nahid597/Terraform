terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "~> 4.0"
        }
    }
}
provider "aws" {
    region = "us-east-2"
}

locals {
  environment_name = terraform.workspace
}

module "web_app" {
    source = "../modules/web-app"
    ami = var.ami
    instance_type = var.instance_type
    db_username = var.db_username
    db_password = var.db_password
    db_name = "exampledb-${local.environment_name}"

}