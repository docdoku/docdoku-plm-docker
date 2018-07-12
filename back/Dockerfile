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
## DocDokuPLM server docker image based on docdokuplm:payara (base image with system dependencies)
#

FROM docdokuplm:payara

ARG DOCDOKU_PLM_CODEBASE
ARG HEAP_SIZE

ENV ASADMIN_PATH ${PAYARA_PATH}/bin
ENV DOMAIN_DIR ${PAYARA_PATH}/glassfish/domains/domain1
ENV JWT_ENABLED true
ENV JWT_KEY MyVerySecretPhrase
ENV SESSION_ENABLED false
ENV BASIC_AUTH_ENABLED false
ENV VAULT_PATH /var/lib/docdoku/vault
ENV DATABASE_USER docdokuplm_user
ENV DATABASE_PWD changeit
ENV DATABASE_URL "jdbc:mysql://db:3306/docdokuplm"
ENV ES_SERVER_URI http://es:9200
ENV ES_SERVER_SHARDS 4
ENV ES_SERVER_AUTO_EXPAND_REPLICAS "0-3"
ENV ES_SERVER_REPLICAS 0
ENV ES_SERVER_PWD changeme
ENV ES_SERVER_USERNAME elastic
#ENV ES_SERVER_AWS_SERVICE
#ENV ES_SERVER_AWS_REGION
#ENV ES_SERVER_AWS_KEY
#ENV ES_SERVER_AWS_SECRET
ENV OFFICE_HOME /usr/lib/libreoffice
ENV OFFICE_PORT 8100
ENV KEYSTORE_LOCATION /opt/payara41/dplm.jceks
ENV KEYSTORE_KEY_ALIAS mykey
ENV KEYSTORE_PASS changeit
ENV KEYSTORE_KEY_PASS changeit
ENV KEYSTORE_TYPE JCEKS
ENV NATIVE_LIBS /opt/native-libs
ENV SOLIDWORKS_LICENSE_PATH /opt/plugins/solidworks/license.txt
ENV SOLIDWORKS_SCHEMA_PATH /opt/plugins/solidworks/schema
ENV CATIA_LICENSE_PATH /opt/plugins/catia/license.txt

RUN \
 keytool -genseckey -storetype JCEKS -keyalg AES -keysize 256 -keystore ${KEYSTORE_LOCATION} -storepass ${KEYSTORE_PASS} -keypass ${KEYSTORE_KEY_PASS}

