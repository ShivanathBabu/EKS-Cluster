resource "aws_vpc_peering_connection" "foo" {
  count = var.is_peering_required ? 1:0
  peer_vpc_id   = data.aws_vpc.default_vpc.id
  vpc_id        = aws_vpc.eks.id

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }

  
}

resource "aws_route" "public_peering" {
  count = var.is_peering_required ? 1:0
  route_table_id = aws_route_table.public.id
  destination_cidr_block = data.aws_vpc.default_vpc.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.foo[count.index].id 
}

resource "aws_route" "private_peering" {
  count = var.is_peering_required ? 1:0
  route_table_id = aws_route_table.private.id
  destination_cidr_block = data.aws_vpc.default_vpc.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.foo[count.index].id 
}

resource "aws_route" "default_peering" {
  count = var.is_peering_required ? 1:0
  route_table_id = data.aws_route_table.default.id
  destination_cidr_block = var.cidr_block
}