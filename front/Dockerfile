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

FROM nginx:alpine

ENV NGINX_HOST localhost
ENV NGINX_PORT 3000

COPY default.conf /etc/nginx/conf.d/default.conf

# Expose volumes
#VOLUME ["/usr/share/nginx/html", "/var/log/nginx"]

RUN \
    wget --quiet -O /tmp/docdoku-web-front.zip http://codeci.docdoku.net/job/docdoku-web-front-dev/lastStableBuild/artifact/target/docdoku-web-front.zip && \
    unzip -o -qq /tmp/docdoku-web-front.zip -d /usr/share/nginx/html

RUN chmod -R o+rx /usr/share/nginx/html

# Expose ports
EXPOSE 3000

# Entry point
ENTRYPOINT ["/usr/sbin/nginx", "-g", "daemon off;"]
