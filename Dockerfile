FROM php:7.4.0-apache-buster
LABEL maintainer="ccmite"
WORKDIR /

COPY savscripts.tar.gz /
COPY mcrcon /usr/bin/
COPY entrypoint.sh /

RUN : "add package" && \
    apt --allow-releaseinfo-change update && apt install -y \
    screen \
    sudo \
    iproute2 \
    locales \
    ssh \
    dnsutils \
    whois \
    mtr \
    cron \
    && apt-get clean && rm -rf /var/lib/apt/lists/* && \
    echo "www-data ALL=NOPASSWD: ALL" >> /etc/sudoers && \
    sed -i 's/# ja_JP.UTF-8 UTF-8/ja_JP.UTF-8 UTF-8/g' /etc/locale.gen && \
    locale-gen ja_JP.UTF-8 && \
    update-locale LANG=ja_JP.UTF-8 && \
    rm -f /etc/localtime && \
    ln -s /usr/share/zoneinfo/Japan /etc/localtime && \
    echo "Asia/Tokyo" > /etc/timezone && \
    echo "nicname 43/tcp whois" >> /etc/services && \
    echo "nicname 43/udp whois" >> /etc/services && \
    echo '[Date]' > /usr/local/etc/php/php.ini  && \
    echo 'date.timezone = "Asia/Tokyo"' >> /usr/local/etc/php/php.ini && \
    chmod +x /usr/bin/mcrcon && \
    chmod +x /entrypoint.sh

ENV MC_INSTANCE_NAME="paper" MC_SRVIP="jve" MC_SSH="/usr/bin/ssh" MC_SSHPORT="22" MC_USER="root" MC_RCON="/usr/bin/mcrcon" MC_RCONPORT="25575" MC_RCONPASS="SecretPassword"

#ENTRYPOINT ["tail", "-f", "/dev/null"]
ENTRYPOINT ["sh", "/entrypoint.sh"]
EXPOSE 80
