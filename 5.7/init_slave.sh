#!/bin/bash

echo '[init_slave] - Setting up replication'

# health check
until mysql -h${REPLICATION_MASTER_HOST} --user=root --password=$MYSQL_ROOT_PASSWORD -e "select 1 from dual" | grep -q 1;
do
    >&2 echo "Replication master is unavailable - sleeping"
    sleep 1
done
>&2 echo "Replication master is up - setting slave"

# set basic master info
mysql --user=root --password=$MYSQL_ROOT_PASSWORD -e "RESET MASTER; \
    CHANGE MASTER TO \
    MASTER_HOST='$REPLICATION_MASTER_HOST', \
    MASTER_PORT=$REPLICATION_MASTER_PORT, \
    MASTER_USER='$REPLICATION_USER', \
    MASTER_PASSWORD='$REPLICATION_PASSWORD';"

# dump data from master to slave
mysqldump \
    --host=$REPLICATION_MASTER_HOST \
    --port=$REPLICATION_MASTER_PORT \
    --user=root \
    --password=$MYSQL_ROOT_PASSWORD \
    --protocol=tcp \
    --master-data=1 \
    --add-drop-database \
    --flush-logs \
    --flush-privileges \
    --all-databases \
    | mysql --user=root --password=$MYSQL_ROOT_PASSWORD

# start slave
mysql --user=root --password=$MYSQL_ROOT_PASSWORD -e "START SLAVE;"

echo '[init_slave] - Setup done'