FROM ubuntu:latest

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
  && apt-get dist-upgrade -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install sphinxsearch \
  lsb-release apt-utils software-properties-common cron \
  supervisor postfix rsyslog \
  -y

  
ADD files /

# /var/log/cron.log ownership and perms from /etc/rsyslog.conf

RUN sed -e "s/#cron/cron/g" < /etc/rsyslog.d/50-default.conf > /etc/rsyslog.d/50-default.conf \  
 && echo "*/1 * * * * indexer --config /usr/local/etc/sphinx.conf --all --verbose --rotate" | crontab - \
 && touch /var/log/cron.log && chown syslog:adm /var/log/cron.log && chmod 0640 /var/log/cron.log

ENTRYPOINT ["sh", "/entrypoint.sh"]

  
