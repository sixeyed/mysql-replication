#!/bin/bash

echo '[init_master] - Setting up replication user'

# create user for replication
mysql --user=root --password=$MYSQL_ROOT_PASSWORD -e "GRANT \
    REPLICATION SLAVE, \
    REPLICATION CLIENT \
    ON *.* \
    TO '$REPLICATION_USER'@'%' \
    IDENTIFIED BY '$REPLICATION_PASSWORD'; \
    FLUSH PRIVILEGES;"

echo '[init_master] - Setup done'