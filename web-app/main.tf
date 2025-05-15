
terraform {
    backend "s3" {
        bucket = "integration-s3-bucket"
        key = "integration-s3-bucket/terraform"
        region = "us-east-2"
        use_lockfile = true
        encrypt = true
    }

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

resource "aws_instance" "web_app" {
  count = 2 # Number of instances to create
  ami           = var.ami
  instance_type = var.instance_type
  security_groups = [aws_security_group.instance.name]
  user_data = <<-EOF
            #!/bin/bash
            echo "Hello, World" > index.html
            python3 -m http.server 8080 &
            EOF

  tags = {
    Name = "Server ${count.index + 1}"
  }
}

resource "aws_s3_bucket" "bucket" {
  bucket = "integration-s3-bucket"
  acl    = "private"
  force_destroy = true
  versioning {
    enabled = true
  }

  tags = {
    Name        = "ExampleS3Bucket"
    Environment = "Dev"
  }
}

data "aws_vpc" "default_vpc" {
  default = true
}

resource "aws_security_group_rule" "allow_http_inbound" {
  description = "Allow HTTP inbound traffic"
  type        = "ingress"
  security_group_id = aws_security_group.instance.id
  from_port   = 8080
  to_port     = 8080
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_db_instance" "db_instance" {
    identifier = "example-db-instance"
    engine     = "mysql"
    instance_class = "db.t2.micro"
    allocated_storage = 20
    username   = var.db_username
    password   = var.db_password
    db_name    = "exampledb"
    skip_final_snapshot = true
    publicly_accessible = true
}