#!/bin/bash

sudo yum update -y
sudo yum install -y docker git
sudo service docker start
sudo usermod -a -G docker ec2-user

mkdir -p /home/ec2-user/app
cd /home/ec2-user/app
git clone https://github.com/dev126712/cicd.git
cd cicd
rm .env
rm .gitignore
rm deploy-cicd.tf
sudo docker compose up -d --build

