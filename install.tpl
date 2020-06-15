#!/bin/bash

echo "${nginx}" > /tmp/nginx.conf
echo "${pact_broker}" > /tmp/pact-broker.sh
echo "${rack}" > /tmp/rack.conf
echo "${gemfile}" > /tmp/Gemfile
echo "${upstart}" > /tmp/upstar.conft
echo "${nginx_upstart}" > /tmp/nginx-upstart.conf

echo "export DB_HOST=${DB_HOST}" > /tmp/postgres_vars 
echo "export DB_NAME=${DB_NAME}" >> /tmp/postgres_vars
echo "export DB_USERNAME=${DB_USERNAME}" >> /tmp/postgres_vars
echo "export DB_PASSWORD=${DB_PASSWORD}" >> /tmp/postgres_vars
echo "export DB_URL=postgres://${DB_USERNAME}:${DB_PASSWORD}@${DB_HOST}/${DB_NAME}" >> /tmp/postgres_vars

mkdir /tmp/scripts
echo "${install}" > /tmp/scripts/install.sh
echo "${server_install}" > /tmp/scripts/server.sh
echo "${service_install}" > /tmp/scripts/service.sh
 
