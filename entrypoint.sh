#!/bin/bash

# Function to obtain SSL certificates
obtain_certificates() {
  # Stop Apache to free up port 80 for Certbot
  apachectl stop

  # Obtain Let's Encrypt certificate
  certbot certonly --standalone -d ${DOMAIN_NAME} --non-interactive --agree-tos --email ${EMAIL}

  # Copy the obtained certificates to the correct location
  cp /etc/letsencrypt/live/${DOMAIN_NAME}/fullchain.pem /etc/apache2/ssl/fullchain.pem
  cp /etc/letsencrypt/live/${DOMAIN_NAME}/privkey.pem /etc/apache2/ssl/privkey.pem
  cp /etc/letsencrypt/live/${DOMAIN_NAME}/chain.pem /etc/apache2/ssl/chain.pem

  # Start Apache again
  apachectl start
}

# Check if SSL certificates exist
if [ ! -f /etc/apache2/ssl/fullchain.pem ] || [ ! -f /etc/apache2/ssl/privkey.pem ]; then
  # Prompt for domain name and email for Let's Encrypt
  read -p "Enter domain name for Zabbix (e.g., zabbix.example.com): " DOMAIN_NAME
  read -p "Enter your email address for Let's Encrypt: " EMAIL

  # Obtain SSL certificates
  obtain_certificates
fi

# Start cron daemon
crond

# Start Apache
httpd -D FOREGROUND