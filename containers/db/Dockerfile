FROM postgres:12

# put the SQL DDL file into the database container
COPY ../../db/build/complete.sql /docker-entrypoint-initdb.d/complete.sql

ENV POSTGRES_USER="postgres"
ENV POSTGRES_PASSWORD="postgres"
ENV POSTGRES_DB="postgres"


