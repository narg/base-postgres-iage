############################################################
# Dockerfile to build NARG Postgres Image
# Based on NARG Base Image
############################################################

# Set the image
FROM narg/postgres-docker-image:1.0 

MAINTAINER Necip Arg

# Install Postgres Repository
RUN yum install -y http://yum.postgresql.org/9.4/redhat/rhel-6-x86_64/pgdg-redhat94-9.4-1.noarch.rpm

# Install PostgreSQL Server and Contrib
RUN yum install -y postgresql94-server postgresql94-contrib

#  Instal PostgreSQL plpython package
RUN yum install -y postgresql94-plpython

# Install PostgreSQL database adapter for Python
RUN yum install -y python-psycopg2

# Clean up YUM
RUN yum clean all

# Initialize DB data files
RUN su - postgres -c '/usr/pgsql-9.4/bin/initdb -D /var/lib/pgsql/9.4/data'

# Set permissions to allow logins, trust the bridge
RUN echo "host    all             all             0.0.0.0/0            md5" >> /var/lib/pgsql/9.4/data/pg_hba.conf

#listen on all interfaces
RUN echo "listen_addresses='*'" >> /var/lib/pgsql/9.4/data/postgresql.conf

# Expose the PostgreSQL port
EXPOSE 5432
