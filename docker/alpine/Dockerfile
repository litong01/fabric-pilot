# Docker-in-Docker Fabric Test Container
#
# See: https://github.com/litong01/fabric-pilot
#
FROM docker:dind

RUN set -eux; \
    apk add --no-cache --update python3 bash \
    nodejs nodejs-npm py-virtualenv go curl \
    && curl -fsSL https://clis.ng.bluemix.net/install/linux | sh \
    && rm -rf /var/cache/apk/*

VOLUME /var/lib/docker
EXPOSE 2375

ENTRYPOINT ["dockerd-entrypoint.sh"]
CMD []
