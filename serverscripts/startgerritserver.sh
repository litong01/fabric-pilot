#!/bin/bash
# this starts gerrit server using development mode
docker run -d -p 9090:8080 -p 29418:29418 \
  --restart unless-stopped \
  -v /home/ibmadmin/gerrit/gerrit_vol:/var/gerrit/review_site \
  -e AUTH_TYPE=DEVELOPMENT_BECOME_ANY_ACCOUNT \
  --name gerrit openfrontier/gerrit
