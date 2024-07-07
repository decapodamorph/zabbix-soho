#!/bin/bash

# Load environment variables from .env file
source /path/to/.env

# Renew the certificate
certbot renew --non-interactive

# Copy the renewed certificates to the correct location
cp /etc/letsencrypt/live/${DOMAIN_NAME}/fullchain.pem /etc/apache2/ssl/fullchain.pem
cp /etc/letsencrypt/live/${DOMAIN_NAME}/privkey.pem /etc/apache2/ssl/privkey.pem
cp /etc/letsencrypt/live/${DOMAIN_NAME}/chain.pem /etc/apache2/ssl/chain.pem

# Reload Apache to apply the new certificates
apachectl -k graceful