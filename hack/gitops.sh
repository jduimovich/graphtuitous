script_dir=$(dirname "$0") 

oc apply -R -f $script_dir/../gitops   
