#!/bin/bash
if [ ! -d /var/spool/cron/crontabs ]
    then
    mkdir -p /var/spool/cron/crontabs
    chown root:crontab /var/spool/cron/crontabs
    chmod 1730 /var/spool/cron/crontabs
fi

if [ ! -e /var/spool/cron/crontabs/root ]
    then
    touch /var/spool/cron/crontabs/root
    chown root:crontab /var/spool/cron/crontabs/root
    chmod 600 /var/spool/cron/crontabs/root
    echo '# Min Hour Day Month DayOfWeek Command' > /var/spool/cron/crontabs/root
    echo '0 0 * * * /var/spool/cron/gacha.sh > /var/spool/cron/log/gacha.log 2>&1' >> /var/spool/cron/crontabs/root
    echo '0 * * * * /var/spool/cron/save00.sh > /var/spool/cron/log/save00.log 2>&1' >> /var/spool/cron/crontabs/root
    echo '10 * * * * /var/spool/cron/save10.sh > /var/spool/cron/log/save10.log 2>&1' >> /var/spool/cron/crontabs/root
    echo '20 * * * * /var/spool/cron/save20.sh > /var/spool/cron/log/save20.log 2>&1' >> /var/spool/cron/crontabs/root
    echo '30 * * * * /var/spool/cron/save30.sh > /var/spool/cron/log/save30.log 2>&1' >> /var/spool/cron/crontabs/root
    echo '40 * * * * /var/spool/cron/save40.sh > /var/spool/cron/log/save40.log 2>&1' >> /var/spool/cron/crontabs/root
    echo '50 * * * * /var/spool/cron/save50.sh > /var/spool/cron/log/save50.log 2>&1' >> /var/spool/cron/crontabs/root
    echo '* * * * * /var/spool/cron/test.sh > /var/spool/cron/log/test.log 2>&1' >> /var/spool/cron/crontabs/root
    echo '#!/bin/sh' > /var/spool/cron/test.sh
    echo 'echo "test run."' >> /var/spool/cron/test.sh
    chmod 700 /var/spool/cron/test.sh
fi

if [ ! -d /var/spool/cron/log ]
    then
    mkdir -p /var/spool/cron/log
    chown root:crontab /var/spool/cron/log
    chmod 700 /var/spool/cron/log
fi

tar zxf /savscripts.tar.gz

if [ ! -e /var/spool/cron/save00.sh ]
    then
    cp -p /save00.sh /var/spool/cron/save00.sh
    chmod 700 /var/spool/cron/save00.sh
fi

if [ ! -e /var/spool/cron/save10.sh ]
    then
    cp -p /save10.sh /var/spool/cron/save10.sh
    chmod 700 /var/spool/cron/save10.sh
fi

if [ ! -e /var/spool/cron/save20.sh ]
    then
    cp -p /save20.sh /var/spool/cron/save20.sh
    chmod 700 /var/spool/cron/save20.sh
fi

if [ ! -e /var/spool/cron/save30.sh ]
    then
    cp -p /save30.sh /var/spool/cron/save30.sh
    chmod 700 /var/spool/cron/save30.sh
fi

if [ ! -e /var/spool/cron/save40.sh ]
    then
    cp -p /save40.sh /var/spool/cron/save40.sh
    chmod 700 /var/spool/cron/save40.sh
fi

if [ ! -e /var/spool/cron/save50.sh ]
    then
    cp -p /save50.sh /var/spool/cron/save50.sh
    chmod 700 /var/spool/cron/save50.sh
fi

if [ ! -e /var/spool/cron/username.list ]
    then
    touch /var/spool/cron/username.list
    chmod 666 /var/spool/cron/username.list
fi

if [ ! -d /var/spool/cron/.ssh ]
    then
    mkdir -p /var/spool/cron/.ssh
    chmod 700 /var/spool/cron/.ssh
    touch /var/spool/cron/.ssh/known_hosts
    touch /var/spool/cron/.ssh/id_ecdsa
    chown root:root /var/spool/cron/.ssh/known_hosts
    chown root:root /var/spool/cron/.ssh/id_ecdsa
    chmod 600 /var/spool/cron/.ssh/known_hosts
    chmod 600 /var/spool/cron/.ssh/id_ecdsa
    echo "StrictHostKeyChecking no" > /var/spool/cron/.ssh/config
    echo "IdentityFile ~/.ssh/id_ecdsa" >> /var/spool/cron/.ssh/config
    chmod 600 /var/spool/cron/.ssh/config
fi

/usr/bin/printenv | awk '{print "export " $1}' > /env.sh
echo "<?php sleep(3600); ?> <html><head><title></title></head><body></body></html>" > /var/www/html/index.php
/usr/sbin/apachectl start

cron -l 2 -f
