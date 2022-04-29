FROM alpine

RUN apk update
RUN apk add php7 php7-fpm php7-session php7-json php7-mysqli php7-xml php7-curl php7-iconv php7-phar php7-redis php7-ctype wget php7-mysqli mariadb-client php7-iconv
RUN cd /

RUN		wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
		chmod +x wp-cli.phar && \
		mv wp-cli.phar /usr/bin/wp


COPY ./srcs/start.sh /
CMD sh ./start.sh
EXPOSE 9000
