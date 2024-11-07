#!/bin/bash
if ! command -v nginx &> /dev/null
then
  printf "> Installing NGINX\n"

  sudo apt update
  sudo apt install nginx

  sudo ufw allow 'Nginx Full'
  sudo ufw allow ssh

  printf "> NGINX installed successfully\n"
fi

if ! command -v node &> /dev/null
then
  printf "> Installing Node.js\n"

  curl -sL https://deb.nodesource.com/setup_20.x -o /tmp/nodesource_setup.sh
  sudo bash /tmp/nodesource_setup.sh
  sudo apt install nodejs

  printf "> Node.js environment installed successfully\n"
fi

if ! command -v yarn &> /dev/null
then
  printf "> Installing Yarn\n"

  npm i -g yarn

  printf "> Yarn installed successfully\n"
fi

if ! command -v pm2 &> /dev/null
then
  printf "> Installing PM2\n"

  npm i -g pm2

  printf "> PM2 installed successfully\n"
fi

if ! command -v docker &> /dev/null
then
  printf "> Installing Docker\n"

  sudo apt-get update
  sudo apt-get install ca-certificates curl
  sudo install -m 0755 -d /etc/apt/keyrings
  sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
  sudo chmod a+r /etc/apt/keyrings/docker.asc

  # Add the repository to Apt sources:
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt-get update

  sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

  sudo usermod -aG docker ${USER}
  newgrp docker

  printf "> Docker installed successfully\n"
fi

if ! command -v rsync &> /dev/null
then
  printf "> Installing rsync\n"

  sudo apt update
  sudo apt -y install rsync

  printf "> rsync installed successfully\n"
fi

sudo ufw enable
