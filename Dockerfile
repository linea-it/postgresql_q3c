# FROM alpine

FROM postgres:9.6

MAINTAINER Glauber Costa Vila Verde <glauber.vila.verde@gmail.com>

# Q3C Release https://github.com/segasai/q3c/releases
ENV Q3C_VERSION=v1.6.0
ENV Q3C_DIR=q3c-1.6.0

RUN apt-get update && apt-get install -y \
		gcc \
		make \
		postgresql-server-dev-9.6 \
		curl \
		unzip \
	&& rm -rf /var/lib/apt/lists/*

RUN curl -O https://codeload.github.com/segasai/q3c/zip/$Q3C_VERSION \
	&& mv $Q3C_VERSION q3c.zip \
	&& unzip q3c.zip \
	&& rm q3c.zip

# Install q3c
RUN cd $Q3C_DIR \
	&& make \
	&& make install \
	&& echo "CREATE EXTENSION q3c;" > q3c.sql \
	&& echo "SELECT q3c_version();" >> q3c.sql \
	&& mv q3c.sql /docker-entrypoint-initdb.d 
