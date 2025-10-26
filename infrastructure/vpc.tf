terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}



provider "aws" {
  region = "ca-central-1"

}


resource "aws_vpc" "vpc_cicd" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "cicd"
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_cicd.id

  tags = {
    Name = "VPC project IGW"
  }
}
