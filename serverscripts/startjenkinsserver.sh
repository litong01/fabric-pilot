#!/bin/bash
# create a directory for jenkins_home 
# 
docker run -d -p 9090:8080 -p 50000:50000 \
  --restart unless-stopped \
  -v /home/ibmadmin/jenkins/jenkins_home:/var/jenkins_home \
  --name jenkins jenkins/jenkins:lts
