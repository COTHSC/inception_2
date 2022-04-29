FROM	alpine

RUN		apk add mariadb mariadb-client && \
		mkdir -p /run/mysqld/

COPY	/srcs/my.cnf			/etc/
COPY	/srcs/start.sh			/

EXPOSE 3306

ENTRYPOINT	sh start.sh
