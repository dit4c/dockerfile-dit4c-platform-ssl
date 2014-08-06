# DOCKER-VERSION 1.1.0
FROM dit4c/dit4c-platform-base
MAINTAINER t.dettrick@uq.edu.au

ENV DIT4C_DOMAIN "dit4c.metadata.net"

# Runner must mount a volume containing server.key & server.crt
VOLUME "/etc/ssl"

# Install Nginx and remove existing configs
RUN yum install -y nginx && rm -r /etc/nginx/nginx.conf /etc/nginx/conf.d

# Install Pystache for templating
RUN yum install -y pystache

ADD /etc /etc
ADD /opt /opt

# We need to template 
CMD ["bash", "/opt/run.sh"]