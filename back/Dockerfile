FROM docdokuplm:payara

COPY ./payara/domain.xml /opt/payara41/glassfish/domains/domain1/config/domain.xml
RUN sed -i "s@DOCDOKU_PLM_CODEBASE@$DOCDOKU_PLM_CODEBASE@g" /opt/payara41/glassfish/domains/domain1/config/domain.xml

RUN echo 'AS_ADMIN_PASSWORD='admin'\n\
EOF\n'\
>> /opt/pwdfile && \
 /opt/payara41/bin/asadmin start-domain domain1 && \
 /opt/payara41/bin/asadmin --user admin  --passwordfile=/opt/pwdfile --host localhost --port 4848 enable-secure-admin && \
 /opt/payara41/bin/asadmin stop-domain domain1 && \
 rm /opt/pwdfile


ENTRYPOINT /opt/payara41/bin/asadmin start-domain --debug true -v domain1

