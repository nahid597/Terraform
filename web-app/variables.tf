variable "ami" {
    description = "AMI ID for the EC2 instance"
    type        = string 
    default = "ami-0c55b159cbfafe1f0"
}

variable "instance_type" {
  description = "Type of EC2 instance"
  type        = string
  default     = "t2.micro"
  
}   

variable "db_username" {
  description = "Username for the database"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "Password for the database"
  type        = string
  default     = "password"
  sensitive = true
}