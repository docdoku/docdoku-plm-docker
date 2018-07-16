FROM nginx:alpine

ARG DOMAIN
Run apk add openssl
Run mkdir /etc/nginx/ssl
RUN \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/cert.key -out /etc/nginx/ssl/cert.crt \
        -subj "/C=GB/ST=London/L=London/O=Global Security/OU=IT Department/CN=${DOMAIN}"

COPY default.conf /etc/nginx/conf.d/default.conf
COPY webapp.properties.json /webapp.properties.json

RUN sed -i -e 's/mydomain/'${DOMAIN}'/g' /webapp.properties.json

EXPOSE 10080
EXPOSE 10081

ENTRYPOINT ["/usr/sbin/nginx", "-g", "daemon off;"]
