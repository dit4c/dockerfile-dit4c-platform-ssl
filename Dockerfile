# DOCKER-VERSION 1.1.0
FROM dit4c/dit4c-platform-base
MAINTAINER t.dettrick@uq.edu.au

ENV DIT4C_DOMAIN "dit4c.metadata.net"

# Runner must mount a volume containing server.key & server.crt
VOLUME "/etc/ssl"

# Install Nginx and remove existing configs
RUN yum install -y nginx && rm -f /etc/nginx/nginx.conf /etc/nginx/conf.d/*

# Container vhost configs
VOLUME "/etc/nginx/conf.d"

# Install
# - Pystache for templating
# - logrotate for nginx log cleanup
# - NPM to run nginx-etcd-vhosts
RUN yum install -y pystache logrotate nodejs tar gcc-c++ git && \
  curl -L https://npmjs.org/install.sh | clean=no sh

RUN git clone https://github.com/dit4c/nginx-etcd-vhosts.git /opt/nginx-etcd-vhosts && \
  cd /opt/nginx-etcd-vhosts && npm install

ADD /etc /etc
ADD /opt /opt

RUN chmod +x /opt/*.sh

# We need to template
CMD ["/opt/run.sh"]
