# DOCKER-VERSION 0.3.4
# image olafradicke/docker_fedora20-tntnet
FROM fedora:20
MAINTAINER Olaf Raicke <olaf@atix.de>

ENV MYSQL-SUPPORT yes
ENV POSTGRESQL-SUPPORT yes
ENV SQLITE-SUPPORT yes
ENV REPLICATION_SUPPORT yes
ENV ORACLE-SUPPORT no


RUN yum -y install gcc-c++ make wget
RUN yum -y install libtool mysql++-devel sqlite-devel openssl-devel postgresql-devel

WORKDIR /tmp
RUN  wget www.tntnet.org/download/cxxtools-2.2.1.tar.gz
RUN  tar -xzf  cxxtools-2.2.1.tar.gz
WORKDIR /tmp/cxxtools-2.2.1
RUN /usr/bin/ls -lah
RUN  /bin/bash ./configure
RUN  make
RUN  make install

RUN  echo "/usr/local/lib" >  /etc/ld.so.conf.d/cxxtools.conf
RUN  ldconfig
RUN  rm -Rvf /tmp/cxxtools-2.2.1.tar.gz /tmp/cxxtools-2.2.1


WORKDIR /tmp/
RUN  wget www.tntnet.org/download/tntdb-1.3.tar.gz
RUN  tar -xzf  tntdb-1.3.tar.gz
WORKDIR /tmp/tntdb-1.3
RUN  /bin/bash ./configure --with-mysql=$MYSQL-SUPPORT --with-postgresql=$POSTGRESQL-SUPPORT --with-sqlite=$SQLITE-SUPPORT  --with-replication=$REPLICATION_SUPPORT --with-oracle=$ORACLE-SUPPORT
RUN  make
RUN  make install

RUN  echo "/usr/local/lib" >  /etc/ld.so.conf.d/tntdb.conf
RUN  ldconfig
RUN rm -Rvf /tmp/tntdb-1.3 /tmp/tntdb-1.3.tar.gz



RUN yum -y install  zip zlib-devel

WORKDIR /tmp
RUN  wget www.tntnet.org/download/tntnet-2.2.1.tar.gz
RUN  tar -xzf  tntnet-2.2.1.tar.gz
WORKDIR /tmp/tntnet-2.2.1
RUN /usr/bin/ls -lah
RUN  /bin/bash ./configure
RUN  make
RUN  make install

RUN  echo "/usr/local/lib" >  /etc/ld.so.conf.d/tntnet.conf
RUN  ldconfig
RUN rm -Rvf /tmp/tntnet-2.2.1 /tmp/tntnet-2.2.1.tar.gz


VOLUME ["/var/docker/tntnet/workspace/"]



