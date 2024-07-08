#!/bin/bash

# Prompt for MySQL credentials and hide input for passwords
read -sp "Enter MYSQL_ROOT_PASSWORD: " MYSQL_ROOT_PASSWORD
echo
read -sp "Enter MYSQL_PASSWORD: " MYSQL_PASSWORD
echo

# Prompt for Zabbix Admin password and hide input
read -sp "Enter ZABBIX_PASSWORD for Admin user: " ZABBIX_PASSWORD
echo

# Write to .env file
cat <<EOL > .env
MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
MYSQL_DATABASE=zabbix
MYSQL_USER=zabbix
MYSQL_PASSWORD=${MYSQL_PASSWORD}
ZABBIX_PASSWORD=${ZABBIX_PASSWORD}
EOL

# Build and start Docker Compose services
docker-compose up --build -d