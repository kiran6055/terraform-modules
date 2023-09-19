resource "aws_vpc" "main" {
  cidr_block       = local.cidr
  instance_tenancy = "default"
  tags = var.tags
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = local.public_cidr
  tags = var.publicsubnet_tags
}

resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.main.id
  cidr_block = local.private_cidr
  tags = var.privatesubnet_tags
}

resource "aws_subnet" "database" {
  vpc_id     = aws_vpc.main.id
  cidr_block = local.database_cidr
  tags = var.databasesubnet_tags
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = var.tags

}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  tags = var.PublicRT_tags

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}


resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

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


resource "aws_security_group" "web" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = output.vpc_id

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.main.cidr_block]
    ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}