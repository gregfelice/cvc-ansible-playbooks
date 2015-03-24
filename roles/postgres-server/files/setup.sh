#!/bin/sh

#- name: configure the server
su - postgres -c "initdb -D /var/lib/pgsql/data"

su - postgres
echo "host all all 0.0.0.0/0 trust" >> /var/lib/pgsql/data/pg_hba.conf
echo "listen_addresses='*'" >> /var/lib/pgsql/data/postgresql.conf

# create user & database
/usr/bin/pg_ctl start -w -D /var/lib/pgsql/data

/usr/bin/psql --command "CREATE USER docker WITH SUPERUSER PASSWORD 'docker';"

createdb -O docker docker

/usr/bin/pg_ctl stop -w -D /var/lib/pgsql/data

/usr/bin/postgres -D /var/lib/pgsql/data


