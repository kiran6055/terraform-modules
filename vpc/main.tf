resource "aws_vpc" "roboshop" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  tags = var.tags
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.roboshop.id
  cidr_block = var.public_cidr
  tags = var.publicsubnet_tags
}

resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.roboshop.id
  cidr_block = var.private_cidr
  tags = var.privatesubnet_tags
}

resource "aws_subnet" "database" {
  vpc_id     = aws_vpc.roboshop.id
  cidr_block = var.database_cidr
  tags = var.databasesubnet_tags
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
  subnet_id     = aws_subnet.public.id
  depends_on = [aws_internet_gateway.igw]
  tags = var.tags
}



resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
  
}


resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
 
}

resource "aws_route_table_association" "database" {
  subnet_id      = aws_subnet.database.id
  route_table_id = aws_route_table.private.id
}


