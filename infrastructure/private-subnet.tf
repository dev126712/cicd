resource "aws_subnet" "cicd-subnet" {
  vpc_id            = aws_vpc.vpc_cicd.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "ca-central-1a"

  tags = {
    Name = "cicd subnets"
  }
}

resource "aws_security_group" "cicd-sg" {
  name        = "CI/CD-SG"
  description = "Allow inbound traffic from public ALB"
  vpc_id      = aws_vpc.vpc_cicd.id

  ingress {
    description = "allows ssh "
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "CI/CD-SG"
  }
}

resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.vpc_cicd.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gateway-subnet.id
  }

  tags = {
    Name = "Private Route Table"
  }
}

resource "aws_route_table_association" "private-web-subnet-1-route-table-association" {
  subnet_id      = [for subnet in aws_subnet.private-web-subnet : subnet.id]
  route_table_id = aws_route_table.public-route-table.id
}



resource "aws_route_table_association" "private-app-subnet-1-route-table-association" {
  subnet_id      = [for subnet in aws_subnet.private-app-subnet : subnet.id]
  route_table_id = aws_route_table.public-route-table.id
}
