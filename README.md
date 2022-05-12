# Node Server Toolkit

Toolkit provides following features:
  - [Setup Node environment with NGINX](#setup-node-environment-with-nginx)
  - [Create new app by domain](#create-new-app-by-domain)

## Setup Node environment with NGINX

Script installs following programs:
  - NGINX
  - Node.js
  - Yarn

#### Running

```bash
  chmod +x ./env.sh && sudo ./env.sh
```

## Create new app by domain

Script do following things:
  - Creates domain directories for NGINX
  - Generates basic files for NGINX
  - Obtains an SSL Certificate for domain

#### Running

1. Make sure Server's public IP address is linked to domain.
2. Run command below and replace `{{your-domain}}` with real domain

```bash
  chmod +x ./create-app.sh && sudo ./create-app.sh {{your-domain}}
```
