#!/bin/sh
# Schedule the next run regardless
cd ${HOME}/gitserver/synch
at now + 5 minute -f syncgit.sh > /dev/null 2>&1

cd ${HOME}/gitserver/hfrd.git
mycheck=$(git fetch 2>&1)
if [ ! -z "$mycheck" ]; then
    mycheck=$(echo $mycheck | grep 'fatal: unable to access')

    if [ ! -z "$mycheck" ]; then
        echo 'Connection problem at '$(date) >> ${HOME}/gitserver/synch/syncgit.log
        exit
    fi

    # Sync to the mirror git server
    eval $(ssh-agent -s)
    ssh-add ${HOME}/.ssh/fd
    git push --mirror ssh://git@9.42.91.228:2222/git-server/repos/hfrd.git
    kill -9 $SSH_AGENT_PID
    echo 'Changes synced on '$(date) >> ${HOME}/gitserver/synch/syncgit.log

    # We have some changes, rebuild the  api server docker image
    cd ${HOME}/hl/src/hfrd
    git pull
    make api-docker
    docker restart hfrdserver

    # Update the swagger server
    cp api/swagger.yaml ${HOME}/api/var
    docker run -v ${HOME}/api/var:/docs swaggerapi/swagger-codegen-cli generate \
      -i /docs/swagger.yaml -l swagger -o /docs
    docker restart swaggerserver
fi