RUN \
 echo 'AS_ADMIN_PASSWORD='admin'\n\
EOF\n'\
>> /opt/pwdfile && \
 ${ASADMIN_PATH}/asadmin start-domain domain1 && \
 ${ASADMIN_PATH}/asadmin --user admin  --passwordfile=/opt/pwdfile --host localhost --port 4848 enable-secure-admin && \
 ${ASADMIN_PATH}/asadmin --user admin  --passwordfile=/opt/pwdfile create-custom-resource --restype java.util.Properties --factoryclass org.glassfish.resources.custom.factory.PropertiesFactory --property="" docdokuplm.config && \
 ${ASADMIN_PATH}/asadmin --user admin  --passwordfile=/opt/pwdfile create-custom-resource --restype java.util.Properties --factoryclass org.glassfish.resources.custom.factory.PropertiesFactory --property="" auth.config && \
 ${ASADMIN_PATH}/asadmin --user admin  --passwordfile=/opt/pwdfile create-custom-resource --restype java.util.Properties --factoryclass org.glassfish.resources.custom.factory.PropertiesFactory --property="" security.config && \
 ${ASADMIN_PATH}/asadmin --user admin  --passwordfile=/opt/pwdfile create-custom-resource --restype java.util.Properties --factoryclass org.glassfish.resources.custom.factory.PropertiesFactory --property="" elasticsearch.config && \
 ${ASADMIN_PATH}/asadmin --user admin  --passwordfile=/opt/pwdfile create-custom-resource --restype java.util.Properties --factoryclass org.glassfish.resources.custom.factory.PropertiesFactory --property="" office.config && \
 ${ASADMIN_PATH}/asadmin --user admin  --passwordfile=/opt/pwdfile create-jdbc-connection-pool --restype javax.sql.ConnectionPoolDataSource --datasourceclassname com.mysql.jdbc.jdbc2.optional.MysqlConnectionPoolDataSource --property="" DocDokuPLMPool && \
 ${ASADMIN_PATH}/asadmin --user admin  --passwordfile=/opt/pwdfile create-jdbc-resource --connectionpoolid DocDokuPLMPool jdbc/docdokuPU && \
 ${ASADMIN_PATH}/asadmin --user admin  --passwordfile=/opt/pwdfile create-jvm-options -Dfile.encoding=UTF-8 && \
 ${ASADMIN_PATH}/asadmin --user admin  --passwordfile=/opt/pwdfile delete-jvm-options '-Xmx512m' && \
 ${ASADMIN_PATH}/asadmin --user admin  --passwordfile=/opt/pwdfile create-jvm-options -Xmx${HEAP_SIZE} && \
 ${ASADMIN_PATH}/asadmin --user admin  --passwordfile=/opt/pwdfile create-javamail-resource --mailhost localhost --mailuser myUser --fromaddress myUser@localhost mail/docdokuSMTP && \
 ${ASADMIN_PATH}/asadmin --user admin  --passwordfile=/opt/pwdfile set server.network-config.protocols.protocol.http-listener-1.http.upload-timeout-enabled=false && \
 ${ASADMIN_PATH}/asadmin --user admin  --passwordfile=/opt/pwdfile set server.network-config.protocols.protocol.http-listener-1.http.connection-upload-timeout-millis=-1 && \
 ${ASADMIN_PATH}/asadmin --user admin  --passwordfile=/opt/pwdfile set resources.jdbc-connection-pool.DocDokuPLMPool.property.URL=${DATABASE_URL} && \
 ${ASADMIN_PATH}/asadmin --user admin  --passwordfile=/opt/pwdfile set resources.jdbc-connection-pool.DocDokuPLMPool.property.user=${DATABASE_USER} && \
 ${ASADMIN_PATH}/asadmin --user admin  --passwordfile=/opt/pwdfile set resources.jdbc-connection-pool.DocDokuPLMPool.property.password=${DATABASE_PWD} && \
 ${ASADMIN_PATH}/asadmin --user admin  --passwordfile=/opt/pwdfile set resources.custom-resource.docdokuplm.config.property.vaultPath=${VAULT_PATH} && \
 ${ASADMIN_PATH}/asadmin --user admin  --passwordfile=/opt/pwdfile set resources.custom-resource.docdokuplm.config.property.codebase=${DOCDOKU_PLM_CODEBASE} && \
 ${ASADMIN_PATH}/asadmin --user admin  --passwordfile=/opt/pwdfile set resources.custom-resource.auth.config.property."jwt\.enabled"=${JWT_ENABLED} && \
 ${ASADMIN_PATH}/asadmin --user admin  --passwordfile=/opt/pwdfile set resources.custom-resource.auth.config.property."jwt\.key"=${JWT_KEY} && \
 ${ASADMIN_PATH}/asadmin --user admin  --passwordfile=/opt/pwdfile set resources.custom-resource.auth.config.property."session\.enabled"=${SESSION_ENABLED} && \
 ${ASADMIN_PATH}/asadmin --user admin  --passwordfile=/opt/pwdfile set resources.custom-resource.auth.config.property."basic\.header\.enabled"=${BASIC_AUTH_ENABLED} && \
 ${ASADMIN_PATH}/asadmin --user admin  --passwordfile=/opt/pwdfile set resources.custom-resource.elasticsearch.config.property.serverUri=${ES_SERVER_URI} && \
 ${ASADMIN_PATH}/asadmin --user admin  --passwordfile=/opt/pwdfile set resources.custom-resource.elasticsearch.config.property.number_of_shards=${ES_SERVER_SHARDS} && \
 ${ASADMIN_PATH}/asadmin --user admin  --passwordfile=/opt/pwdfile set resources.custom-resource.elasticsearch.config.property.auto_expand_replicas=${ES_SERVER_AUTO_EXPAND_REPLICAS} && \
 ${ASADMIN_PATH}/asadmin --user admin  --passwordfile=/opt/pwdfile set resources.custom-resource.elasticsearch.config.property.number_of_replicas=${ES_SERVER_REPLICAS} && \
 ${ASADMIN_PATH}/asadmin --user admin  --passwordfile=/opt/pwdfile set resources.custom-resource.elasticsearch.config.property.password=${ES_SERVER_PWD} && \
 ${ASADMIN_PATH}/asadmin --user admin  --passwordfile=/opt/pwdfile set resources.custom-resource.elasticsearch.config.property.username=${ES_SERVER_USERNAME} && \
 ${ASADMIN_PATH}/asadmin --user admin  --passwordfile=/opt/pwdfile set resources.custom-resource.elasticsearch.config.property.awsService=${ES_SERVER_AWS_SERVICE} && \
 ${ASADMIN_PATH}/asadmin --user admin  --passwordfile=/opt/pwdfile set resources.custom-resource.elasticsearch.config.property.awsRegion=${ES_SERVER_AWS_REGION} && \
 ${ASADMIN_PATH}/asadmin --user admin  --passwordfile=/opt/pwdfile set resources.custom-resource.elasticsearch.config.property.awsAccessKey=${ES_SERVER_AWS_KEY} && \
 ${ASADMIN_PATH}/asadmin --user admin  --passwordfile=/opt/pwdfile set resources.custom-resource.elasticsearch.config.property.awsSecretKey=${ES_SERVER_AWS_SECRET} && \
 ${ASADMIN_PATH}/asadmin --user admin  --passwordfile=/opt/pwdfile set resources.custom-resource.office.config.property.office_home=${OFFICE_HOME} && \
 ${ASADMIN_PATH}/asadmin --user admin  --passwordfile=/opt/pwdfile set resources.custom-resource.office.config.property.office_port=${OFFICE_PORT} && \
 ${ASADMIN_PATH}/asadmin --user admin  --passwordfile=/opt/pwdfile set resources.custom-resource.security.config.property.keystoreLocation=${KEYSTORE_LOCATION} && \
 ${ASADMIN_PATH}/asadmin --user admin  --passwordfile=/opt/pwdfile set resources.custom-resource.security.config.property.keystorePass=${KEYSTORE_PASS} && \
 ${ASADMIN_PATH}/asadmin --user admin  --passwordfile=/opt/pwdfile set resources.custom-resource.security.config.property.keyAlias=${KEYSTORE_KEY_ALIAS} && \
 ${ASADMIN_PATH}/asadmin --user admin  --passwordfile=/opt/pwdfile set resources.custom-resource.security.config.property.keystoreType=${KEYSTORE_TYPE} && \
 ${ASADMIN_PATH}/asadmin --user admin  --passwordfile=/opt/pwdfile set resources.custom-resource.security.config.property.keyPass=${KEYSTORE_KEY_PASS} && \
 ${ASADMIN_PATH}/asadmin --user admin  --passwordfile=/opt/pwdfile set server.java-config.native-library-path-prefix=${NATIVE_LIBS} && \
 ${ASADMIN_PATH}/asadmin --user admin  --passwordfile=/opt/pwdfile create-custom-resource --restype java.lang.String --factoryclass org.glassfish.resources.custom.factory.PrimitivesAndStringFactory --property value=${SOLIDWORKS_LICENSE_PATH} datakit/solidworks/licensePath && \
 ${ASADMIN_PATH}/asadmin --user admin  --passwordfile=/opt/pwdfile create-custom-resource --restype java.lang.String --factoryclass org.glassfish.resources.custom.factory.PrimitivesAndStringFactory --property value=${SOLIDWORKS_SCHEMA_PATH} datakit/solidworks/schemaDir && \
 ${ASADMIN_PATH}/asadmin --user admin  --passwordfile=/opt/pwdfile create-custom-resource --restype java.lang.String --factoryclass org.glassfish.resources.custom.factory.PrimitivesAndStringFactory --property value=${CATIA_LICENSE_PATH} datakit/catia/licensePath && \
 ${ASADMIN_PATH}/asadmin --user admin  --passwordfile=/opt/pwdfile stop-domain && \
 rm /opt/pwdfile

ENTRYPOINT ${ASADMIN_PATH}/asadmin start-domain --debug true -v domain1

