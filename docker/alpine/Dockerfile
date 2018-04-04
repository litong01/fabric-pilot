# Docker-in-Docker Jenkins Slave
#
# See: https://github.com/litong01/fabric-pilot
#
FROM docker:dind

RUN set -eux; \
    apk add --no-cache --update python3 bash \
    nodejs nodejs-npm py-virtualenv \
    && rm -rf /var/cache/apk/*

VOLUME /var/lib/docker
EXPOSE 2375

ENTRYPOINT ["dockerd-entrypoint.sh"]
CMD []
