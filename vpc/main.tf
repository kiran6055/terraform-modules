resource "aws_vpc" "timing" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  tags = merge(
    var.tags,
    var.vpc_tags
  )
}

resource "aws_subnet" "public" {
  count     = length(var.public_subnet_cidr)
  vpc_id     = aws_vpc.timing.id
  cidr_block = var.public_subnet_cidr[count.index]
  tags = merge(
    var.tags,
    var.public_subnet_tags,
    {"Name" = var.public_subnet_names[count.index]}
  )
  availability_zone = var.azs[count.index]
}

resource "aws_subnet" "private" {
#  for_each   = toset(local.azs)
  count      = length(var.private_subnet_cidr)
  vpc_id     = aws_vpc.timing.id
  cidr_block = var.private_subnet_cidr[count.index]
  tags = merge(
    var.tags,
    var.public_subnet_tags,
    {"Name" = var.private_subnet_names[count.index]}
  )
  availability_zone = var.azs[count.index]

} 



resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.timing.id
  tags = merge(
    var.tags,
    var.igw_tag
  )

}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.timing.id
  tags = merge(
    var.tags,
    {"Name" = var.PublicRT_tags}
  )

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}


resource "aws_route" "public" {
  route_table_id            = aws_route_table.public.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_internet_gateway.igw.id
}


resource "aws_route_table_association" "public" {
#  for_each       = toset(local.azs)
  count          = length(var.public_subnet_cidr)
  subnet_id      = aws_subnet.public[count.index].id
#  subnet_id = element(aws_subnet.public[*].id, count.index) we can use this also by using element function
  route_table_id = aws_route_table.public.id
  
}


resource "aws_route_table" "private" {
  vpc_id = aws_vpc.timing.id

  tags = merge(
    var.tags,
    {"Name" = var.PrivateRT_tags}
  )

}


resource "aws_route" "private" {
  route_table_id            = aws_route_table.private.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id            = aws_nat_gateway.main.id
}


resource "aws_route_table_association" "private" {
#  for_each       = toset(local.azs)
  count          = length(var.private_subnet_cidr)
#  subnet_id      = aws_subnet.private[count.index].id
  subnet_id = element(aws_subnet.private[*].id, count.index)
  route_table_id = aws_route_table.private.id
 
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


resource "aws_subnet" "database" {
 # for_each   = toset(local.azs)
  count      = length(var.database_subnet_cidr)
  vpc_id     = aws_vpc.timing.id
  cidr_block = var.database_subnet_cidr[count.index]
  availability_zone = var.azs[count.index]
  tags = merge(
    var.tags,
    var.public_subnet_tags,
    {"Name" = var.database_subnet_names[count.index]}
  )
}
 

resource "aws_route_table" "database" {
  vpc_id = aws_vpc.timing.id

  tags = merge(
    var.tags,
    {"Name" = var.databaseRT_tags}
  )

}


resource "aws_route" "database" {
  route_table_id            = aws_route_table.database.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id            = aws_nat_gateway.main.id
}

resource "aws_route_table_association" "database" {

  count          = length(var.database_subnet_cidr)
#  subnet_id      = aws_subnet.database[count.index].id
  subnet_id = element(aws_subnet.database[*].id, count.index)
  route_table_id = aws_route_table.database.id
}


resource "aws_db_subnet_group" "database" {
  name       = lookup(var.tags, "Name")
  subnet_ids = aws_subnet.database[*].id

  tags = merge(
    var.tags,
    var.database_subnet_group_tags
  )
}
