# DocDokuPLM MySQL build

FROM mysql:5.7.15

ENV MYSQL_DATABASE=docdokuplm \
    MYSQL_ROOT_PASSWORD=password

# Add to init scripts
ADD init.sql /docker-entrypoint-initdb.d

