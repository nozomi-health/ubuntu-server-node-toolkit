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

  curl -sL https://deb.nodesource.com/setup_16.x -o /tmp/nodesource_setup.sh
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

  sudo apt update
  sudo apt install apt-transport-https ca-certificates curl software-properties-common
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
  apt-cache policy docker-ce

  sudo apt install docker-ce
  sudo usermod -aG docker ${USER}

  printf "> Docker installed successfully\n"
fi

if ! command -v docker-compose &> /dev/null
then
  printf "> Installing docker-compose\n"

  sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose

  printf "> docker-compose installed successfully\n"
fi

if ! command -v rsync &> /dev/null
then
  printf "> Installing rsync\n"

  sudo apt update
  sudo apt -y install rsync

  printf "> rsync installed successfully\n"
fi

sudo ufw enable
