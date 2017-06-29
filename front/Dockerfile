FROM nginx:alpine

ENV NGINX_HOST localhost
ENV NGINX_PORT 3000

COPY default.conf /etc/nginx/conf.d/default.conf

# Expose volumes
VOLUME ["/usr/share/nginx/html", "/var/log/nginx"]

# Expose ports
EXPOSE 3000

# Entry point
ENTRYPOINT ["/usr/sbin/nginx", "-g", "daemon off;"]
