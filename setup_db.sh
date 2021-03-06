VIDISPINE_DB_NAME="vidispine"
VIDISPINE_DB_USER="vidispine"
VIDISPINE_DB_PASS="vidispine"
VIDISPINE_DB_ENCODING="UTF8"
VIDISPINE_DB_LC_COLLATE="en_US.UTF-8"
VIDISPINE_DB_LC_CTYPE="en_US.UTF-8"
VIDISPINE_DB_TEMPLATE="template0"


gosu postgres postgres --single <<- EOSQL
    CREATE USER ${VIDISPINE_DB_USER} WITH PASSWORD '${VIDISPINE_DB_PASS}'
    CREATE DATABASE ${VIDISPINE_DB_NAME} WITH OWNER ${VIDISPINE_DB_USER} ENCODING '${VIDISPINE_DB_ENCODING}' LC_COLLATE = '${VIDISPINE_DB_LC_COLLATE}' LC_CTYPE = '${VIDISPINE_DB_LC_CTYPE}' TEMPLATE = ${VIDISPINE_DB_TEMPLATE};
    GRANT ALL PRIVILEGES on DATABASE ${VIDISPINE_DB_NAME} TO ${VIDISPINE_DB_USER};
    ALTER USER ${VIDISPINE_DB_USER} WITH SUPERUSER;
EOSQL