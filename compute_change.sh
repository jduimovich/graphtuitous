git diff --name-only HEAD HEAD~1 > changed_directories

export CHANGE_ANY=false
if grep fib-go changed_directories
then
    export CHANGE_FIB_GO=true
    export CHANGE_ANY=true
else
    export CHANGE_FIB_GO=false
fi
if grep  fib-node changed_directories
then
    export CHANGE_FIB_NODE=true
    export CHANGE_ANY=true
else
    export CHANGE_FIB_NODE=false
fi
if grep fib-quarkus changed_directories
then
    export CHANGE_FIB_QUARKUS=true
    export CHANGE_ANY=true
else
    export CHANGE_FIB_QUARKUS=false
fi
if grep haproxy changed_directories
then
    export CHANGE_HAPROXY=true
    export CHANGE_ANY=true
else
    export CHANGE_HAPROXY=false
fi
if grep fib-go changed_directories
then
    export CHANGE_FRONTEND=true
    export CHANGE_ANY=true
else
    export CHANGE_FRONTEND=false
fi

echo CHANGE_FIB_GO  $CHANGE_FIB_GO
echo CHANGE_FIB_NODE  $CHANGE_FIB_NODE
echo CHANGE_FIB_QUARKUS  $CHANGE_FIB_QUARKUS
echo CHANGE_FRONTEND $CHANGE_FRONTEND
echo CHANGE_HAPROXY $CHANGE_HAPROXY

echo CHANGE_ANY $CHANGE_ANY
