
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


resource "aws_subnet" "bastion-host-subnet" {
  vpc_id                  = aws_vpc.vpc_cicd.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ca-central-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "bastion-host-subnet"
  }
}


resource "aws_subnet" "nat-gateway-subnet" {
  vpc_id                  = aws_vpc.vpc_cicd.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "ca-central-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "nat-gateway-subnet"
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

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.eip_nat_gateway.id
  subnet_id     = aws_subnet.nat-gateway-subnet.id

  tags = {
    "Name" = "Nat Gateway"
  }
}

resource "aws_security_group" "baston-host-security-group" {
  name        = "Public Baston Host Security Group"
  description = "Enable ssh to the Baston Host"
  vpc_id      = aws_vpc.vpc_cicd.id

  ingress {
    description = "ssh access"
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
    Name = "baston-host-security-group"
  }
}

resource "aws_eip" "eip_nat_gateway" {
  domain = "vpc"
  tags = {
    Name = "elastic ip nat gateway"
  }
}
resource "aws_instance" "bastion-host" {
  ami                         = "ami-0f39ffd6e446bf727"
  associate_public_ip_address = true
  instance_type               = "t2.micro"
  key_name                    = "cicdkey"
  security_groups             = [aws_security_group.baston-host-security-group.id]
  subnet_id                   = aws_subnet.bastion-host-subnet.id

  tags = {
    Name = "Bastion Host"
  }
}
