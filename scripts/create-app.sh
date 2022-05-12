#!/bin/bash
DOMAIN=$1
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

if [[ $DOMAIN == "" ]]
then
  printf "> Domain must be specified\n"
  exit
fi

# Domain RegExp validation
DOMAIN_REGEX="^([a-zA-Z0-9](([a-zA-Z0-9-]){0,61}[a-zA-Z0-9])?\.)+[a-zA-Z]{2,}$"
if [[ ! "$DOMAIN" =~ $DOMAIN_REGEX ]]
then
  printf "> Invalid domain\n"
  exit
fi

if ! command -v nginx &> /dev/null
then
  printf "> Nginx not found. Go through installation process first\nhttps://www.digitalocean.com/community/tutorials/how-to-install-nginx-on-ubuntu-20-04\n"
  exit
fi

printf "> Creating domain directories\n"

sudo mkdir -p /var/www/$DOMAIN/html
sudo chown -R $USER:$USER /var/www/$DOMAIN/html
sudo chmod -R 755 /var/www/$DOMAIN

sudo DOMAIN=$DOMAIN TEMPLATE=index.html node $SCRIPT_DIR/../utils/generate-template.js > /var/www/$DOMAIN/html/index.html
sudo DOMAIN=$DOMAIN TEMPLATE=nginx.conf node $SCRIPT_DIR/../utils/generate-template.js > /etc/nginx/sites-available/$DOMAIN

sudo ln -s /etc/nginx/sites-available/$DOMAIN /etc/nginx/sites-enabled/
sudo systemctl restart nginx

if ! command -v certbot &> /dev/null
then
  printf "> Let's encrypt not found. Performing install\n"

  sudo apt update
  sudo apt install certbot python3-certbot-nginx
else
  printf "> Using Let's encrypt installed in system\n"
fi

printf "> Obtaining an SSL Certificate\n"

sudo certbot --nginx --redirect -d $DOMAIN -d "www.$DOMAIN"
sudo certbot renew --dry-run

printf "Done!\n"
