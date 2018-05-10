#!/bin/sh
# Schedule the next run regardless
cd /home/ibmadmin/gitserver/synch
at now + 5 minute -f thesync.sh > next.log 2>&1

cd /home/ibmadmin/hl/src/hfrd
if git diff-index --quiet HEAD --; then
    # No changes
    echo 'no changes found' >> /home/ibmadmin/gitserver/synch/next.log
else
    # We have some changes, rebuild the  api server docker image
    git pull
    make api-docker
    docker restart hfrdserver
    # Sync to the mirror git server
    eval $(ssh-agent -s)
    ssh-add /home/ibmadmin/.ssh/fd
    cd /home/ibmadmin/gitserver/hfrd.git
    git fetch
    git push --mirror ssh://git@9.42.91.228:2222/git-server/repos/hfrd.git
    kill -9 $SSH_AGENT_PID
fi
