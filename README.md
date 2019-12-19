This docker image provides a scheduling server.


# To simply use the latest stable version, run
docker run -d -v /opt/minecraft/save:/var/spool/cron -v  /opt/minecraft/servers:/opt/minecraft --name sav ccmite/sav


# Example Docker Compose app

* docker-compose.yml

<pre>
version: '2'
services:
# Save Server ###################################################
  sav:
    image: ccmite/sav:latest
    container_name: sav
    hostname: sav
    tty: true
    restart: always
    ports:
      - '0.0.0.0:8444:80'
    volumes:
      - '/opt/minecraft/servers:/opt/minecraft'
      - '/opt/minecraft/backup:/var/spool/cron'
      - '/var/run/docker.sock:/var/run/docker.sock'
      - '/opt/docker-compose:/opt/docker-compose'
    environment:
      LANG: ja-JP.UTF-8
      MC_INSTANCE_NAME: paper
      MC_SRVIP: jve
      MC_SSH: /usr/bin/ssh
      MC_SSHPORT: 22
      MC_USER: root
      MC_RCON: /usr/bin/mcrcon
      MC_RCONPORT: 25575
      MC_RCONPASS: do_not_copy_and_paste
    mem_limit: 256m
</pre>
