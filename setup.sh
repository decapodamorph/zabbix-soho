#!/bin/bash

# Prompt for MySQL credentials
read -p "Enter MYSQL_ROOT_PASSWORD: " MYSQL_ROOT_PASSWORD
read -p "Enter MYSQL_DATABASE: " MYSQL_DATABASE
read -p "Enter MYSQL_USER: " MYSQL_USER
read -p "Enter MYSQL_PASSWORD: " MYSQL_PASSWORD

# Prompt for Zabbix Admin password
read -p "Enter ZABBIX_PASSWORD for Admin user: " ZABBIX_PASSWORD

# Prompt for Let's Encrypt details
read -p "Enter domain name for Zabbix (e.g., zabbix.example.com): " DOMAIN_NAME
read -p "Enter your email address for Let's Encrypt: " EMAIL

# Write to .env file
cat <<EOL > .env
MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
MYSQL_DATABASE=${MYSQL_DATABASE}
MYSQL_USER=${MYSQL_USER}
MYSQL_PASSWORD=${MYSQL_PASSWORD}
ZABBIX_PASSWORD=${ZABBIX_PASSWORD}
DOMAIN_NAME=${DOMAIN_NAME}
EMAIL=${EMAIL}
EOL

# Install Certbot
apt-get update
apt-get install -y certbot

# Obtain Let's Encrypt certificate
certbot certonly --standalone -d ${DOMAIN_NAME} --non-interactive --agree-tos --email ${EMAIL}

# Create SSL directory if not exists
mkdir -p ./ssl

# Copy the obtained certificates
cp /etc/letsencrypt/live/${DOMAIN_NAME}/fullchain.pem ./ssl/
cp /etc/letsencrypt/live/${DOMAIN_NAME}/privkey.pem ./ssl/
cp /etc/letsencrypt/live/${DOMAIN_NAME}/chain.pem ./ssl/

# Build and start Docker Compose services
docker-compose up --build -d