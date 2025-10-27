resource "aws_subnet" "cicd-subnet" {
  vpc_id            = aws_vpc.vpc_cicd.id
  cidr_block        = var.cicd-subnet-cidr_block
  availability_zone = var.availability_zone

  tags = {
    Name = "cicd subnets"
  }
}


resource "aws_instance" "cicd-host" {
  ami             = var.cicd-host-ami
  instance_type   = var.cicd-host-instance_type
  key_name        = var.cicd-host-key_name
  security_groups = [aws_security_group.cicd-sg.id]
  subnet_id       = aws_subnet.cicd-subnet.id
  user_data       = var.cicd-host-user_data
  tags = {
    Name = "cicd host"
  }
}

