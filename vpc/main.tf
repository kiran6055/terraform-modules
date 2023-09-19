resource "aws_vpc" "main" {
  cidr_block       = local.cidr
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}