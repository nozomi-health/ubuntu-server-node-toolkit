#!/bin/bash
if ! command -v nginx &> /dev/null
then
  printf "> Installing NGINX\n"

  sudo apt update
  sudo apt install nginx

  sudo ufw allow 'Nginx Full'

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
