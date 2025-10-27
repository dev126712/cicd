resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.eip_nat_gateway.id
  subnet_id     = aws_subnet.nat-gateway-subnet.id

  tags = {
    "Name" = "Nat Gateway"
  }
}


resource "aws_eip" "eip_nat_gateway" {
  domain = "vpc"
  tags = {
    Name = "elastic ip nat gateway"
  }
}

