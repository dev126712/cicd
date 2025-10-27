#!/bin/bash

set -e

sudo apt update
sudo apt install git -y
sudo  mkdir /app && cd /app
git clone https://github.com/dev126712/cicd.git
sudo mkdir /docker
sudo mv /app/cicd/docker-compose.yml /app/docker
cd /app/docker
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
sudo docker compose up --build

