locals {
  subnet_ids = toset(["subnet-0a1b2c3d4e5f6g7h8", "subnet-0h7g6f5e4d3c2b1a0"])
}

resource "aws_instance" "server" {
    for_each = local.subnet_ids
    ami           = "ami-0c55b159cbfafe1f0"
    instance_type = "t2.micro"
    subnet_id     = each.value
  
  tags = {
    Name = "Server-${each.key}"
  }
}

resource "aws_instance" "server_2" {
    ami           = "ami-0c55b159cbfafe1f0"
    instance_type = "t2.micro"
    
    lifecycle {
      create_before_destroy = true
      ignore_changes = [ 
        ami,
        instance_type
      ]
    }
  
}