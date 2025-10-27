resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.vpc_cicd.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}


resource "aws_route_table_association" "public-nat-gateway-route-table-association" {
  subnet_id      = aws_subnet.nat-gateway-subnet.id
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "public-bastion-host-route-table-association" {
  subnet_id      = aws_subnet.bastion-host-subnet.id
  route_table_id = aws_route_table.public-route-table.id
}




resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.vpc_cicd.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name = "Private Route Table"
  }
}

resource "aws_route_table_association" "cicd-host--route-table-association" {
  subnet_id      = aws_subnet.cicd-subnet.id
  route_table_id = aws_route_table.private-route-table.id
}
