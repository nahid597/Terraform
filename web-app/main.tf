
terraform {
    # backend "s3" {
    #     bucket = "integration-s3-bucket"
    #     key = "integration-s3-bucket/terraform"
    #     region = "us-east-2"
    #     use_lockfile = true
    #     encrypt = true
    # }

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


data "aws_vpc" "default_vpc" {
  default = true
}

resource "aws_security_group" "instance" {
  name        = "web-app-sg"
  description = "Security group for web app"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "WebAppSecurityGroup"
  }
}
module "web_app" {
    source = "../modules/web-app"
    ami = var.ami
    instance_type = var.instance_type
    db_username = var.db_username
    db_password = var.db_password
}
