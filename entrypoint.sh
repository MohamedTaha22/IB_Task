#!/bin/bash
# entrypoint.sh

# Function to wait for Elasticsearch to be up
wait_for_elasticsearch() {
  echo "Waiting for Elasticsearch..."
  until curl -s http://elasticsearch:9200/; do
    sleep 1
  done
  echo "Elasticsearch is up."
}

# Function to wait for MySQL to be up
wait_for_mysql() {
  echo "Waiting for MySQL..."
  # Adjust MYSQL_HOST, MYSQL_PORT, MYSQL_USER, and MYSQL_PASSWORD as needed
  until mysql -h"db" -P"3306" -u"user" -p"password" -e"SELECT 1"; do
    sleep 1
  done
  echo "MySQL is up."
}

# Wait for Elasticsearch and MySQL
wait_for_elasticsearch
wait_for_mysql

echo "All dependencies are up - executing command"

bundle exec rake db:migrate

# Execute the main container command.
exec "$@"
