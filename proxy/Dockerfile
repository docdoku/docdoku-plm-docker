FROM nginx:alpine

ARG SERVER_NAME
ARG SERVER_PORT

COPY default.conf default.conf

RUN \
 envsubst '$SERVER_NAME $SERVER_PORT' < default.conf > /etc/nginx/conf.d/default.conf && \
 rm default.conf

COPY webapp.properties.json /webapp.properties.json

EXPOSE ${SERVER_PORT}

ENTRYPOINT ["/usr/sbin/nginx", "-g", "daemon off;"]
