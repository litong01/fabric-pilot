FROM nexus3.hyperledger.org:10001/hyperledger/fabric-tools:x86_64-1.1.0-rc1

ENV GOPATH /opt/gopath
ENV GOROOT /opt/go
ENV BASERUN /opt

WORKDIR /opt

COPY fabric-sdk-node $BASERUN/gopath/src/github.com/hyperledger/fabric-test/fabric-sdk-node
COPY .git $BASERUN/gopath/src/github.com/hyperledger/fabric-test/.git
COPY tools/PTE $BASERUN/gopath/src/github.com/hyperledger/fabric-test/fabric-sdk-node/test/PTE

COPY testcases.sh $BASERUN/testcases.sh

Entrypoint ["sh", "-c", "./testcases.sh"]
