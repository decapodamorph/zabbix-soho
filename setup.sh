#!/bin/bash

# Prompt for MySQL credentials
read -p "Enter MYSQL_ROOT_PASSWORD: " MYSQL_ROOT_PASSWORD
read -p "Enter MYSQL_DATABASE: " MYSQL_DATABASE
read -p "Enter MYSQL_USER: " MYSQL_USER
read -p "Enter MYSQL_PASSWORD: " MYSQL_PASSWORD

# Prompt for Zabbix Admin password
read -p "Enter ZABBIX_PASSWORD for Admin user: " ZABBIX_PASSWORD

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