FROM debian:stable-slim
MAINTAINER Romain Luyten 

ENV DEBIAN_FRONTEND noninteractive

# setup workdir
RUN mkdir -p /root/work/
WORKDIR /root/work/

# install git
RUN apt-get -y update && apt-get -y install git && apt-get install -y build-essential debhelper libssh2-1-dev && apt-get source curl && apt-get build-dep -y curl && cd curl-* && DEB_BUILD_OPTIONS=nocheck dpkg-buildpackage && cd .. &&  dpkg -i curl*.deb libcurl3-nss*.deb libcurl4-doc*.deb libcurl4-openssl*.deb libcurl3_*.deb && apt-get install git-ftp

# slim down image
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/man/?? /usr/share/man/??_*

# run a CMD to show git is installed
CMD git help
