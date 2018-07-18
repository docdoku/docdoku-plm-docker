FROM nginx:alpine

ARG DOMAIN
ARG EMAIL
RUN apk update && apk add openssl
RUN mkdir /etc/nginx/ssl

COPY v3.ext /etc/nginx/ssl/v3.ext
COPY key.conf /etc/nginx/ssl/key.conf
COPY default.conf /etc/nginx/conf.d/default.conf
COPY webapp.properties.dist.json /webapp.properties.dist.json
COPY webapp.properties.app.json /webapp.properties.app.json

RUN sed -i -e 's/mydomain/'${DOMAIN}'/g' /webapp.properties.dist.json
RUN sed -i -e 's/mydomain/'${DOMAIN}'/g' /webapp.properties.app.json
RUN sed -i -e 's/mydomain/'${DOMAIN}'/g' /etc/nginx/conf.d/default.conf
RUN sed -i -e 's/mydomain/'${DOMAIN}'/g' /etc/nginx/ssl/v3.ext
RUN sed -i -e 's/mydomain/'${DOMAIN}'/g' /etc/nginx/ssl/key.conf
RUN sed -i -e 's/myemail/'${EMAIL}'/g' /etc/nginx/ssl/key.conf

RUN cat /etc/nginx/ssl/*
RUN openssl genrsa -des3 -passout pass:"changeit" -out /etc/nginx/ssl/rootCA.key 2048
RUN openssl req -x509 -new -nodes -passin pass:"changeit" -key /etc/nginx/ssl/rootCA.key -sha256 -days 1024 -out /etc/nginx/ssl/rootCA.pem -subj "/C=GB/ST=London/L=London/O=Global Security/OU=IT Department/CN=${DOMAIN}"
RUN openssl req -new -sha256 -nodes  -passin pass:"changeit" -out /etc/nginx/ssl/cert.crt -newkey rsa:2048 -keyout /etc/nginx/ssl/cert.key -config /etc/nginx/ssl/key.conf
RUN openssl x509 -req -passin pass:"changeit" -in /etc/nginx/ssl/cert.crt -CA /etc/nginx/ssl/rootCA.pem -CAkey /etc/nginx/ssl/rootCA.key -CAcreateserial -out /etc/nginx/ssl/cert.crt -days 500 -sha256 -extfile /etc/nginx/ssl/v3.ext

ENTRYPOINT ["/usr/sbin/nginx", "-g", "daemon off;"]
