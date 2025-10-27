resource "aws_subnet" "bastion-host-subnet" {
  vpc_id                  = aws_vpc.vpc_cicd.id
  cidr_block              = var.bastion-host-subnet-cidr_block
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true
  tags = {
    Name = "bastion-host-subnet"
  }
}


resource "aws_subnet" "nat-gateway-subnet" {
  vpc_id                  = aws_vpc.vpc_cicd.id
  cidr_block              = var.nat-gateway-subnet-cidr_block
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true
  tags = {
    Name = "nat-gateway-subnet"
  }
}

resource "aws_instance" "bastion-host" {
  ami                         = var.bastion-host-ami
  associate_public_ip_address = true
  instance_type               = var.bastion-host-instance_type
  key_name                    = var.cicd-host-key_name
  security_groups             = [aws_security_group.baston-host-security-group.id]
  subnet_id                   = aws_subnet.bastion-host-subnet.id

  tags = {
    Name = "Bastion Host"
  }
}

