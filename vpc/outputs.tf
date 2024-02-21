#output "vpc_id" {
#  value = aws_vpc.timing.id
#}

#output "db_subnet_group_name" {
#  value = aws_db_subnet_group.database.name
#}


output "public_subnet_ids" {
 value = aws_subnet.public[*].id

}

output "private_subnet_ids" {
 value = aws_subnet.private[*].id

}

