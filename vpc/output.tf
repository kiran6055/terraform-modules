output "vpc_id" {
  value = aws_vpc.timing.id
}

output "db_subnet_group_name" {
  value = aws_db_subnet_group.database.name
}
