variable "region" {
  type    = string
  default = "ca-central-1"
}

variable "availability_zone" {
  type    = string
  default = "ca-central-1a"
}

variable "vpc-cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "vpc_name" {
  type    = string
  default = "vpc_cicd"
}

variable "cicd-subnet-cidr_block" {
  type    = string
  default = "10.0.3.0/24"
}

## private subnets
variable "cicd-host-ami" {
  type    = string
  default = "ami-0f39ffd6e446bf727"
}

variable "cicd-host-instance_type" {
  type    = string
  default = "t2.large"
}

variable "cicd-host-key_name" {
  type    = string
  default = "cicdkey"
}

variable "cicd-host-user_data" {
  type    = string
  default = "infra.sh"
}

## public-subnets
variable "bastion-host-subnet-cidr_block" {
  type    = string
  default = "10.0.1.0/24"
}

variable "nat-gateway-subnet-cidr_block" {
  type    = string
  default = "10.0.2.0/24"
}

variable "bastion-host-ami" {
  type    = string
  default = "ami-0f39ffd6e446bf727"
}

variable "bastion-host-instance_type" {
  type    = string
  default = "t2.micro"
}

