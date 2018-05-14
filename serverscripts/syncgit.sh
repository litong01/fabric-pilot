#!/bin/sh
# Schedule the next run regardless
cd /home/ibmadmin/gitserver/synch
at now + 5 minute -f syncher.sh > /dev/null 2>&1

cd /home/ibmadmin/gitserver/hfrd.git
mycheck=$(git fetch 2>&1)
if [ ! -z "$mycheck" ]; then
    # Sync to the mirror git server
    eval $(ssh-agent -s)
    ssh-add /home/ibmadmin/.ssh/fd
    git push --mirror ssh://git@9.42.91.228:2222/git-server/repos/hfrd.git
    kill -9 $SSH_AGENT_PID
    echo 'Changes synced at '$(date) >> /home/ibmadmin/gitserver/synch/syncher.log

    # We have some changes, rebuild the  api server docker image
    cd /home/ibmadmin/hl/src/hfrd
    git pull
    make api-docker
    docker restart hfrdserver
fi
