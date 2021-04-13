 
TOKEN=$(oc whoami --show-token)
SERVER=$(oc whoami --show-server )

gh secret set OPENSHIFT_SERVER -b $SERVER
gh secret set OPENSHIFT_TOKEN -b $TOKEN
