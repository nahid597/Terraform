output "db_instance_address" {
  value = aws_db_instance.db_instance.address
  description = "The address of the database instance"
}