FROM mysql/mysql-server:5.7

ENV SERVER_ID="1" \
    REPLICATION_USER="repl" \
    REPLICATION_PASSWORD="test" \
    REPLICATION_MASTER_HOST="" \
    REPLICATION_MASTER_PORT="3306"

COPY *.cnf \
     init_*.sh \
     /

COPY docker-entrypoint.sh /entrypoint.sh
COPY setup-replication.sh /docker-entrypoint-initdb.d/

RUN chmod +x /entrypoint.sh \
             /docker-entrypoint-initdb.d/setup-replication.sh \
             /init_master.sh /init_slave.sh