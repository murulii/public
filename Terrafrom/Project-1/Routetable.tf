resource "aws_route_table" "proroutetable" {
  vpc_id = aws_vpc.provpc.id



tags = {
  Name = "ProRoute"
}
}

resource "aws_route" "myroute" {
    route_table_id = aws_route_table.proroutetable.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  
}

resource "aws_route_table_association" "proassocation" {
  subnet_id = aws_subnet.prosubnet.id
  route_table_id = aws_route_table.proroutetable.id
}

