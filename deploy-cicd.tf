terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "cicd-server" {
  ami                         = "ami-0bb7d855677353076"
  associate_public_ip_address = true
  instance_type               = "t2.large"
  key_name                    = "testk"
  vpc_security_group_ids      = [aws_security_group.web_access.id]
  user_data                   = file("setup.sh")
  tags = {
    Name    = "cicd"
    Project = "CloudProject"
  }
}


resource "aws_security_group" "web_access" {
  vpc_id = "" # Replace with your VPC ID if not using default

  ingress {
    description = "Allow SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow"
    from_port   = 8000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # -1 means "all protocols"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "WebAccessSG"
  }
}

output "ec2_public_ip" {
  value       = aws_instance.cicd-server.public_ip
  description = "The public IP address of the main application server."
}
