FROM nginx:alpine


COPY default.conf /etc/nginx/conf.d/default.conf
COPY webapp.properties.json /webapp.properties.json

EXPOSE 10080
EXPOSE 10081

ENTRYPOINT ["/usr/sbin/nginx", "-g", "daemon off;"]
