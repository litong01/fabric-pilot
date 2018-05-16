#!/bin/bash
# When use the binary directly
#./apiserver &> log.txt &
# When start up the server as a container
docker run -d -p 8080:8080 \
  --restart unless-stopped \
  -v ${HOME}/api/var:/opt/hfrd/var \
  --name hfrdserver hfrd/server

docker run -d -p 9595:8080 \
  --restart unless-stopped \
  -e "SWAGGER_JSON=/api.json" -v ${HOME}/api/var/swagger.json:/api.json \
  --name swaggerserver swaggerapi/swagger-ui
