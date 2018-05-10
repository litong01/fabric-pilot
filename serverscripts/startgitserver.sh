docker run -d -p 2222:22 \
  --restart unless-stopped \
  -v /home/ibmadmin/gitserver/repos:/git-server/repos \
  -v /home/ibmadmin/gitserver/keys:/git-server/keys \
  --name gitserver jkarlos/git-server-docker
