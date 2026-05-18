resource "aws_vpc" "eks" {
 cidr_block = var.cidr_block
 enable_dns_hostnames = "true"
 instance_tenancy = "default"

 tags = merge(
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}-eks"
    }
 )
}

resource "aws_internet_gateway" "name" {
  vpc_id = aws_vpc.eks.id

   tags = merge(
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}-ig"
    }
 )

}

resource "aws_subnet" "public" {
  count = length(var.public_subnet)
  vpc_id = aws_vpc.eks.id
  availability_zone = local.available[count.index]
  cidr_block = var.public_subnet[count.index]
  map_public_ip_on_launch = true
  tags = merge(
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}-public_subnet"
    }
  )
}

resource "aws_subnet" "private" {
  count = length(var.private_subnet)
  vpc_id = aws_vpc.eks.id
  availability_zone = local.available[count.index]
  cidr_block = var.private_subnet[count.index]
  tags = merge(
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}-private_subnet"
    }
  )
}

resource "aws_eip" "name" {
  domain = "vpc"
  tags = merge(
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}-aws_eip"
    }
  )
}

resource "aws_nat_gateway" "name" {
  subnet_id = aws_subnet.public[0].id  
  allocation_id = aws_eip.name.id
  tags = merge(
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}-aws_eip"
    }
  )
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.eks.id
  tags = merge(
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}-public"
    }
  )
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.eks.id
  tags = merge(
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}-private"
    }
  )
}

resource "aws_route" "name" {
  route_table_id = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.name.id
}

resource "aws_route" "name" {
  route_table_id = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.name.id
}

resource "aws_route_table_association" "name" {
  count = length(var.public_subnet)
  route_table_id = aws_route_table.public.id
  subnet_id = aws_subnet.public[count.index].id 
}

resource "aws_route_table_association" "name" {
  count = length(var.private_subnet)
  route_table_id = aws_route_table.private.id
  subnet_id = aws_subnet.private[count.index].id 
}