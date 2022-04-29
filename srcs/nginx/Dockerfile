FROM alpine

RUN apk update
RUN apk add openssh
RUN apk add openssl
RUN apk add nginx

RUN adduser -D user
RUN echo "user:password:"|chpasswd
RUN ssh-keygen -A
RUN yes "" | openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/certs/localhost.key -out /etc/ssl/certs/localhost.crt

COPY ./srcs/start.sh /
CMD sh ./start.sh
