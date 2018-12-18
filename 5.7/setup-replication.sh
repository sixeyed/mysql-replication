#!/bin/bash

echo '[setup-replication] - Starting'

if [ "x$REPLICATION_MASTER_HOST" == "x" ]; then 
  echo '[setup-replication] - Initializing master'
  /init_master.sh
else
  echo '[setup-replication] - Initializing slave'
  /init_slave.sh
fi

echo '[setup-replication] - Done'