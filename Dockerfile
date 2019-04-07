FROM debian:stretch-slim

MAINTAINER kazuhito_m

RUN apt-get update && \
    apt-get install curl locales software-properties-common apt-transport-https ca-certificates gnupg2 lsb-release -y && \
    curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add - && \
    add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable" && \
    apt-get update && \
    apt-get install docker-ce -y && \
    apt-get autoremove -y && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/*

RUN curl -L https://github.com/docker/compose/releases/download/1.24.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose && \
    docker-compose --version

# タイムゾーン＆ロケール設定。
RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    locale-gen ja_JP.UTF-8
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP.UTF-8
ENV LC_ALL ja_JP.UTF-8
# 上の /etc/localtime だけでは不完全なので
RUN echo "Asia/Tokyo" > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata
# 上のlocale-genで作られるはずだが、うまく行かないので
RUN echo 'ja_JP.UTF-8 UTF-8' >> /etc/locale.gen && locale-gen

WORKDIR /workspace