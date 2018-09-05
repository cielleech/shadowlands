FROM alpine:3.8

LABEL maintainer="cielleech <cielleech@outlook.com>"

ENV JAVA_HOME=/usr/local/java/current \
    PATH=${PATH}:/apps/svr/java/current/bin

RUN apk add --no-cache --update openssh && \
    cd /root/ && wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.28-r0/glibc-2.28-r0.apk && \
    apk add glibc-2.28-r0.apk && \
    wget ftp://biguser:www.jb51.net@gw.datiw.com:8021/201704/tools/jdk-linux-x64.tar.gz && \
    mkdir -p /apps/svr/java && tar xvf jdk-linux-x64.tar.gz -C /apps/svr/java && \
    ln -s /apps/svr/java/jdk1.8.0_131 /apps/svr/java/current && \
    rm /root/glibc-2.28-r0.apk