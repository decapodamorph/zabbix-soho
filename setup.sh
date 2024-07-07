#!/bin/bash

# Prompt for MySQL credentials and hide input for passwords
read -sp "Enter MYSQL_ROOT_PASSWORD: " MYSQL_ROOT_PASSWORD
echo
read -p "Enter MYSQL_DATABASE: " MYSQL_DATABASE
read -p "Enter MYSQL_USER: " MYSQL_USER
read -sp "Enter MYSQL_PASSWORD: " MYSQL_PASSWORD
echo

# Prompt for Zabbix Admin password and hide input
read -sp "Enter ZABBIX_PASSWORD for Admin user: " ZABBIX_PASSWORD
echo

# Write to .env file
cat <<EOL > .env
MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
MYSQL_DATABASE=${MYSQL_DATABASE}
MYSQL_USER=${MYSQL_USER}
MYSQL_PASSWORD=${MYSQL_PASSWORD}
ZABBIX_PASSWORD=${ZABBIX_PASSWORD}
EOL

# Build and start Docker Compose services
docker-compose up --build -d