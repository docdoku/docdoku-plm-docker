FROM payara/server-full

ENV IFCCONVERT_URL https://github.com/IfcOpenShell/IfcOpenShell/releases/download/v0.5.0-preview2/IfcConvert-master-9ad68db-linux64.zip
ENV DECIMATER_URL https://github.com/docdoku/docdoku-plm-openmesh-decimater/raw/master/builds/decimater-linux-64.zip
ENV MESHCONV_URL http://www.patrickmin.com/meshconv/linux64/meshconv
ARG DOCDOKU_PLM_CODEBASE

COPY mysql-connector-java-5.1.42-bin.jar /opt/payara41/glassfish/domains/domain1/lib/mysql-connector-java-5.1.42-bin.jar
COPY domain.xml /opt/payara41/glassfish/domains/domain1/config/domain.xml

USER root

RUN \
 apt-get update && \ 
 apt-get install -y freecad assimp-utils libreoffice libreoffice-writer ure libreoffice-java-common libreoffice-core libreoffice-common fonts-opensymbol hyphen-fr hyphen-de hyphen-en-us hyphen-it hyphen-ru fonts-dejavu fonts-dejavu-core fonts-dejavu-extra fonts-noto fonts-dustin fonts-f500 fonts-fanwood fonts-freefont-ttf fonts-liberation fonts-lmodern fonts-lyx fonts-sil-gentium fonts-texgyre fonts-tlwg-purisa

RUN \
 mkdir -p /opt/ifcconvert && \
 mkdir -p /opt/decimater && \
 mkdir -p /opt/meshconv && \
 wget --quiet -O /opt/ifcconvert.zip $IFCCONVERT_URL  && \
 wget --quiet -O /opt/decimater.zip $DECIMATER_URL && \
 wget --quiet -O /opt/meshconv/meshconv $MESHCONV_URL && \
 unzip -qq /opt/ifcconvert.zip -d /opt/ifcconvert && \
 unzip -qq /opt/decimater.zip -d /opt/decimater && \
 rm /opt/decimater.zip && \
 rm /opt/ifcconvert.zip

RUN \
 mkdir -p /var/lib/docdoku/vault && \
 chown -R payara:payara /var/lib/docdoku/vault && \
 chown -R payara:payara /opt

USER payara

