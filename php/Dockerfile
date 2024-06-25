FROM ubuntu:24.04
## for apt to be noninteractive
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true
## preesed tzdata, update package index, upgrade packages and install needed software
RUN echo "tzdata tzdata/Areas select Australia" > /tmp/preseed.txt; \
    echo "tzdata tzdata/Zones/Australia select Adelaide" >> /tmp/preseed.txt; \
    debconf-set-selections /tmp/preseed.txt && \
    apt-get update && \
    apt-get install -y tzdata

RUN apt install -y php php-zip php-mysqlnd php-soap php-intl php-opcache php-xdebug
RUN apt install -y apache2
#RUN apt intsall -y libapache2-mod-proxy
#RUN apt install -y libapache2-mod-proxy-fcgi
RUN a2enmod proxy proxy_fcgi
#RUN a2dismod php8.3
COPY ./test.conf /etc/apache2/site-enabled/
RUN mkdir /xdebug_logs
RUN chmod 777 /xdebug_logs
COPY xdebug.ini /etc/php/8.3/apache2/conf.d/20-xdebug.ini
# Not expose the port, need to run the publish command
EXPOSE 80
EXPOSE 443
#export XDEBUG_CONFIG="client_host=192.168.42.34 log=/tmp/xdebug.log"
ENTRYPOINT ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
