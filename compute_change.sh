
DELTA=changed_directories
git diff --name-only HEAD HEAD~1 | grep -v deploy > $DELTA

export CHANGE_ANY=false
if grep services/fib-go $DELTA
then
    export CHANGE_FIB_GO=true
    export CHANGE_ANY=true
else
    export CHANGE_FIB_GO=false
fi
if grep  services/fib-node $DELTA
then
    export CHANGE_FIB_NODE=true
    export CHANGE_ANY=true
else
    export CHANGE_FIB_NODE=false
fi
if grep services/fib-quarkus $DELTA
then
    export CHANGE_FIB_QUARKUS=true
    export CHANGE_ANY=true
else
    export CHANGE_FIB_QUARKUS=false
fi
if grep services/haproxy $DELTA
then
    export CHANGE_HAPROXY=true
    export CHANGE_ANY=true
else
    export CHANGE_HAPROXY=false
fi
if grep services/frontend $DELTA
then
    export CHANGE_FRONTEND=true
    export CHANGE_ANY=true
else
    export CHANGE_FRONTEND=false
fi

echo Files Changed
cat $DELTA 
rm -rf $DELTA

echo "CHANGE_FIB_GO=${CHANGE_FIB_GO}" | tee -a $GITHUB_ENV 
echo "CHANGE_FIB_NODE=${CHANGE_FIB_NODE}" | tee -a $GITHUB_ENV 
echo "CHANGE_FIB_QUARKUS=${CHANGE_FIB_QUARKUS}" | tee -a $GITHUB_ENV 
echo "CHANGE_FRONTEND=${CHANGE_FRONTEND}" | tee -a $GITHUB_ENV 
echo "CHANGE_HAPROXY=${CHANGE_HAPROXY}" | tee -a $GITHUB_ENV 
echo "CHANGE_ANY=${CHANGE_ANY}" | tee -a $GITHUB_ENV 