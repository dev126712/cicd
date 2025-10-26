


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
  description = ".."
  vpc_id      = aws_vpc.vpc_cicd.id

  ingress {
    description     = "allows ssh "
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.baston-host-security-group.id]
  }

  ingress {
    description = "Allow all internal traffic within the EC2 instance"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 443
    to_port     = 443
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

resource "aws_instance" "cicd-host" {
  ami                         = "ami-0f39ffd6e446bf727"
  associate_public_ip_address = true
  instance_type               = "t2.large"
  key_name                    = "cicdkey"
  security_groups             = [aws_security_group.cicd-sg.id]
  subnet_id                   = aws_subnet.bastion-host-subnet.id

  tags = {
    Name = "cicd host"
  }
}
