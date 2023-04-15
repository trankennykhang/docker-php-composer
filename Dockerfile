FROM php:latest
COPY ./composer /usr/local/bin/
RUN apt update
RUN apt install -y libzip-dev
RUN apt install unzip
RUN apt install -y libxml2-dev
RUN docker-php-ext-install zip
RUN docker-php-ext-install soap
RUN pecl install xdebug && docker-php-ext-enable xdebug
COPY ./xdebug.ini /usr/local/etc/php/conf.d/
COPY ./error_reporting.ini /usr/local/etc/php/conf.d/
# install xdebug later
#RUN docker-php-ext-install xdebug
#RUN docker-php-ext-enable xdebug
RUN docker-php-ext-install intl
EXPOSE 9000
# Docker run command 
# docker run -it --mount type=bind,source="$(pwd)",target=/var/www/html -P 9000:9000 trankennykhang/php bash 
ENTRYPOINT [ "tail", "-f", "/dev/null" ]
