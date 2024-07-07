#!/bin/bash
set -e

# Perform initial configuration or setup here
echo "Starting Zabbix Server setup..."

# Check database connection
DB_HOST="${DB_SERVER_HOST:-localhost}"
DB_USER="${MYSQL_USER}"
DB_PASS="${MYSQL_PASSWORD}"
DB_NAME="${MYSQL_DATABASE}"

echo "Checking database connection to $DB_HOST"
until mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" -e "SHOW DATABASES;" ; do
  >&2 echo "Database is unavailable - sleeping"
  sleep 3
done

>&2 echo "Database is up - executing command"

# Optionally configure database, migrate schemas, etc.
# ...

# Start the main application (e.g., Zabbix Server)
/usr/sbin/zabbix_server -c /etc/zabbix/zabbix_server.conf

# Exec passed arguments (allows for running container with custom commands)
exec "$@"
