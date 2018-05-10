#!/bin/bash
# When use the binary directly
#./apiserver &> log.txt &
# When start up the server as a container
docker run -d -p 8080:8080 \
  --restart unless-stopped \
  -v /home/ibmadmin/api/var:/opt/hfrd/var \
  --name hfrdserver hfrd/api
