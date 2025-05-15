resource "aws_instance" "web_app" {
  count = 2 # Number of instances to create
  ami           = var.ami
  instance_type = var.instance_type
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
  force_destroy = true

  tags = {
    Name        = "ExampleS3Bucket"
    Environment = "Dev"
  }
}

resource "aws_db_instance" "db_instance" {
    identifier = "example-db-instance"
    engine     = "mysql"
    instance_class = "db.t2.micro"
    allocated_storage = 20
    username   = var.db_username
    password   = var.db_password
    db_name    = var.db_name
    skip_final_snapshot = true
    publicly_accessible = true
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


resource "aws_security_group_rule" "allow_http_inbound" {
  description = "Allow HTTP inbound traffic"
  type        = "ingress"
  security_group_id = aws_security_group.instance.id
  from_port   = 8080
  to_port     = 8080
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}