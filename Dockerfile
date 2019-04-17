FROM centos
MAINTAINER acgrid

ARG CMAKE_VERSION=3.14.2

ENV TERM=linux
ENV BUILD_ASSETS_DIR=/var/lib/builder

WORKDIR ${BUILD_ASSETS_DIR}

ADD build-env.sh /etc/profile.d/
ADD install.sh .
RUN chmod +x ${BUILD_ASSETS_DIR}/install.sh && ${BUILD_ASSETS_DIR}/install.sh

CMD /bin/bash