resource "aws_vpc" "roboshop" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  tags = var.tags
}

resource "aws_subnet" "public" {
#  for_each = toset(local.azs)
  count     = length(local.azs)
  vpc_id     = aws_vpc.roboshop.id
  cidr_block = var.public_cidr[count.index]
  tags = "${var.publicsubnet_tags}"
  availability_zone = local.azs[count.index]
}

resource "aws_subnet" "private" {
#  for_each   = toset(local.azs)
  count      = length(local.azs)
  vpc_id     = aws_vpc.roboshop.id
  cidr_block = var.private_cidr[count.index]
  tags = "${var.privatesubnet_tags}"
  availability_zone = local.azs[count.index]

}

resource "aws_subnet" "database" {
 # for_each   = toset(local.azs)
  count      = length(local.azs)
  vpc_id     = aws_vpc.roboshop.id
  cidr_block = var.database_cidr[count.index]
  tags = "${var.databasesubnet_tags}"
  availability_zone = local.azs[count.index]
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.roboshop.id
  tags = var.tags

}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.roboshop.id
  tags = var.PublicRT_tags

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}


resource "aws_route_table" "private" {
  vpc_id = aws_vpc.roboshop.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }
  tags = var.PrivateRT_tags

}


resource "aws_eip" "eip" {
  domain   = "vpc"
  tags = var.tags
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public[0].id
  depends_on = [aws_internet_gateway.igw]
  tags = var.tags
}



resource "aws_route_table_association" "public" {
#  for_each       = toset(local.azs)
  count          = length(local.azs)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
  
}


resource "aws_route_table_association" "private" {
#  for_each       = toset(local.azs)
  count          = length(local.azs)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
 
}

resource "aws_route_table_association" "database" {
#  for_each       = toset(local.azs)
  count          = length(local.azs)
  subnet_id      = aws_subnet.database[count.index].id
  route_table_id = aws_route_table.private.id
}


