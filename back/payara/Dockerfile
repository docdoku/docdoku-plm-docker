# DocDoku, Professional Open Source
# Copyright 2006 - 2017 DocDoku SARL
#
# This file is part of DocDokuPLM.
#
# DocDokuPLM is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# DocDokuPLM is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with DocDokuPLM.  If not, see <http://www.gnu.org/licenses/>.
#
## DocDokuPLM server docker image dependencies
#

FROM payara/server-full:4.181

ENV IFCCONVERT_URL https://github.com/IfcOpenShell/IfcOpenShell/releases/download/v0.5.0-preview2/IfcConvert-master-9ad68db-linux64.zip
ENV DECIMATER_URL https://github.com/docdoku/docdoku-plm-openmesh-decimater/raw/master/builds/decimater-linux-64.zip
ENV MESHCONV_URL http://www.patrickmin.com/meshconv/linux64/meshconv
ENV MYSQL_CONNECTOR_URL https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.46.zip

USER root

RUN \
 apt-get update && apt-get install -y \
 freecad  \
 assimp-utils \
 libreoffice  \
 libreoffice-writer  \
 ure  \
 libreoffice-java-common  \
 libreoffice-core \
 libreoffice-common \
 fonts-opensymbol \
 hyphen-fr \
 hyphen-de \
 hyphen-en-us \
 hyphen-it \
 hyphen-ru \
 fonts-dejavu \
 fonts-dejavu-core \
 fonts-dejavu-extra \
 fonts-noto \
 fonts-dustin \
 fonts-f500 \
 fonts-fanwood  \
 fonts-freefont-ttf \
 fonts-liberation \
 fonts-lmodern  \
 fonts-lyx  \
 fonts-sil-gentium \
 fonts-texgyre  \
 fonts-tlwg-purisa

RUN \
 mkdir -p /var/lib/docdoku/vault && \
 chown -R payara:payara /var/lib/docdoku/vault && \
 mkdir -p /opt/ifcconvert && \
 mkdir -p /opt/decimater && \
 mkdir -p /opt/meshconv && \
 wget --quiet -O /opt/ifcconvert.zip ${IFCCONVERT_URL}  && \
 wget --quiet -O /opt/decimater.zip ${DECIMATER_URL} && \
 wget --quiet -O /opt/meshconv/meshconv ${MESHCONV_URL} && \
 unzip -qq /opt/ifcconvert.zip -d /opt/ifcconvert && \
 unzip -qq /opt/decimater.zip -d /opt/ && \
 rm /opt/ifcconvert.zip && \
 rm /opt/decimater.zip


RUN \
 wget --quiet -O /opt/mysql-connector-java-5.1.46.zip ${MYSQL_CONNECTOR_URL} && \
 unzip -qq /opt/mysql-connector-java-5.1.46.zip -d /opt/ && \
 mkdir -p /opt/payara41/glassfish/domains/domain1/lib/ && \
 mv /opt/mysql-connector-java-5.1.46/mysql-connector-java-5.1.46-bin.jar ${PAYARA_PATH}/glassfish/domains/domain1/lib/mysql-connector-java-5.1.46-bin.jar && \
 rm /opt/mysql-connector-java-5.1.46.zip && \
 rm -rf /opt/mysql-connector-java-5.1.46

RUN \
 chown -R payara:payara /opt

USER payara

